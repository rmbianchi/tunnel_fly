import processing.opengl.*;

Ring ring;
Tunnel tunnel;
int tick = 0;

void setup(){
  size(800,800,OPENGL);
  camera( 0,0,-100, 0,0,0, 0,-1,0);
  frustum( -200,200, -200,200, 400, 0);
  smooth();

  //for (int i=0; i < stuff.length; i++){
  //  stuff[i] = new Cube((int)random(8)+2);
  //  stuff[i].x = (int)random(10);
  //  stuff[i].y = (int)random(10);
  //  stuff[i].z = 0;//(int)random(10);
  //}
  ring = new Ring();
  tunnel = new Tunnel(15);
}

void draw(){
  background(255);
  stroke(0xff000000);
  fill(0x993366aa);

  tick ++;
  //rotateY(radians(tick % 360));
  //rotateX(radians(tick % 360));
  //rotateZ(radians(tick % 360));
  //axis();

  //ring.randomize_magnitudes(45,65);
  //ring.draw();
  tunnel.step( 5 );
  tunnel.draw();
  delay(100);
}

void axis(){
  pushMatrix();
  stroke(0xffff0000);
  line(0,0,0, 100,0,0);
  stroke(0xff00ff00);
  line(0,0,0, 0,100,0);
  //stroke(0xff0000ff);
  //line(0,0,0, 0,0,100);
  popMatrix();
}

