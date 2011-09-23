class Tunnel {
  Ring[] rings;
  final int ring_depth = 18;


  Tunnel(int ring_ct){
    rings = new Ring[ring_ct];
    for (int i=0; i < rings.length; i++){
      rings[i] = new Ring();
      rings[i].z = i * -1 * ring_depth;
    }
  }

  public void step(int z){
    for (int i=0; i < rings.length; i++){
      rings[i].z -= z;
      if (rings[i].z < -100){
        rings[i].z += rings.length * ring_depth;
        rings[i].reinitialize();
      }
    }
  }

  public void draw(){
    for (int i=0; i < rings.length; i++)
      rings[i].draw();
  }
}

