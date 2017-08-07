class Player{
  PVector pos;
  PVector vel;
  PVector acc;
  int points;
  int fitness;
  Neuron N;
  
  Player() {
    pos = new PVector(2*scl, height/2);
    vel = new PVector(0,0);
    acc = new PVector();
    N = new Neuron(4,2);
  }
  
  Player(Neuron n){
    pos = new PVector(2*scl, height/2);
    vel = new PVector(0,0);
    acc = new PVector();
    N = n;
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    applyForce(gravity);
    pos.add(vel);
    vel.add(acc);
    vel.limit(22);
    acc.mult(0);

    if (pos.y > height-scl || pos.y < 0) {
      pos.y = height-scl;
      vel.mult(0);
      gravity.mult(0);
      }
    gravity = new PVector(0,1);
  }
  
  void show() {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, scl*2, scl*2);    
  }
  
  float distanceX(Obstacle o){
    return o.x - (pos.x+scl);
  }
}