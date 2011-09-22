class Ring {
  int x,y,z;
  final int pt_ct = 44;
  final int degree_increment = 360 / pt_ct;
  int[] magnitudes = new int[pt_ct];
  float[] point_x = new float[pt_ct];
  float[] point_y = new float[pt_ct];

  Ring(){ randomize_magnitudes(); }

  public void randomize_magnitudes(){ randomize_magnitudes(5,8); }
  public void randomize_magnitudes(int low, int high){
    for (int i = 0; i < pt_ct; i ++){
      magnitudes[i] = (int) random(low, high);
    }
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

    stroke(0xff000000);
    translate(this.x, this.y, this.z);

    int i_prev;
    for (int i = 0; i < pt_ct; i ++){
      i_prev = (i==0) ? pt_ct - 1 : i - 1;

      line(point_x[i], point_y[i],  point_x[i_prev], point_y[i_prev]);
    }
    popMatrix();
  }
}

