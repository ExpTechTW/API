public static String Post(JsonObject Jsondata)  {
        String data = Jsondata.toString();
        URL url = null;
        try {
            url = new URL("http://150.117.110.118:10150/");
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        HttpURLConnection http = null;
        try {
            assert url != null;
            http = (HttpURLConnection)url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            assert http != null;
            http.setRequestMethod("POST");
        } catch (ProtocolException e) {
            e.printStackTrace();
        }
        http.setDoOutput(true);
        http.setConnectTimeout(5000);
        http.setRequestProperty("Authorization", "Bearer mt0dgHmLJMVQhvjpNXDyA83vA_PxH23Y");
        http.setRequestProperty("Content-Type", "application/json");
        byte[] out = data.getBytes(StandardCharsets.UTF_8);
        OutputStream stream = null;
        try {
            stream = http.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            assert stream != null;
            stream.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String inputLine;
        StringBuilder response = new StringBuilder();
        try {
            if(http.getResponseCode() == 200){
                BufferedReader in = new BufferedReader(new InputStreamReader(http.getInputStream()));
                while ((inputLine = in .readLine()) != null) {
                    response.append(inputLine);
                } in .close();
            }else {
                System.out.println("API service did not respond");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        http.disconnect();
        JsonElement jsonElement = new JsonParser().parse(response.toString());
        JsonObject jsonObject = jsonElement.getAsJsonObject();
        if(Objects.equals(jsonObject.get("state").getAsString(), "Error")){
            System.out.println("There seems to be something wrong");
            System.out.println("[response] "+jsonObject.get("response").getAsString());
        }
        return response.toString();
    }
