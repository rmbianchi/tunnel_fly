import processing.opengl.*;

Ring ring;
Tunnel tunnel;
Blode blode;

int count, max_count = 0;
float tick = 0;

boolean stopped = false;
boolean draw_function = false;
boolean draw_axis = false;
boolean draw_nulls = false;
boolean draw_display = false;
boolean random_orbit = true;

int[] rotating = new int[3];
int[] rotation = new int[3];
int rotation_increment = 2;

int[] moving = new int[3];
int[] camera_position = new int[3];
int movement_increment = 2;


void setup(){
  size(800,800,OPENGL);
  frustum( -200,200, -200,200, 400, 0);
  //frameRate(30);

  tunnel = new Tunnel(3000);
  blode = new Blode(this);
}

void draw(){
  camera(
      //camera position
      0 + camera_position[0],
      0 + camera_position[1],
      0 + camera_position[2],

      0, 0,-1,  //look vector
      0, 1, 0   //up vector
  );

  background(0);
  stroke(0xff000000);
  fill(0x993366aa);

  if (draw_display) display();

  update_transform();

  tick += 0.1;
  //automatic rotation
  if (random_orbit) {
    rotateY(radians( tick ));
    rotateX(radians( tick ));
    rotateZ(radians( tick ));
  } else {
    //manual rotation
    rotateY(radians( rotation[0] ));
    rotateX(radians( rotation[1] ));
    rotateZ(radians( rotation[2] ));
  }

  if (draw_axis) axis();
  if (draw_function) tunnel.function();

  //if (! stopped)
    tunnel.step( 55 );

  tunnel.draw();
  count = blode.readMessages();
  if (count > max_count)
    max_count = count;

  if (count > 0 || draw_nulls)
    if (! stopped && max_count > 0)
      if (!tunnel.emit((float)count / 30))
        println("Emit failed");
}

void axis(){
  pushMatrix();
  stroke(0xffff0000);
  line(0,0,0, 100,0,0);
  stroke(0xff00ff00);
  line(0,0,0, 0,100,0);
  stroke(0xff0000ff);
  line(0,0,0, 0,0,100);
  popMatrix();
}

void display(){
  pushMatrix();
  stroke(color(255,240,0));
  line(-100,0,0, 100,0,0);
  popMatrix();
}

void update_transform(){
  rotation[0] += rotating[0] * rotation_increment;
  rotation[1] += rotating[1] * rotation_increment;
  rotation[2] += rotating[2] * rotation_increment;
  camera_position[0] += moving[0] * movement_increment;
  camera_position[1] += moving[1] * movement_increment;
  camera_position[2] += moving[2] * movement_increment;
}

void keyPressed(){
  switch (key){
  case '~':
    tunnel.emit();
    break;
  case ' ':
    stopped =! stopped;
    break;

  case '2': draw_display = ! draw_display; break;
  case '3': random_orbit = ! random_orbit; break;
  case '5': draw_function = ! draw_function; break;
  case '4': draw_axis = ! draw_axis; break;
  case '6': draw_nulls = ! draw_nulls; break;

  //rotate
  //X
  case 'a': rotating[0] = -1; break;
  case 'e': rotating[0] = 1; break;

  //Y
  case 'o': rotating[1] = -1; break;
  case ',': rotating[1] = 1; break;

  //Z
  case '\'': rotating[2] = -1; break;
  case '.': rotating[2] = 1; break;

  //SLIDE
  //X
  case 'h': moving[0] = -1; break;
  case 's': moving[0]  = 1; break;

  //Y
  case 't': moving[1] = -1; break;
  case 'n': moving[1] = 1; break;

  //z
  case 'c': moving[2] = -1; break;
  case 'r':moving[2] = 1; break;
  }
}

void keyReleased(){
  switch (key){
  case 'e': case 'a': rotating[0] = 0; break;
  case ',': case 'o': rotating[1] = 0; break;
  case '\'': case '.': rotating[2] = 0; break;

  case 'h': case 's': moving[0] = 0; break;
  case 't': case 'n': moving[1] = 0; break;
  case 'c': case 'r': moving[2] = 0; break;

  case '1':
    rotating[0] = rotating[1] = rotating[2] = 0;
    rotation[0] = rotation[1] = rotation[2] = 0;
    moving[0] = moving[1] = moving[2] = 0;
    camera_position[0] = camera_position[1] = camera_position[2] = 0;
    break;
  }
}


