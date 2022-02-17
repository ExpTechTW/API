$APIkey="放入你的 API Key";
$FormatVersion=1;

function post($Data){
$url = "http://150.117.110.118:10150/";    
$curl = curl_init($url);
$json=json_decode($Data,true);
$json["APIkey"]=$GLOBALS["APIkey"];
$json["FormatVersion"]=$GLOBALS["FormatVersion"];
$data=json_encode($json);
curl_setopt($curl, CURLOPT_HEADER, false);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
curl_close($curl);
return curl_exec($curl);
 }
