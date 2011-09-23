class Ring {
  int x,y,z;
  color c;

  int pt_ct = 44;
  int degree_increment = 360 / pt_ct;

  int[] magnitudes;
  float[] point_x;
  float[] point_y;

  Ring(){
    reinitialize();
  }

  public void reinitialize(){
    set_pt_ct( (int) random(3,86) );
    randomize_magnitudes();
    choose_colors();
  }

  public void set_pt_ct(int count){
    pt_ct = count;
    degree_increment = 360 / pt_ct;
    magnitudes = new int[pt_ct];
    point_x = new float[pt_ct];
    point_y = new float[pt_ct];
  }

  public void randomize_magnitudes(){ randomize_magnitudes(5,8); }
  public void randomize_magnitudes(int low, int high){
    for (int i = 0; i < pt_ct; i ++){
      magnitudes[i] = (int) random(low, high);
    }
  }

  public void choose_colors(){
    c = color( (int) random(0,255),(int) random(0,255),(int) random(0,255) );
  }

  public void calc_points(){
    for (int i=0; i < pt_ct; i ++){
      point_x[i] = magnitudes[i] * cos( radians( i * degree_increment ) );
      point_y[i] = magnitudes[i] * sin( radians( i * degree_increment ) );
    }
  }

  public void draw(){
    calc_points();
    pushMatrix();

    stroke(c);
    translate(this.x, this.y, this.z);

    int i_prev;
    for (int i = 0; i < pt_ct; i ++){
      i_prev = (i==0) ? pt_ct - 1 : i - 1;

      line(point_x[i], point_y[i],  point_x[i_prev], point_y[i_prev]);
    }
    popMatrix();
  }
}

