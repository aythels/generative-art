void setup() {
  size(800,600); 
}

void draw(){
      for (int i = 20; i >= 1; i--) {
        int CircleSize = (5*i*i+15);
        
        for (int a = 1; a<= 18; a++) { //rotates it all around
          noStroke();
          fill(0+a*10, 10+5*i, 10*a);
          arc(width/2, height/2, CircleSize+a*10, CircleSize+a*10, radians((a*20)+i*40), radians((a*20+20)+i*40), PIE);
        }
      }
      
      save("image.png");
}
    
