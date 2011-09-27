class Tunnel {
  Ring[] rings;
  final int ring_depth = 1;
  int ring_count = 0;

  float ze_count = 0;
  float ze_step = 2;
  float space_between = 10;
  float last_render = 0;

  Tunnel(int ring_ct){
    rings = new Ring[ring_ct];
    //for (int i=0; i < rings.length; i++){
    //  rings[i] = new Ring();
    //  rings[i].z = i * -1 * ring_depth;
    //}
  }

  public boolean emit(){
    return emit_real() != null;
  }

  public boolean emit(float size){
    Ring ring = emit_real();
    if (ring == null)
      return false;
    ring.size = size;
    ring.reinitialize();
    ring.choose_colors();
    ring.life = 300;
    return true;
  }

  private Ring emit_real(){
    for (int i=0; i < rings.length; i++){
      if (rings[i] == null){
        rings[i] = new Ring();
        rings[i].z = 0;//max(last_render - space_between, 400);
        return rings[i];
      }
    }
    return null;
  }


  public void step(float z){
    for (int i=0; i < rings.length; i++){
      if (rings[i] == null)
        continue;

      rings[i].z += ze_step;
      rings[i].life --;
      if (rings[i].z > 500)
        rings[i] = null;
    }
  }

  public void draw(){
    for (int i=0; i < rings.length; i++) {
      if (rings[i] != null) {
        pushMatrix();
        math(rings[i].z);
        rings[i].draw();
        popMatrix();
        if (i == rings.length - 1)
          last_render = rings[i].z;
      }
    }
    if (frameRate < 50)
      println(frameRate);
  }

  private float why(float zee){ return (float)( 100 * sin( zee / 50 ));  }
  private float why_prime(float zee){ return (float)(2 * cos( zee / 50)); }

  private void math(float z){
    z = z * ring_depth;
    // y = z ^ 2
    float y = why(z);

    // slope of tangent line
    float y_prime = why_prime(z);

    // line perpendicular to tangent line + 90º is our target
    float theta = HALF_PI + atan( 1 / y_prime );


    translate(0.0, y, z);
    rotateX(theta);
  }

  private void function(){
    //draw line representing the function
    stroke(0xffff0000);
    float z, prev_z = 0;
    float y, prev_y = 0;

    boolean initial = true;
    stroke(color(255,0,255));
    for (z = 0; z < 200; z += ze_step){
      y = why( z );
      if (initial != true)
        line(0,y,z, 0,prev_y,prev_z);
      prev_z = z;
      prev_y = y;
      initial = false;
    }
  }

  private void ticks(){
    //dashes for context
    float z;
    stroke(color(0,255,255));
    for (z=0; z<200; z+=1){
      line(0,0,z, 0,1,z);
    }
  }
}

