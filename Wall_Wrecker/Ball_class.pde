class Ball {
  //FIELDS
  float size, speed, weight, rope, energy, theta, thetaSpeed;
  int swingMode;
  PVector position, landingSpot;
  
  //CONSTRUCTOR
  Ball(float x, float y, float s) {
   this.position = new PVector(x, y); //Position of the centre of the wrecking ball
   this.landingSpot = new PVector(); //Where the wrecking ball will hit when swung, calculated when the ball is swung
   this.size = s; //The size of the wrecking ball
   this.speed = 2.5; //How fast the wrecking ball will move in m/s
   this.weight = 550; //The mass of the wrecking ball
   this.rope = 358; //The length of rope the wreking ball has
   this.theta = 3*PI/2; //angle of the wrecking ball
   this.thetaSpeed = 0.01*this.speed; //speed at which the angle changes
   this.swingMode = 0; //0 = not swinging, 1 = swinging back, 2 = swinging forward, 3 = returnig to rest
  }
  
  //METHODS 
  void drawMe() {
    strokeWeight(5);
    stroke(0);
    line(rotatePoint.x, rotatePoint.y, this.position.x, this.position.y);
    
    fill(0);
    circle(this.position.x, this.position.y, this.size);
  }
  
  void updateMe() {
    //updating the positions of the variables
    this.position.x = rotatePoint.x + this.rope*cos(this.theta); 
    this.position.y = rotatePoint.y - this.rope*sin(this.theta);
    rotatePoint.x = craneX + 220;
    this.thetaSpeed = 0.01*this.speed;
    
    //Updating theta based on the swing mode
    if (this.swingMode == 0) {
     //do nothing 
    }
    
    else if (this.swingMode == 1) { //the ball is winding up
      this.theta -= this.thetaSpeed;
      
      if (this.theta < 5*PI/4) { //changing the swing mode once the ball has swung back enough
        this.swingMode = 2;
      }
    }
    
    else if (this.swingMode == 2) { //the ball is swinging forward
      this.theta += this.thetaSpeed;
      
      if (this.theta > 7*PI/4) { //changing the swing mode once the ball has hit the wall
        this.swingMode = 3;
        ////The ball hits the wall
        //if (bricksHighlighted) {
        //  unhighlight();
        //  highlight();
        //}
        this.calculateLandingSpot();
        damageBricks();
        checkIfBroken();
        //The ball hits the wall
        if (bricksHighlighted) {
          unhighlight();
          highlight();
        }
      }
    }
    
    else if (this.swingMode == 3) { //the ball is returning to the bottom
      this.theta -= this.thetaSpeed;
      
      if (this.theta < 3*PI/2) { //changing the swing mode once the ball has returned to the bottom
        this.swingMode = 0;
        this.theta = 3*PI/2; //making sure the ball is right at the bottom
      }
    }
  } //<>// //<>//
  
  //This mehtod will find where the wrecking ball is going to hit and the energy it will have
  void calculateLandingSpot() {
    this.energy = 0.5*this.weight*pow(this.speed, 2); //Kinetic energy = 1/2*m*v^2
    this.landingSpot.x = rotatePoint.x + this.rope*cos(this.theta);
    this.landingSpot.y = rotatePoint.y - this.rope*sin(this.theta);
  }
}
