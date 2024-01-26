class Brick {
  //FIELDS
  float strength, force, damage, xFall, yFall, landingY, framesFalling;
  float[] randomCrackX, randomCrackY;
  color outline;
  boolean highlighted, broken;
  PVector position, arrayIndex;
  
  //CONSTRUCTOR
  Brick(float x, float y, float l, float i, float s) {
   this.position = new PVector(x, y); //middle of the brick
   this.strength = s; //The force the brick can take before breaking
   this.force = 0; //The force currently being exerted on the brick, to be calculated later
   this.damage = random(0, 1); //The ammount of dammage which has been done to the brick. Starts with a negligible amount of damage so the bottom row isnt highlighted
   this.outline = (0); //Colour of the bricks outline
   this.highlighted = false; //Weather or not the brick is being highlighted
   this.broken = false; //Weather or not the brick is broken
   this.arrayIndex = new PVector(l, i); //The indexes of the 2d array which this brick is in
   this.xFall = random(-0.5, 0.5); //How the brick will move along the x axis when broken
   this.yFall = random(3, 5); //The speed the brick will fall at
   this.landingY = random(570, 590); //The position of the y axis the brick will land at
   this.framesFalling = 0; //The number of frames the brick has been falling
   this.randomCrackX = new float[6];
   this.randomCrackY = new float[6]; //These floats are random and appeneded in the brick setup. they are random so all bricks crack differently
  }
  
  //METHODS
  void drawMe() {
    fill(207, 70, 17);
    strokeWeight(2);
    stroke(0);
    if (highlighted){
      fill(250, 246, 20);
    }
    
    //drawing the brick
    rect(this.position.x-10, this.position.y-5, 20, 10);
    
    //drawing cracks on the bricks if they are hit
    if (this.damage > 5) {
      strokeWeight(0.5);
      stroke(0);
      line(this.position.x, this.position.y, this.position.x+randomCrackX[0], this.position.y-randomCrackY[0]);
      line(this.position.x, this.position.y, this.position.x-randomCrackX[1], this.position.y+randomCrackY[1]);
      line(this.position.x-randomCrackX[2], this.position.y-randomCrackY[2], this.position.x+randomCrackX[3], this.position.y+randomCrackY[3]);
      line(this.position.x-randomCrackX[4], this.position.y-randomCrackY[4], this.position.x+randomCrackX[5], this.position.y+randomCrackY[5]);
    }
  }
  
  void updateMe() {
    float weightSum = 0;
    for (int i = int(this.arrayIndex.y)+1; i < 45; i++) {
      if (!bricks[int(this.arrayIndex.x)][i].broken) {
         weightSum += 2; //Weight of an average brick in kg
      }
    }
    
    //The force acting on the brick is the mass of the bricks on it multiplied by gravity f = ma
    this.force = weightSum*9.81;
    
    //Making the brick fall when broken
    if (this.broken && this.position.y < this.landingY) {
      this.position.y += this.yFall*(this.framesFalling/60*1.4);
      this.framesFalling++;
      this.position.x += this.xFall;
    }
  }
}
