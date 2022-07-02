float startX, startY;

ArrayList<Wall> walls;
Ball[] balls;

void setup(){
  fullScreen();
  walls = new ArrayList<Wall>();
  
  walls.add(new Wall(0,0,width,0));
  walls.add(new Wall(0,0,0,height));
  walls.add(new Wall(width,0,width,height));
  walls.add(new Wall(0,height,width,height));
  
  balls = new Ball[10];
  
  for (int i = 0; i < balls.length; i++){
    int w = (int)random(10,50);
    float x = random(w,width-w);
    float y = random(w,height-w);
    float speed = random(2,5);
    float dir = random(0,TWO_PI);
    balls[i] = new Ball(x,y,speed,dir,w);
  }
}

void draw(){
  background(0);
  
  for (Ball b : balls){
    b.move();
    for (Wall w : walls){
       if (b.collide(w)) break;
    }
    b.show();
  }
  
  for (Wall w : walls){
       w.show();
   }
  

}

void mousePressed(){
  startX = mouseX;
  startY = mouseY;
}

void mouseDragged(){
  if (dist(startX,startY,mouseX,mouseY) > 100){
    walls.add(new Wall(startX,startY,mouseX,mouseY)); 
    startX = mouseX;
    startY = mouseY;
  }
}
