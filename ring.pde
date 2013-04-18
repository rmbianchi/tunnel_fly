class Ring {
  float x,y,z,size;
  int life;
  color c;

  int pt_ct = 12;
  int degree_increment = 360 / pt_ct;

  int[] magnitudes;
  float[] point_x;
  float[] point_y;

  boolean disabled = false;
  boolean respawn = true;

  private int min_magnitude = 2;
  private int max_magnitude = 7;

  Ring(){
    reinitialize();
  }

  public void reinitialize(){
    life = 0;
    //set_pt_ct( (int) random(3,86) );
    set_pt_ct( (int)(size * 25) );
    randomize_magnitudes();
    choose_colors();
  }

  public void set_pt_ct(int count){
    if (count <= 3)
      count = 8;

    pt_ct = count;
    degree_increment = 360 / pt_ct;
    magnitudes = new int[pt_ct];
    point_x = new float[pt_ct];
    point_y = new float[pt_ct];
  }

  public void randomize_magnitudes(){
    randomize_magnitudes( pt_ct, pt_ct + 3);
  }
  public void randomize_magnitudes(int low, int high){
    for (int i = 0; i < pt_ct; i ++){
      magnitudes[i] = (int) random(low, high);
    }
  }

  public void choose_colors(){
    int r = (int)random(1,3);
    int base = (int)random(50,200);
    if (r == 1)
      c = color( pt_ct, 255 - base, base );
    else if (r == 2)
      c = color( base, pt_ct, 255 - base );
    else if (r == 3)
      c = color( 255 - base, base, pt_ct );
  }

  public void delta_points(){
    for (int i=0; i < magnitudes.length; i ++){
      magnitudes[i] = constrain(magnitudes[i] + (int) random( 4 ) - 2, 3, 10);
    }
  }

  public void calc_points(){
    for (int i=0; i < magnitudes.length; i ++){
      point_x[i] = magnitudes[i] * cos( radians( i * degree_increment ) );
      point_y[i] = magnitudes[i] * sin( radians( i * degree_increment ) );
    }
  }

  public void draw(){
    //delta_points();
    calc_points();
    pushMatrix();

    //front-back line at center of ring
    //stroke(color(255,0,255));
    //line(0,0,-2, 0,0,2);
    stroke(c);
    //translate(this.x, this.y, this.z);

    int i_prev;
    for (int i = 0; i < pt_ct; i ++){
      i_prev = (i==0) ? pt_ct - 1 : i - 1;

      line(point_x[i], point_y[i], 0,  point_x[i_prev], point_y[i_prev], 0);
    }
    popMatrix();
  }
}

