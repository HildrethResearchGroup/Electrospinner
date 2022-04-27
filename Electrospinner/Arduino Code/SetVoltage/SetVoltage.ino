// High voltage supply
// 04/20/2022

int input;

void setup() {
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0){
    input = Serial.parseInt();
    analogWrite(A0, input);
  }
  delay(.2);
}
