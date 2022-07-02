class Ball{
  PVector pos, vel, acc; 
  int wid;
  float smallest;
  public Ball(float x, float y, float speed, float dir, int w){
    pos = new PVector(x,y); 
    vel = new PVector(speed * cos(dir), speed * sin(dir)); 
    acc = new PVector(0,0); 
    wid = w;
  }
  
  void show(){
    fill(255);
    ellipse(pos.x,pos.y,wid,wid);
  }
  
  void move(){
    vel.add(acc); 
    pos.add(vel); 
    acc.set(0,0); 
  }
  
  //using triangle area = 1/2 base * height
  //find the area of the triangle given by the three points:
  // - point of center of ball
  // - point a of the wall
  // - point b of the wall
  //then solve for h using the length of the wall segment as w
  //https://www.quora.com/How-can-I-find-the-altitude-of-a-triangle-whose-3-vertices-points-are-given
  float distToWall(Wall wall){
    float a = wall.a.x;
    float b = wall.a.y;
    float c = wall.b.x;
    float d = wall.b.y;
    float e = pos.x;
    float f = pos.y;
      
    float h = abs((a*d) - (b*c) + (c*f) - (d*e) + (b*e) - (a*f))/sqrt((pow((c-a),2)+pow((d-b),2)));

    return h; 
  }
  
  //Check if a wall is able to be collided with
  //Then check the distance to the wall
  //Then collide
  
  boolean collide(Wall wall){
    boolean insideX = false;
    float largerX = max(wall.a.x,wall.b.x);
    float smallerX = min(wall.a.x,wall.b.x);    
    if (largerX > pos.x - wid/2 && pos.x > smallerX - wid/2) insideX = true;
                    
    boolean insideY = false;
    if (insideX){
      float largerY = max(wall.a.y,wall.b.y);
      float smallerY = min(wall.a.y,wall.b.y);
      if (largerY > pos.y - wid/2 && pos.y > smallerY - wid/2) insideY= true;
    }

    if ((insideX && insideY) && distToWall(wall) < wid/2){
      bounce(wall);
      return true;
    } 
    return false;
  }
  
  //I have absolutely no idea how this works
  //I wrote this code a while ago and cam up with 
  //this absolutely wild formula for velocity rotation 
  //that makes 0 sense but looks almost ok.
  void bounce(Wall wall){
    PVector A = wall.a; //point a of a wall
    PVector B = wall.b; //point b of a wall
    
    float angle = atan2(B.y - A.y, B.x - A.x);
    angle = vel.heading() - angle - PI/2;
    vel.rotate((PI/2 - angle) * 2); //This is it. Im sure it can be improved
  }
  
}
