
class Obstacle{
  float x;
  float y;
  float w, h;
  boolean closer;
  
  Obstacle(int i){
    w = random(3*scl,4*scl);
    h = random(7*scl,8*scl);
    x = 1.5*width + i*dis;
    y = height-h;
  }
  
  Obstacle(float x1, float y1, float w1, float h1){

    w = w1;
    h = h1;
    x = x1;
    y = y1;
  }
   
  boolean hits(Player b) {
    if (b.pos.x + scl >= x && b.pos.x - scl <= x + w) {
      if (b.pos.y + scl > height-h) {
        return true;
      }
    }
    return false;
  }
   
  void move(){
    x = x-xspeed;
  }
  
  void show(boolean hit){
    if (hit){
      fill(255,0,0);
    }
    else {
    fill(0,255,0);
    }
    rect(x,y,w,h);
  }
}