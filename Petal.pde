class Petal{
  float x;
  float y;
  float yspeed;
  float rot;
  
  Petal() {
    x = random(width);
    y = 0;
    yspeed = random(0.5, 2);
    rot = random(0, PI);
  }
  void descend(int[] maskImage) {
    int rx = round(x);
    int ry = floor(y);
    int loc = rx + ry*640;
    if (maskImage[loc] == 0) {
      y += yspeed;
      if(y >= 480) {
        y = 0;
      }
      x = x + random(-2,2);
      if(x >= 640 || x < 0) {
        x = 0;
      }
    }
  }
  void display() {
    noStroke();
    fill(250, 207, 223, 150);
    rotate(rot);
    ellipse(x, y, 8, 3);
  }
}