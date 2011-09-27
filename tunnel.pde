class Tunnel {
  Ring[] rings;
  final int ring_depth = 12;
  int ring_count = 0;

  float ze_count = 0;
  float ze_step = 0.01;

  Tunnel(int ring_ct){
    rings = new Ring[ring_ct];
    for (int i=0; i < rings.length; i++){
      rings[i] = new Ring();
      rings[i].z = i * -1 * ring_depth;
    }
  }

  public boolean emit(){
    return emit_real() != null;
  }

  public boolean emit(int size){
    Ring ring = emit_real();
    if (ring == null)
      return false;
    ring.size = size;
    ring.choose_colors();
    ring.life = 400;
    return true;
  }

  private Ring emit_real(){
    for (int i=0; i < rings.length; i++){
      if (rings[i] == null){
        rings[i] = new Ring();
        rings[i].z = 100;
        return rings[i];
      }
    }
    return null;
  }


  public void step(int z){
    for (int i=0; i < rings.length; i++){
      if (rings[i] == null)
        continue;

      rings[i].life --;
      if (rings[i].life < 5)
        rings[i] = null;
      //rings[i].z -= z;
      //if (rings[i].z < -100){
      //  rings[i] = null;
      //}
    }
  }

  public void draw(){
    //draw line representing the function
    stroke(0xffff0000);
    float z, prev_z = 0;
    float y, prev_y = 0;

    boolean initial = true;
    reset();
    while ( (z = step()) < 200 ){
      y = why( z );
      if (initial != true)
        line(0,y,z, 0,prev_y,prev_z);
      prev_z = z;
      prev_y = y;
      initial = false;
    }

    for (int i=0; i < rings.length; i++) {
      if (rings[i] != null) {
        pushMatrix();
        math(rings[i].life);
        rings[i].draw();
        popMatrix();
      }
    }
  }

  private void reset(){ ze_count = 0; }
  private float step(){ return ze_count += ze_step; }
  private float why(float zee){ return (float)100 * sin(zee / 50); }
  private float why_prime(float zee){ return (float)2 * cos(zee / 50); }

  private void math(float z){
    z = z * ring_depth;
    // y = z ^ 2
    float y = why(z);

    // slope of tangent line
    float y_prime = why_prime(z);

    //tangent line
    // y = y_prime * z - y_prime

    float theta = atan( y_prime );


    translate(0.0, y, z);
    rotateY(theta);
  }
}

