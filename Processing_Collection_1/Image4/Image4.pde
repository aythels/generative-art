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
      fill(10,38, 145-10*i);
      float CircleSize = 5*pow(i*30, ExpoFactor); 
      
      ellipse(width/2, height/2, CircleSize, CircleSize);
     
      strokeWeight(0);
      stroke(201, 156, 156);
      fill(2,42,1,0);
      ellipse(width/2, height/2, CircleSize, CircleSize);  //hihiuhhhihuhu
      stroke(66, 200, 244);
      strokeWeight(10);
      strokeCap(SQUARE);
      arc(width/2, height/2, CircleSize-40, CircleSize-40, 0, radians(75), OPEN);
      arc(width/2, height/2, CircleSize-40, CircleSize-40, radians(90), radians(90+75), OPEN);
      arc(width/2, height/2, CircleSize-40, CircleSize-40, radians(180), radians(180+75), OPEN);
      arc(width/2, height/2, CircleSize-40, CircleSize-40, radians(270), radians(270+75), OPEN);
      arc(width/2, height/2, CircleSize-40, CircleSize-40, radians(360), radians(360+75), OPEN);
      
      strokeWeight(10);
      stroke(201, 156, 156);
      fill(2,42,1,0);
      //ellipse(width/2, height/2, CircleSize, CircleSize);  //hihiuhhhihuhu
      stroke(66, 200, 244);
      strokeCap(SQUARE);
      arc(width/2, height/2, CircleSize+40, CircleSize+40, 0+45, radians(70+45), OPEN);
      arc(width/2, height/2, CircleSize+40, CircleSize+40, radians(90+45), radians(90+70+45), OPEN);
      arc(width/2, height/2, CircleSize+40, CircleSize+40, radians(180+45), radians(180+70+45), OPEN);
      arc(width/2, height/2, CircleSize+40, CircleSize+40, radians(270+45), radians(270+70+45), OPEN);
       arc(width/2, height/2, CircleSize+40, CircleSize+40, radians(360+45), radians(360+70+45), OPEN);
     
     for (int c = 1; c <= 12; c++) {
       strokeWeight(5);
     line(width/2, height/2, InputX(width/2, c*30+38+i*10, CircleSize), InputY(height/2, c*30+38+i*10, CircleSize));
     
     }
     
     
     
      for (int a = 1; a<= 10; a++){
        noStroke();
        fill(50);
        //arc(width/2, height/2, CircleSize, CircleSize, radians((20*a)), radians((20*a+5)), PIE);
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
