int scl = 20;
int health = 3, inv = 0;
boolean hitd = false;
boolean hitb = false;
//boolean trigger = true;
Player s;
Drop [] p = new Drop[15];
Food f;

import ddf.minim.*;
//import ddf.minim.spi.*; 
import ddf.minim.ugens.*;

Minim minim;
TickRate rateControl;
FilePlayer filePlayer;
AudioOutput out;
AudioSample blop;

String fileName = "p.mp3";

void setup(){
  size(600, 600);
  frameRate(10);
 
  s = new Player();
  
  f = new Food();
  f.pickLocation();
  
  for (int i = 0; i < p.length; i++)
    p[i] = new Drop();
    
  minim = new Minim(this);
  blop = minim.loadSample( "splat.mp3",512);
  //wha = minim.loadSample("wha.mp3", 512);
  
  filePlayer = new FilePlayer( minim.loadFileStream(fileName));
  filePlayer.loop();
  rateControl = new TickRate(1.f);
  out = minim.getLineOut();
  filePlayer.patch(rateControl).patch(out);
}


void draw(){
  background(51);
  if(health > 0){
    if(keyCode == UP){
      if(s.yspeed != 1 || s.point == 0)
         s.dir(0, -1);
    }
    else if (keyCode == DOWN){
      if(s.yspeed != -1 || s.point == 0)
         s.dir(0, 1);
    }
    else if (keyCode == RIGHT){
      if(s.xspeed != -1 || s.point == 0)
         s.dir(1, 0);
    }
    else if(keyCode == LEFT){
      if(s.xspeed != 1 || s.point == 0)
         s.dir(-1, 0);
    }
    if (keyCode == SHIFT && keyPressed)
        s.point++;
 }
  if (s.eat(f)){
    f.pickLocation();
    blop.trigger();
  }
  s.update();
  s.show();
  for (int i = 0; i < p.length; i++){
      p[i].update();
      p[i].fall();
  }
  s.death(p);
  s.healthBar();
  f.update();
}

class Drop {
  float x, y, yspeed, size;
  int inc;
  Drop(){
      x = random(2*scl, width);
      y = random(0, -100);
      yspeed = random(5,10);
      size = random(scl, 2*scl);
  }
  void update(){
    fill(0);
    ellipse(x,y,size,size);
  }
  void fall(){
    y = y + yspeed;
    if (y > height){
        x = random(0, width);
        y = random(0, -100);
        x = constrain(x,scl,width-scl);
        if (s.point%5 == 0 && s.point != 0){
            inc = 2;
            yspeed += inc;
        }
        else if (s.point == 0){
            inc = 0;
            yspeed = random(5,10);
        }
    }
  } 
}

class Food {
  float x, y;
  Food(){
      x = y = 0;
  }
  void pickLocation() {
    int cols = (width-scl)/scl;
    int rows = (height-scl)/scl;
    //println(cols, rows);
    x = (scl/2)+scl*floor(random(cols));
    y = (scl/2)+scl*floor(random(rows));
  }
  void update() {
     fill(255,0,100);
     noStroke();
     ellipse(x, y, scl,scl);
    // println(x,y);
  }
}


class Player {
  float x,y;
  float xspeed, yspeed;
  int point;
  ArrayList<PVector> body;
  
  Player(){
      x = scl/2;
      y = height-scl/2;
      xspeed = yspeed = 0;
      point = 0;
      body = new ArrayList<PVector>();
  }
  boolean eat(Food f){
    float d = dist(x,y,f.x,f.y);
    if(d < 1){
      point++;
      return true;
    }
    return false;
  }
  void dir(float x, float y){
    xspeed = x;
    yspeed = y;
  }
  void death(Drop p[]){
    for (int i = 0; i < p.length; i++){
      float d = dist(x, y, p[i].x, p[i].y);
        if (d < (p[i].size/2)+(scl/2)){
          hitd = true;
      }
    }
    for (int i = 0; i < body.size(); i++){
      PVector pos = body.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1){
        hitb = true;
      }
    }
    if((hitd || hitb) && inv == 0){
      health -=1;
      inv = 5;
    }
    if(health <= 0){    
      x = scl/2;
      y = height-scl/2;
      point = 0;
      fill(0,255,255);
      strokeWeight(4);
      textSize(32);
      text("GAME OVER",(width-200)/2,(height-50)/2);
      textSize(20);
      text("Press Space To Start",(width-210)/2,(height)/2);
      /*if(trigger){
        //wha.trigger();
        trigger = false;
      }*/
      if (key == ' ' && keyPressed){
          health = 3;
          body.clear();
          xspeed = yspeed = 0;
          //trigger = true;
      }
    }
    if(inv != 0 && inv > 0){
        inv--;
    }
  }
  void update() {
   if(health > 0){
    if(point > 0) {
      if(point == body.size() && !body.isEmpty()){
        body.remove(0);
      }
      body.add(new PVector(x,y));
    }
    x = x + xspeed*scl;
    y = y + yspeed*scl;
    
    if(x > width){
      x = scl/2;
    }
    else if (x < scl/2){
      x = width-scl/2;
    }
    if(y > height){
      y = scl/2;
    }
    else if (y < scl/2) {
      y = height-scl/2;
    }
   }
    //x = constrain(x,scl/2,width-scl/2);
    //y = constrain(y,scl/2,height-scl/2);
 }
 void show(){
   if(hitd || hitb || inv != 0) {
     fill(255,0,0);
     hitd = false;
     hitb = false;
   }
   else
     fill(255);
   if(health > 0){
   for (int i = 0; i < body.size(); i++) {
      noStroke();
      ellipse(body.get(i).x, body.get(i).y, scl, scl);
    }
    noStroke();
    ellipse(x,y,scl,scl);
    //println(x,y);
   }
 }
  void healthBar(){
    float hx = 10;
    float hy = 20;
    for(int i = 0; i < health; i++){
      fill(255,0,0);
      textSize(15);
      //rect(hx , hy, scl/2, scl/2);
      text("♥",hx,hy);
      hx += scl;
    }
  }
}
