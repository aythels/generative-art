void setup() {
  size(800,600); 
  noStroke();
}

void draw(){
  for (int i = 65; i >= 1; i--) {
      fill(0+i*5);
      int CircleSize = (5*i*(i/5)*15); 
      ellipse(width/2, height/2, CircleSize, CircleSize);
     
      for (int a = 1; a<= 8; a++){
        noStroke();
        fill(200+i*5);
        arc(width/2, height/2, CircleSize-20, CircleSize-20, radians((20*a*2.2-20)-i*12), radians((20*a*2.2)-i*12+i*i/10), PIE);
      }
    }
    
    
    save("image.png");
}
