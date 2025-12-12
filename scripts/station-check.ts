import * as fs from 'fs';
import * as path from 'path';

interface StationRecord {
  loc_code: string;
  id: string;
  lat: number;
  lon: number;
  floor: number;
  code: string;
  net: string;
  time: string;
  work: number;
}

function parseCSVLine(line: string): string[] {
  const values: string[] = [];
  let current = '';
  let inQuotes = false;
  
  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    
    if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === ',' && !inQuotes) {
      values.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  values.push(current.trim());
  
  return values;
}

function parseCSV(filePath: string): StationRecord[] {
  const content = fs.readFileSync(filePath, 'utf-8');
  const lines = content.trim().split('\n').filter(line => line.trim() !== '');
  
  if (lines.length < 2) {
    throw new Error('CSV 文件至少需要標題行和一行數據');
  }
  
  const headers = parseCSVLine(lines[0]);
  const records: StationRecord[] = [];
  
  for (let i = 1; i < lines.length; i++) {
    const values = parseCSVLine(lines[i]);
    
    if (values.length !== headers.length) {
      throw new Error(`第 ${i + 1} 行欄位數量不匹配: 期望 ${headers.length} 個欄位，實際 ${values.length} 個欄位`);
    }
    
    const record: any = {};
    headers.forEach((header, index) => {
      record[header] = values[index];
    });
    
    const lat = parseFloat(record.lat);
    const lon = parseFloat(record.lon);
    const floor = parseInt(record.floor, 10);
    const work = parseInt(record.work, 10);
    
    if (isNaN(lat)) {
      throw new Error(`第 ${i + 1} 行: lat 無法解析為數字: ${record.lat}`);
    }
    if (isNaN(lon)) {
      throw new Error(`第 ${i + 1} 行: lon 無法解析為數字: ${record.lon}`);
    }
    if (isNaN(floor)) {
      throw new Error(`第 ${i + 1} 行: floor 無法解析為整數: ${record.floor}`);
    }
    if (isNaN(work)) {
      throw new Error(`第 ${i + 1} 行: work 無法解析為整數: ${record.work}`);
    }
    
    records.push({
      loc_code: record.loc_code,
      id: record.id,
      lat,
      lon,
      floor,
      code: record.code,
      net: record.net,
      time: record.time,
      work
    });
  }
  
  return records;
}

function validateDate(dateStr: string): { valid: boolean; error?: string } {
  // 解析時間格式 YYYY-MM-DD 或 YYYY-MM-DD HH:mm:ss
  const dateMatch = dateStr.match(/^(\d{4})-(\d{2})-(\d{2})(?:\s+(\d{2}):(\d{2}):(\d{2}))?$/);
  if (!dateMatch) {
    return { valid: false, error: `時間格式錯誤: ${dateStr}` };
  }
  
  const year = parseInt(dateMatch[1], 10);
  const month = parseInt(dateMatch[2], 10);
  const day = parseInt(dateMatch[3], 10);
  
  // 創建 UTC+8 時間（台灣時間）
  const date = new Date(`${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}T00:00:00+08:00`);
  
  if (isNaN(date.getTime())) {
    return { valid: false, error: `無效的日期: ${dateStr}` };
  }
  
  // 檢查不能是未來時間
  const now = new Date();
  const nowUTC8 = new Date(now.toLocaleString('en-US', { timeZone: 'Asia/Taipei' }));
  const today = new Date(nowUTC8.getFullYear(), nowUTC8.getMonth(), nowUTC8.getDate());
  const recordDate = new Date(year, month - 1, day);
  
  if (recordDate > today) {
    return { valid: false, error: `時間不能是未來: ${dateStr}` };
  }
  
  return { valid: true };
}

function validateRecords(records: StationRecord[]): { valid: boolean; errors: string[] } {
  const errors: string[] = [];
  
  // 檢查 7: id 不能重複
  const idMap = new Map<string, number[]>();
  records.forEach((record, index) => {
    if (!idMap.has(record.id)) {
      idMap.set(record.id, []);
    }
    idMap.get(record.id)!.push(index + 2);
  });
  idMap.forEach((lineNumbers, id) => {
    if (lineNumbers.length > 1) {
      errors.push(`id 重複: ${id} (出現在第 ${lineNumbers.join(', ')} 行)`);
    }
  });
  
  // 檢查 2: loc_code 不能重複
  const locCodeMap = new Map<string, number[]>();
  records.forEach((record, index) => {
    if (!locCodeMap.has(record.loc_code)) {
      locCodeMap.set(record.loc_code, []);
    }
    locCodeMap.get(record.loc_code)!.push(index + 2);
  });
  locCodeMap.forEach((lineNumbers, locCode) => {
    if (lineNumbers.length > 1) {
      errors.push(`loc_code 重複: ${locCode} (出現在第 ${lineNumbers.join(', ')} 行)`);
    }
  });
  
  // 檢查 1: 同一個 id 不能有兩個 work=1
  const idWorkMap = new Map<string, number>();
  records.forEach((record, index) => {
    if (record.work === 1) {
      if (idWorkMap.has(record.id)) {
        errors.push(`第 ${index + 2} 行: id ${record.id} 已經有 work=1 的記錄`);
      }
      idWorkMap.set(record.id, index + 2);
    }
  });
  
  // 檢查其他欄位
  records.forEach((record, index) => {
    const lineNum = index + 2;
    
    // 檢查 3: lat 範圍 10.3 < 正常 < 26.5
    if (record.lat <= 10.3 || record.lat >= 26.5) {
      errors.push(`第 ${lineNum} 行: lat 超出範圍 (10.3 < ${record.lat} < 26.5)`);
    }
    
    // 檢查 4: lng 範圍 114 < 正常 < 122.2
    if (record.lon <= 114 || record.lon >= 122.2) {
      errors.push(`第 ${lineNum} 行: lng 超出範圍 (114 < ${record.lon} < 122.2)`);
    }
    
    // 檢查 5: 時間必須是 YYYY-MM-DD UTC+8 不能是未來時間
    const dateValidation = validateDate(record.time);
    if (!dateValidation.valid) {
      errors.push(`第 ${lineNum} 行: ${dateValidation.error}`);
    }
    
    // 檢查 6: floor 必須是正整數
    if (!Number.isInteger(record.floor) || record.floor <= 0) {
      errors.push(`第 ${lineNum} 行: floor 必須是正整數，當前值: ${record.floor}`);
    }
    
    // 檢查 8: code 1 || 2 || 3 三選一
    if (record.code !== '1' && record.code !== '2' && record.code !== '3') {
      errors.push(`第 ${lineNum} 行: code 必須是 1、2 或 3，當前值: ${record.code}`);
    }
  });
  
  return {
    valid: errors.length === 0,
    errors
  };
}

function main() {
  const csvPath = path.join(__dirname, '../resource/station-dev.csv');
  
  if (!fs.existsSync(csvPath)) {
    console.error(`錯誤: 找不到文件 ${csvPath}`);
    process.exit(1);
  }
  
  try {
    const records = parseCSV(csvPath);
    
    if (records.length === 0) {
      console.error('錯誤: CSV 文件為空或沒有數據行');
      process.exit(1);
    }
    
    const validation = validateRecords(records);
    
    if (!validation.valid) {
      console.error('檢查失敗，發現以下錯誤:');
      validation.errors.forEach(error => {
        console.error(`  - ${error}`);
      });
      process.exit(1);
    }
    
    console.log('檢查通過！所有記錄都符合要求。');
    process.exit(0);
  } catch (error) {
    console.error('檢查過程中發生錯誤:', error);
    process.exit(1);
  }
}

main();

