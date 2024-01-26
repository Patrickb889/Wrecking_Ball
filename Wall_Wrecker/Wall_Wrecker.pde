//This Program is a simultion of a crane destroying a building with a wrecking ball
//Control the crane with the arrow keys and play around with the variables do destroy the building however you want to
//You can also highlight the weakest bricks on the building through the GUI so that you know where to aim


import g4p_controls.*;

//Initilaizing crane
PImage craneImg;
float craneX = 15;
float craneY = 10;
PVector rotatePoint = new PVector(craneX+220, craneY+32);


//Initializing the building and bricks
PImage buildingImg;
int buildingWidth = 18;
int buildingHeight = 45;
Brick[][] bricks = new Brick[buildingWidth][buildingHeight];
int brokenBrickIndex, brickWidthIndex, brickHeightIndex;
boolean bricksHighlighted = false;

//Ball(x, y, size)
Ball wreckingBall = new Ball(craneX+220, craneY+390, 100);

void setup(){
  createGUI();
  size(800, 600);
  
  //Importing the crane
  craneImg = loadImage("Crane.png");
  buildingImg = loadImage("Building.png");
  
  //Setting up the bricks
  setUpBricks();
  }


void draw() {
  //Drawing background
  background(182, 208, 226);
  strokeWeight(2);
  fill(44, 201, 86);
  rect(0, 550, 800, 50);
  
  //Drawing the crane and building
  image(craneImg, craneX, craneY, 237, 560);
  image(buildingImg, 390, 105, 360, 450);
  
  //Drawing and updating the bricks
  for (int i = 0; i < 45; i++) {
    for(int l = 0; l < 18;l++) {
    bricks[l][i].drawMe();
    bricks[l][i].updateMe();
    }
  }
  
  //Drawing and updating the wrecking ball
  wreckingBall.drawMe();
  wreckingBall.updateMe();
}
