//Moving the crane
void keyPressed() {
  if (key == CODED) {
    //Moving the creane left and right
    if (keyCode == LEFT && craneX > -70) {
      craneX -= 5;
      rotatePoint.x -= 5;
    }
    else if (keyCode == RIGHT && craneX < 175) {
     craneX += 5;  
     rotatePoint.x += 5;
    }
    
    //Moving the wrecking ball up and down
    else if (keyCode == UP && wreckingBall.rope > 80 + wreckingBall.size/2) {
     wreckingBall.position.y -= 5;
     wreckingBall.rope -= 5;
    }
    else if (keyCode == DOWN && wreckingBall.rope + wreckingBall.size/2 < 575) {
     wreckingBall.position.y += 5;
     wreckingBall.rope += 5;
    }
  }
  
  if (keyPressed) {
    //Swinging the ball
    if(key == ' ' && wreckingBall.swingMode == 0) {
      wreckingBall.swingMode = 1;
    }
  }
}
