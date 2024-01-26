//This function will find the weakest bricks to be highlighted
void highlight() {
  //Making a new arry with all the bricks to be sorted
  Brick[] sortedBricks = new Brick[buildingHeight*buildingWidth];
  int tempInt = 0;
  int highlightedBricks = 0;
  
  //Adding bricks to the array
  for(int i = 0; i < buildingHeight; i++) {
    for(int l = 0; l < buildingWidth; l++){
      sortedBricks[tempInt] = bricks[l][i];
      tempInt++;
      }
    }
  
  //Sorting the array of bricks with the most dammage at the start of the array
  for(int k = 1; k < sortedBricks.length; k++) {
  int g = k;
  while(g > 0 && sortedBricks[g-1].damage < sortedBricks[g].damage){
   Brick x = sortedBricks[g];
    sortedBricks[g] = sortedBricks[g-1];
    sortedBricks[g-1] = x;
    g--;
   }
  }
 
  int brickIndex = 0;
  //Highlighting the 25 weakest bricks
  while (highlightedBricks < 25 && brickIndex < sortedBricks.length) {
   if (!sortedBricks[brickIndex].broken) {
     sortedBricks[brickIndex].highlighted = true; 
     highlightedBricks++;
    }
   brickIndex++;
  }
}



//This function will unhighlight the weakest bricks
void unhighlight() {
  for(int i = 0; i < buildingHeight; i++) {
    for(int l = 0; l < buildingWidth; l++){
      bricks[l][i].highlighted = false;
    }
  }
}



//This function dammages all the bricks that the wrecking ball hits
void damageBricks() {
  for(int i = 0; i < buildingHeight; i++) {
    for(int l = 0; l < buildingWidth; l++){
     if (pow((bricks[l][i].position.x - wreckingBall.landingSpot.x), 2) + pow((bricks[l][i].position.y - wreckingBall.landingSpot.y), 2) < pow((wreckingBall.size/2.5), 2)) {
       bricks[l][i].damage += wreckingBall.energy; 
     }
    }
  }
}



//This recursive function will see if a brick is broken and then call the break function on it
void checkIfBroken() {  
 boolean brokenBrick = checkIfDammage();
   
 if(brokenBrick == false){ //base case
   //Do nothing
 }
   
 else { //recursive case
   bricks[brickWidthIndex][brickHeightIndex].broken = true;
   checkIfBroken();
 }
    
}



//This is the function that find if and where there is a broken brick
boolean checkIfDammage() {
  for(int i = 0; i < buildingHeight; i++) {
    for(int l = 0; l < buildingWidth; l++){
      //Breaking the brick if it is too damaged
      if (bricks[l][i].damage - bricks[l][i].force*10 > 4000 && bricks[l][i].broken == false) {
        brickWidthIndex = l;
        brickHeightIndex = i;
        return true;
      }
      
      //breaking the brick if the one below it is also broken
      //try because the bottom row will get a error
      try {
        if (bricks[l][i-1].broken == true && bricks[l][i].broken == false) {
          brickWidthIndex = l;
          brickHeightIndex = i;
          return true;
        }
      }
      
      catch(Exception e) {
      }
    }
  }
  
  return false;
}



//Setting the bricks in place
void setUpBricks() {
  //variables for the bricks
  float currentX = 400;
  float currentY = 550;
  
  //Making all the bricks
  for(int i = 0; i < buildingHeight; i++) {
    for(int l = 0; l < buildingWidth; l++){
      bricks[l][i] = new Brick(currentX, currentY, l, i, random(1, 5));
      currentX += 20;
      
      //Making the crakcs in the bricks
      for (int k = 0; k < bricks[l][i].randomCrackX.length; k++) {
        bricks[l][i].randomCrackX[k] = random(-9, 9);
        bricks[l][i].randomCrackY[k] = random(-2.4, 2.4);
      }
    }
    currentX = 400;
    currentY -= 10;
    } 
}
