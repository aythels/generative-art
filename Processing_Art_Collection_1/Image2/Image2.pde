void setup() {
  size(800,600); 
}

void draw(){
  noStroke();
  int CircleQuan = 14; //number of background circles
  float ExpoFactor = 1; //Circle's decreasing expodential factor
    noStroke();
  for (int i = CircleQuan; i >= 1; i--) {
    noStroke();
      fill(255-i*10);
      float CircleSize = 5*pow(i*50, ExpoFactor); 
      
      ellipse(width/2, height/2, CircleSize, CircleSize);
     
      strokeWeight(30);
      stroke(201, 156, 156);
      fill(2,42,1,0);
      ellipse(width/2, height/2, CircleSize, CircleSize); 
      
      //LINE WORK
     strokeWeight(70);
     stroke(120);
     line(InputX(width/2, 303, 120), InputY(height/2, 303, 120), InputX(width/2, 303, 200), InputY(height/2, 303, 190)); //LINE WORK
     line(InputX(width/2, 253, 120), InputY(height/2, 253, 120), InputX(width/2, 253, 200), InputY(height/2, 253, 190));
          line(InputX(width/2,353, 120), InputY(height/2, 353, 120), InputX(width/2, 353, 200), InputY(height/2, 353, 190));
     fill(120);
     //arc(width/2, height/2, 10, 10, radians(35), radians(180+35), PIE);
     
      strokeWeight(50);
      strokeCap(SQUARE);
      stroke(201, 206, 156);
      fill(2,42,1,0);
      arc(width/2, height/2, CircleSize, CircleSize, PI-radians(5), 2*PI+QUARTER_PI+radians(25), OPEN); 
     
      for (int a = 1; a<= 11; a++){
        noStroke();
        fill(50);
        arc(width/2, height/2, CircleSize, CircleSize, radians((20*a)), radians((20*a+5)), PIE);
        
      
      }
   
    }
    
    
    /*
    
     for (int  b= 1; b<= 36; b++) {
       line(width/2, height/2, InputX(width/2, b*10, 100), InputY(height/2, b*10, 100));
     }
    */
    
    save("image.png");
}
     
//given the center point of rotation, the rotational angle and radius, these methods will use trignometry to return a point along the desired circular circumference
//these two methods are the exact same, except is for the x coordinate and the other is for the y coordinate. I could have merged them together using arrays.
float InputX(int x, float degrees, float radius) {
  float NewXPos;
  float CircularPos;
  CircularPos = (radius * cos(radians(degrees)));
  NewXPos = (x+CircularPos);
  return  NewXPos;
}

float InputY(int y, float degrees, float radius) {
  float NewYPos;
  float CircularPos;
  CircularPos = (radius * sin(radians(degrees)));
  NewYPos = (y+CircularPos);
  return NewYPos;
}
