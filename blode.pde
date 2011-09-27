import processing.net.*;

class Blode {
  Client tcp; 
  PApplet main;
  
  int lineBreak = 10;
  final String address = "10.10.10.2";
  final int port = 8001;

  
  Blode(PApplet p) {
    this.main = p;
    this.tcp = new Client(this.main,
                          this.address,
                          this.port);

    this.tcp.write("[\"info\"]\r\n");
  }

  boolean readMessage() {
    String rawData;
    if(this.tcp.available() > 0) {
      rawData = this.tcp.readStringUntil(this.lineBreak);
      if(rawData == null)
        return false;
      return true;
    }
    return false;
  }

  int readMessages(){
    int count = 0;
    int start_time = millis();
    while (millis() - start_time < 10)
      if (readMessage())
        count ++;
      else
        return count;
    return count;
  }

  //Product parseMessage(String m) {
  //  try {
  //    JSONObject message = new JSONObject(m);
  //    int product_id = message.getInt("product_viewed");
  //    String name =  message.getString("product_sku");
  //    String url = message.getString("product_image");
  //    return new Product(product_id, name, url);
  //  } catch (JSONException e) { 
  //    return null;
  //  }
  //}

}

