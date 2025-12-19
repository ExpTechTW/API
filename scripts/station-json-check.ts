import * as fs from 'fs';
import * as path from 'path';

interface StationRecord {
  loc_code: string;
  id: string;
  lat: number;
  lon: number;
  code: string;
  net: string;
  time: string;
  work: boolean;
}

interface StationInfo {
  code: number;
  lat: number;
  lon: number;
  time: string;
}

interface StationData {
  net: string;
  info: StationInfo[];
  work: boolean;
}

interface StationJson {
  [id: string]: StationData;
}

function parseJSON(filePath: string): { records: StationRecord[]; jsonData: StationJson } {
  const content = fs.readFileSync(filePath, 'utf-8');
  
  // 在解析 JSON 之前檢查重複的 id key（因為 JSON.parse 會讓後面的值覆蓋前面的值）
  // 匹配格式: "id": { 或 "id":\s*{
  const idPattern = /"([^"]+)"\s*:\s*\{/g;
  const idMatches: string[] = [];
  let match;
  
  while ((match = idPattern.exec(content)) !== null) {
    idMatches.push(match[1]);
  }
  
  // 檢查重複的 id
  const idCount = new Map<string, number[]>();
  idMatches.forEach((id, index) => {
    if (!idCount.has(id)) {
      idCount.set(id, []);
    }
    idCount.get(id)!.push(index + 1);
  });
  
  const duplicateIds: string[] = [];
  idCount.forEach((positions, id) => {
    if (positions.length > 1) {
      duplicateIds.push(`${id} (出現在第 ${positions.join(', ')} 個位置)`);
    }
  });
  
  if (duplicateIds.length > 0) {
    throw new Error(`發現重複的 id:\n  ${duplicateIds.join('\n  ')}`);
  }
  
  const jsonData: StationJson = JSON.parse(content);
  
  const records: StationRecord[] = [];
  
  for (const [id, stationData] of Object.entries(jsonData)) {
    // 檢查 net 不能是 ES-Net
    if (stationData.net === 'ES-Net') {
      throw new Error(`id ${id} 的 net 不能是 ES-Net`);
    }
    
    // 每個 info 項目成為一個記錄
    for (const info of stationData.info) {
      records.push({
        loc_code: id, // 使用 id 作為 loc_code
        id: id,
        lat: info.lat,
        lon: info.lon,
        code: info.code.toString(),
        net: stationData.net, // 直接使用原始 net 值
        time: info.time,
        work: stationData.work // 直接使用 boolean 值
      });
    }
  }
  
  return { records, jsonData };
}

function validateDate(dateStr: string): { valid: boolean; error?: string } {
  // 解析時間格式必須是 YYYY-MM-DD
  const dateMatch = dateStr.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  if (!dateMatch) {
    return { valid: false, error: `時間格式必須是 YYYY-MM-DD，當前值: ${dateStr}` };
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
  
  // 檢查 7: id 不能重複（在 JSON 中，id 是唯一的 key，已在 parseJSON 中檢查，這裡為了與 CSV 版本一致保留）
  // 注意：在 JSON 中，同一個 id 可以有多個 info，所以同一個 id 會有多筆記錄是正常的
  
  // 檢查 1: 在 JSON 中，同一個 id 的所有記錄共享同一個 work 值（由結構保證），所以不需要檢查「同一個 id 不能有兩個 work=true」
  
  // 額外檢查：同一個 id 下，code + time 的組合不能重複（JSON 特有）
  const codeTimeMap = new Map<string, { code: string; time: string; id: string; recordNumbers: number[] }>();
  records.forEach((record, index) => {
    const key = `${record.id}::${record.code}::${record.time}`;
    if (!codeTimeMap.has(key)) {
      codeTimeMap.set(key, { code: record.code, time: record.time, id: record.id, recordNumbers: [] });
    }
    codeTimeMap.get(key)!.recordNumbers.push(index + 1);
  });
  codeTimeMap.forEach((info, key) => {
    if (info.recordNumbers.length > 1) {
      errors.push(`id ${info.id} 下 code + time 組合重複: code=${info.code}, time=${info.time} (出現在第 ${info.recordNumbers.join(', ')} 筆記錄)`);
    }
  });
  
  // 檢查其他欄位
  records.forEach((record, index) => {
    const recordNum = index + 1;
    
    // 檢查 3: lat 範圍 10.3 < 正常 < 26.5（如果 code = 0 則跳過）
    if (record.code !== '0') {
      if (record.lat <= 10.3 || record.lat >= 26.5) {
        errors.push(`第 ${recordNum} 筆記錄: lat 超出範圍 (10.3 < ${record.lat} < 26.5)`);
      }
      
      // 檢查 4: lng 範圍 114 < 正常 < 122.2（如果 code = 0 則跳過）
      if (record.lon <= 114 || record.lon >= 122.2) {
        errors.push(`第 ${recordNum} 筆記錄: lng 超出範圍 (114 < ${record.lon} < 122.2)`);
      }
    }
    
    // 檢查 5: 時間必須是 YYYY-MM-DD 格式，不能是未來時間
    const dateValidation = validateDate(record.time);
    if (!dateValidation.valid) {
      errors.push(`第 ${recordNum} 筆記錄: ${dateValidation.error}`);
    }
    
    // 檢查 net 必須是 SE-Net 或 MS-Net（不能是 ES-Net）
    if (record.net !== 'SE-Net' && record.net !== 'MS-Net') {
      errors.push(`第 ${recordNum} 筆記錄: net 必須是 SE-Net 或 MS-Net，當前值: ${record.net}`);
    }
  });
  
  return {
    valid: errors.length === 0,
    errors
  };
}

function main() {
  const jsonPath = path.join(__dirname, '../resource/station-dev.json');
  
  if (!fs.existsSync(jsonPath)) {
    console.error(`錯誤: 找不到文件 ${jsonPath}`);
    process.exit(1);
  }
  
  try {
    const { records, jsonData } = parseJSON(jsonPath);
    
    if (records.length === 0) {
      console.error('錯誤: JSON 文件為空或沒有數據');
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
    
    // 如果檢查通過，將壓縮後的 JSON 寫入 station.json
    const outputPath = path.join(__dirname, '../resource/station.json');
    const compressedJson = JSON.stringify(jsonData);
    fs.writeFileSync(outputPath, compressedJson, 'utf-8');
    
    console.log('檢查通過！所有記錄都符合要求。');
    console.log(`已將壓縮後的 JSON 寫入 ${outputPath}`);
    process.exit(0);
  } catch (error) {
    console.error('檢查過程中發生錯誤:', error);
    process.exit(1);
  }
}

main();

