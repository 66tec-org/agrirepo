#include <ESP8266WiFi.h>
#include "DHT.h"


#define DHTPIN D1
#define DHTTYPE DHT22
#define LDRPIN D0
#define MOISTUREPIN D3
#define RELAYMODULE4CH_PIN_IN1  D4  //pump
#define RELAYMODULE4CH_PIN_IN2  D5  //humidifier
#define RELAYMODULE4CH_PIN_IN3  D6  //fans
#define RELAYMODULE4CH_PIN_IN4  D7  //bulb


const int RELAY_PIN = D8;
 
int RelayModule4chPins[] = { RELAYMODULE4CH_PIN_IN1, RELAYMODULE4CH_PIN_IN2, RELAYMODULE4CH_PIN_IN3, RELAYMODULE4CH_PIN_IN4 };
 
const char* ssid     = "Rasheeda-Cottage";
const char* password = "92466860";
const char* host = "portal.agritech.gq";
DHT dht(DHTPIN, DHTTYPE);

void setup() {
    pinMode(RELAY_PIN, OUTPUT);
    pinMode(RELAYMODULE4CH_PIN_IN1, OUTPUT); 
    pinMode(RELAYMODULE4CH_PIN_IN2, OUTPUT);
    pinMode(RELAYMODULE4CH_PIN_IN3, OUTPUT);
    pinMode(RELAYMODULE4CH_PIN_IN4, OUTPUT);

  Serial.begin(115200);
  dht.begin();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  
  WiFi.begin(ssid, password); 
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
 
  Serial.println("");
  Serial.println("WiFi connected");  
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.print("Netmask: ");
  Serial.println(WiFi.subnetMask());
  Serial.print("Gateway: ");
  Serial.println(WiFi.gatewayIP());




  
}
void loop() {

for (int i = 0; i < 4; i++) { 
  Serial.println("checking");

    digitalWrite(RelayModule4chPins[i],LOW);
  delay(500);
    digitalWrite(RelayModule4chPins[i],HIGH);
  
    }

  
for (int i = 0; i < 4; i++) { 
    digitalWrite(RelayModule4chPins[i],HIGH);
    }
  
  float moisture_percentage;
  int sensor_digital ;
  int ldr_value;
  ldr_value = analogRead(LDRPIN);
  Serial.println(ldr_value);

  sensor_digital = digitalRead(MOISTUREPIN);   //soil moisture
  Serial.println(sensor_digital);

  
  float h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!");
  }
   Serial.println("humidity");
    Serial.println(h);
    Serial.println("temperature");
    Serial.println(t);


  
  if (ldr_value >= 500){
    Serial.println("light intensity low assuming night turning off the pump");
      for (int i = 0; i < 4; i++) { 
    digitalWrite(RelayModule4chPins[i],HIGH);
    }
      Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
 String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("light_Intensity1") + "&component_value="+ String("LOW")+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

   Serial.print("connecting to ");
  Serial.println(host);

//  WiFiClient client;
//  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
   url = "/insertstream.php?component_name=" + String("temperature_1") + "&component_value="+ String(t)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

    }
   if (ldr_value <= 499){
    Serial.println("light intensity High assuming daylight turning on the pump");
    digitalWrite(RelayModule4chPins[0],LOW);

     Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
 String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("pump_1") + "&component_value="+ String("ON")+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

    delay(30000); //pump on for 5 minutes 

    digitalWrite(RelayModule4chPins[0],HIGH);
    Serial.println("pump going to sleep for 30 minutes");

    

    
    delay(1800000);
    }

    if (t < 25 ){
    Serial.println("Temperature low turning on bulbs and  heat systems");
    digitalWrite(RelayModule4chPins[3],LOW);

     Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
  String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("temperature_1") + "&component_value="+ String(t)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

 Serial.print("connecting to ");
  Serial.println(host);

//  WiFiClient client;
//  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
  
   url = "/insertstream.php?component_name=" + String("Humidity_1") + "&component_value="+ String(h)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
    
    delay(15000);
    digitalWrite(RelayModule4chPins[3],HIGH);
    }
    
    if (t > 35 ){
    Serial.println("Temperature Critical high turning on fans and  cooling systems");
    delay(15000);
    digitalWrite(RelayModule4chPins[2],HIGH);

     Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
  String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("temperature_1") + "&component_value="+ String(t)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

 Serial.print("connecting to ");
  Serial.println(host);

//  WiFiClient client;
//  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
  
 url = "/insertstream.php?component_name=" + String("Humidity_1") + "&component_value="+ String(h)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
    }

    if (h < 60 ){
    Serial.println("Humiidty low turning on Humidity  and  Spraying systems");
    digitalWrite(RelayModule4chPins[1],LOW);
     Serial.print("connecting to ");
    Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
  String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("Humidity_1") + "&component_value="+ String(h)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

 Serial.print("connecting to ");
  Serial.println(host);

//  WiFiClient client;
//  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }

 url = "/insertstream.php?component_name=" + String("temperature_1") + "&component_value="+ String(t)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
  
    delay(15000);
    digitalWrite(RelayModule4chPins[1],HIGH);
    }

    if (h > 60 ){
    Serial.println("Humiidty High turning on Bulbs");
    digitalWrite(RelayModule4chPins[3],LOW);
     Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
  String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("Humidity_1") + "&component_value="+ String(h)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

 Serial.print("connecting to ");
  Serial.println(host);

//WiFiClient client;
//  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }

  url = "/insertstream.php?component_name=" + String("temperature_1") + "&component_value="+ String(t)+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
    delay(15000);
    digitalWrite(RelayModule4chPins[3],HIGH);
    }

    if (sensor_digital == 0 ){
    Serial.println("Soil moisture High turning off pump");
    digitalWrite(RelayModule4chPins[0],HIGH);
     Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
  String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("soil_moisture1") + "&component_value="+ String("high")+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
    }

    if (sensor_digital == 1 ){
    Serial.println("Soil moisture low turning on the pump");
    digitalWrite(RelayModule4chPins[0],LOW);;
    
     Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
 }
 String farm_name = "Abdullah_Farm";
 String chamber_name = "Abd_micro_chamber";
 String zone_name = "zone1";
  String url = "/insertstream.php?component_name=" + String("soil_moisture1") + "&component_value="+ String("low")+ "&zone_name="+ String(zone_name)+"&chamber_name="+ String(chamber_name)+"&farm_name="+ String(farm_name);
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(2500);
  
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
    
    delay(5000);
    digitalWrite(RelayModule4chPins[0],HIGH);
    Serial.println("pump going to sleep for 30 minutes");
    delay(1800000);    
    }
  
delay(300000);    
    
//  Serial.print("connecting to ");
//  Serial.println(host);
//
//  WiFiClient client;
//  const int httpPort = 80;
//  if (!client.connect(host, httpPort)) {
//    Serial.println("connection failed");
//    return;
// }
//  String url = "/insert2.php?temp=" + String(t) + "&hum="+ String(h)+ "&moisture="+ String(moisture_percentage)+"&ldr="+ String(ldr_value)+"&pump_status="+ String(pump_status)+"&humidifier_status="+ String(humidifier_status)+"&chamber_id="+ String(chamber_id);
//  Serial.print("Requesting URL: ");
//  Serial.println(url);
//  
//  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
//               "Host: " + host + "\r\n" + 
//               "Connection: close\r\n\r\n");
//  delay(2500);
//  
//  while(client.available()){
//    String line = client.readStringUntil('\r');
//    Serial.print(line);
//  }
//  
//  Serial.println();
//  Serial.println("closing connection");
}
