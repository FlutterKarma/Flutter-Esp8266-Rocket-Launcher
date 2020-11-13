
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
ESP8266WebServer server(80);




#define relayPIN  D3




void setup() {

  //WiFi-Setup
  Serial.begin(9600);
  WiFi.begin("SSID", "PASSWORD");
  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println();

  Serial.print("Connected, IP address: ");
  Serial.println(WiFi.localIP());

  //Server-Setup
  server.on("/status", HTTP_POST, handleStatus);
  server.onNotFound(handle404);
  
  server.begin();
   // power-up safety delay
    pinMode(relayPIN, OUTPUT);
  digitalWrite(relayPIN, HIGH);
    
    
}


void loop()
{
    server.handleClient();

}










void handleStatus(){
  String bulboff ="0";
  if (!server.hasArg("bulb") || server.arg("bulb") == NULL  ){
        server.send(400, "text/plain", "400: Invalid Request");
        return;
      }

if(    server.arg("bulb")== bulboff){
  
  digitalWrite(relayPIN, HIGH);
  
  
  
  }else{

digitalWrite(relayPIN, LOW);
  Serial.println("Current Flowing");
  delay(4000); 
  
  // Normally Open configuration, send HIGH signal stop current flow
  // (if you're usong Normally Closed configuration send LOW signal)
  digitalWrite(relayPIN, HIGH);
  Serial.println("Current not Flowing");
  delay(4000);
    
  }



   Serial.println(server.arg("bulb"));
  server.send(200);
}

void handle404(){
  server.send(404, "text/plain", "404: Not found");
}
