
class Obstacle{
  float x, y;  // location
  float w; // Width of the Obstacle
  float h; // Height of the Obstacle
  boolean closer; // True if the Obstacle is the closest to the Player
  
  Obstacle(int i){
    w = random(minW,maxW);
    h = random(minH,maxH);
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
    if (hit)
      fill(255,0,0);
    else 
      fill(0,255,0);
    rect(x,y,w,h);
  }
}