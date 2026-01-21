const DOMAIN_URL = "https://raw.githubusercontent.com/ExpTechTW/API/refs/heads/main/resource/domain";

type Type = "lb" | "core";
type Service = "api" | "static";
type Region = "tpe1" | "khh1" | "tyo1" | "tnn1";

let urls: string[] = [];

// 初始化：從遠端獲取端點列表
const init = async () => {
  const res = await fetch(DOMAIN_URL);
  const text = await res.text();
  urls = text.match(/(?<=\* ).+/g) ?? [];
  return urls;
};

// 取得所有 URL
const getAll = () => urls;

// 篩選
const get = (type?: Type, service?: Service, region?: Region | null) =>
  urls.filter((u) => {
    if (type && !u.includes(`.${type}`)) return false;
    if (service && !u.startsWith(`${service}.`)) return false;
    if (region === null && /-\w+\./.test(u)) return false; // 只要主入口
    if (region && !u.includes(`-${region}.`)) return false;
    return true;
  });

// 取單一端點
const getOne = (type: Type, service: Service, region?: Region | null) =>
  get(type, service, region)[0];

// 取所有地區節點（排除主入口，健康檢查用）
const getRegions = (type?: Type, service?: Service) =>
  urls.filter((u) => {
    if (!/-\w+\./.test(u)) return false; // 排除主入口
    if (type && !u.includes(`.${type}`)) return false;
    if (service && !u.startsWith(`${service}.`)) return false;
    return true;
  });

// ===== 使用範例 =====

(async () => {
  await init();
  
  console.log("所有:", getAll());
  console.log("LB API 主入口:", getOne("lb", "api", null));
  console.log("Core API 東京:", getOne("core", "api", "tyo1"));
  console.log("LB Static 全部:", get("lb", "static"));
  console.log("所有 API:", get(undefined, "api"));
  console.log("所有 Core:", get("core"));
  console.log("所有地區節點:", getRegions());
  console.log("LB API 地區節點:", getRegions("lb", "api"));
})();
