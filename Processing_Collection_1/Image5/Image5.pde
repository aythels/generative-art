void setup() {
  size(800,600); 
  noStroke();
}

//variables for background circle
int CircleQuan = 14; //number of background circles
float ExpoFactor = 1.05; //circle's increasing expotential factor

//variables for spiral
int SpiralArms = 8; //number of spiral arms
int degrees = 360/(SpiralArms*2); //degrees between each section
int pattern = 2; //color in every other arm

void draw(){
  for (int i = CircleQuan; i >= 1; i--) { //this script starts by generating the outtermost circles so that each consecutive circle generated will cover the larger circle already present
      float CircleSize = 5*pow(i, 2*ExpoFactor); //calculates height and width of circle relative to each loop
      fill(0, 85+i*10, 255-i*5); //azure blue to mint green gradient
      ellipse(width/2, height/2, CircleSize, CircleSize); //generates the circular pattern that forms the back ground
     
      for (int a = 1; a<= SpiralArms; a++)  { //this loop generates the spirals
        int offset = 7*i; //how much each spiral should be offset relate to each circular layer
        fill(255-i*5, 106-i*5, 206+i); //purplish pink gradient
        arc(width/2, height/2, CircleSize, CircleSize, radians(degrees*(pattern*a-1)+offset), radians(degrees*(pattern*a)+offset), PIE); //geneeates the spirals
      }
      
  }
    save("image.png");
    
}
