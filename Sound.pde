import processing.sound.*;//sound library
PImage radio;
PImage bird;
boolean sakura_plays;

class Sound{
  float x_radio;
  float y_radio;
  float w_radio;
  float h_radio;
  float x_bird;
  float y_bird;
  float w_bird;
  float h_bird;
  SoundFile sakura;
  SoundFile park;
  Sound(PApplet main_this) {
    x_radio = 20;
    y_radio = 20;
    w_radio = 150;
    h_radio = 140;
    x_bird = 450;
    y_bird = 20;
    w_bird = 150;
    h_bird = 140;
    sakura = new SoundFile(main_this, "sakura_sakura.wav");
    park = new SoundFile(main_this, "park.wav");
    sakura_plays = false;
    park.loop();
    radio = loadImage("radio.png");
    bird = loadImage("bird.png");
  }
  void play(int[] maskImage) {
    int rx_radio = round(x_radio);
    int ry_radio = round(y_radio);
    int rx_bird = round(x_bird);
    int ry_bird = round(y_bird);
    int loc_radio = rx_radio + ry_radio*640;
    int loc_bird = rx_bird + ry_bird*640;
    if (maskImage[loc_radio] == 255 && sakura_plays == false) {
      park.stop();
      sakura.loop();
      sakura_plays = true;
    } else if (maskImage[loc_bird] == 255 && sakura_plays == true) {
      sakura.stop();
      park.loop();
      sakura_plays = false;
    }
  }
  void display() {
    //noStroke();
    //fill(100, 300, 300, 150);
    //rect(x_bird, y_bird, w_bird, h_bird);
    image(radio, x_radio, y_radio);
    image(bird, x_bird, y_bird);
  }
}