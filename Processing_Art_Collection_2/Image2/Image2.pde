void setup() {
 size(1200, 900);
 noStroke();
 //noLoop();            //remove comment to freeze image
 frameRate(1);
}

void draw() {
   GenBackDrop();                                                                                         //I created my own custom backdrop 
  
   //variables to determine the dimensions of each building
   float BuildWidth;                                                                                    //The width of the building
   float BuildLength = 10000;                                                                           //The length of the building (set to a very high number so that all buildings reach the floor) If you set this to a lower number, then the rectangles will will be suspended in mid air as shown in image 3
   float BuildXPos;                                                                                     //Teft x-pos of building
   float BuildHeight;                                                                                   //Top y-pos of building
   float LastXPos = -100;                                                                               //The right x-pos of the previous building
   
   //The approximate RGB color scheme of each building  #####This was changed in just about every image
   float[] colorRGB = {76, 91, 130};

   //Generates each building from left to right, back to front
    for (int a=0; a<=20; a++){                                                                       //For each row a, higher value means more layers of buildings
      for (int i=0; i<=20; i++){                                                                        //For each building i,     
        //hue variations
        float rVar = random(-10, 10);
        float gVar = random(-10, 10);
        float bVar = random(-10, 10);
        
        //brightness variation
        float BrightVar = random (-15, 15);
        
        //dimensional variations
        float BHeight = random(-300, 300);
        float BWidth = random(-20, 20);
        float Gap = random (10, 70);
        
        //color of each building (darkens as building gets closer)
        fill (colorRGB[0]+BrightVar+rVar-a*15, colorRGB[1]+BrightVar+gVar-a*15, colorRGB[2]+BrightVar+bVar-a*15);
        
        //dimensions of each building, (Buildings get larger and wider, gaps become smaller as they appear closer to the viewer) #######change accordingly as shown in several of my images
        BuildWidth = 70+BWidth+a*10;
        BuildHeight = 600+BHeight+a*a*5;                                                                //The height of the rectangles according to their y-position, I set 600 as the maximum limit. #########Remove 600 to have the buildings fit the entire screen such as shown in image 2 and 5.
      
        BuildXPos = LastXPos+Gap-a*10;                                                                  //The starting X-Pos of each new building is the x-pos of the previous old building + the gap value
       
        //draws building  ######## If you swap all the x and y variables, it will draw horizontally such as shown in image 5
        rect(BuildXPos, BuildHeight, BuildWidth, BuildLength);
        LastXPos = BuildXPos+BuildWidth;
  
        //EXTRAS STUFF I ADDED TO TOUCH UP ON MY BUILDINGS:
        //generates a unique top for each building
        genTopInput(random(6), BuildXPos, BuildWidth+BuildXPos, BuildHeight);
        //generates unique textures for each building
        genNoiseInput(BuildXPos, BuildWidth+BuildXPos, BuildHeight, BuildWidth);
        //generates lighting highlights for each building
        genLightInput(BuildXPos, BuildWidth+BuildXPos, BuildHeight, BuildWidth);
        
      }
      LastXPos = -100; //resets position of previous building to the very left as new row starts
      
      save("image.png");
    }
}

//FUNCTIONS
//background
void GenBackDrop(){
  for (int a=100; a>0; a--){                                                                                   //Generates rings of circles, each a different color to give the appearance of a gradient.
    fill(52-a, 68-a, 153-a);
    ellipse(width/2, height, width*2.5, height*1.1+a*10);
  } 
}

//Generates a unique top for a building based on its dimensions
void genTopInput(float Variation, float LeftX, float RightX, float Height) {
  Height = Height+0.5;                                                                                         //I noticed that theres a very, very thin unremoveable stroke around each shape. This shifts the shape down so that the outline is hidden.
  
  //for slanted tops
    if (Variation < 1) {//cone
    beginShape();
    vertex((LeftX+RightX)/2, Height-10);
    vertex(LeftX, Height);
    vertex(RightX, Height);
    endShape();
    }
    if (Variation > 1 && Variation < 2) {//flat (essentially a rectangle but I decided to stick to using vertexes for consistency
    beginShape();
    vertex(LeftX+((RightX-LeftX)/6), Height);
    vertex(LeftX+((RightX-LeftX)/6), Height-Height/90);
    vertex(RightX-((RightX-LeftX)/6), Height-Height/90);
    vertex(RightX-((RightX-LeftX)/6), Height);
    endShape();
    }
    if (Variation > 3 && Variation < 4) {//asymmetrical slant flat
    beginShape();
    vertex(RightX-((RightX-LeftX)/2), Height-10);
    vertex(RightX, Height-10);
    vertex(RightX, Height);
    vertex(LeftX, Height);
    endShape();
    }
  }

//Generates noise for texture of each building                                                                 //Basically it generates  more rectangles within a rectangule
void genNoiseInput (float LeftX, float RightX, float Height, float absWidth) {                                 //ABSWidth is the absolute width of the building, not the coordinates.
float stroke = absWidth/random(5, 10);
float brightness = random (0, 10);

fill (0+brightness*10,0+brightness*10,0+brightness*10, 50);                                                                                 //Brightness fluctuates

//draws stripes on either side o the building
rect(LeftX, Height, stroke+random(-stroke, stroke), 10000);
rect(RightX-stroke, Height, stroke, 10000);
}


//Generates lighting for each building
void genLightInput (float LeftX, float RightX, float Height, float absWidth) {
  float Window = absWidth/random(10, 15);                                                                         //Determines a value for the length of a window based on the width of the building
    float WindowY = Window * random(2/3, 2);                                                                      //Determines a value for the height of a window based on it's length
    for (int h=0; h<=100; h++) {
      for (int a=0; a<=10; a++){
         fill (190 + random(-20, 20), 200+random(-20, 20), 140+random(-20, 20), random(10, 255));                  // Color of the lights, change according as shown in several of my images
         float WindowX = LeftX+Window+2*a*Window;
         if (WindowX+Window < RightX-Window) {
         rect(WindowX, Height+Window*2*h, 10, WindowY);
         }
      }
    }
}
  
  
  
  



  
  
