final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final float lifeGap = 20;
final float lifePosition = 10;
final float lifeSize = 50; 

float soilX;
float soilY;
float soilLayer = 24;
float soilChange = 4;
final float grid = 80;
float soilmove = 0;
float nowLayer=0;
float move=0;
boolean moveLayer=false;

//init a cabbage's position randomly
float cabbageX  = floor(random(2,8))*(int)grid;
float cabbageY  = floor(random(2,6))*(int)grid;
float cabbageQuantity = 1;
final int cabbage_H = 80;
final int cabbage_W =80;

//init a solier's position randomly
final int soldierSize = 80;
float soldierX = -soldierSize;
float soldierY = floor(random(2,6))*grid;
float soldierSpeed = 3;
final int soldier_H = 80;
final int soldier_W =80;

float groundhogX = grid*4;
float groundhogY = grid;
final int groundhog_W = 80;
final int groundhog_H = 80;
      float groundhogUP = groundhogY;
      float groundhogDOWN = groundhogY+groundhog_H;
      float groundhogLEFT = groundhogX;
      float groundhogRIGHT = groundhogX+groundhog_W;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage life, soldier, groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;
PImage cabbage, soil0, soil1, soil2, soil3, soil4, soil5, stone1, stone2;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed =false;
boolean rightPressed =false;

int moveUP = 0;
int moveDOWN = 0;
int moveLEFT = 0;
int moveRIGHT = 0;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	
  imageMode(CORNER);
  
  //load the images
  bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	//soil8x24 = loadImage("img/soil8x24.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png"); 
  cabbage = loadImage("img/cabbage.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  
  //init life
  playerHealth=2;

  
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

    if (moveLayer) {
      //if(soilmove>0){
      //move-=80.0/15.0;
      pushMatrix();
      translate(0, soilmove);
      //}
      //if(soilmove>0){
      //  soilmove--;
      //}
    }

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);


     
		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int y=0; y<soilLayer; y++){
		    for(int x=0; x<8; x++){   

         soilX = grid*x;
         soilY = grid*2+grid*y;

         //Layer 17-24
         if(y/soilChange>=4){
           if(y/soilChange>=5){
             image(soil5, soilX, soilY, grid, grid);
           }else{
             image(soil4, soilX, soilY, grid, grid);
           }
           
           //stone
           if(y%8==1||y%8==2||y%8==4||y%8==5||y%8==7){
             if(x%8==0||x%8==3||x%8==6){
               image(stone1, soilX, soilY, grid, grid);
               
               if(y%8==2||y%8==5){
                 image(stone2, soilX, soilY, grid, grid);
               }
             }
           }
           if(y%8==0||y%8==1||y%8==3||y%8==4||y%8==6||y%8==7){
             if(x%8==1||x%8==4||x%8==7){
               image(stone1, soilX, soilY, grid, grid);
               
               if(y%8==1||y%8==4||y%8==7){
                 image(stone2, soilX, soilY, grid, grid);
               }
             }
           }
           if(y%8==0||y%8==02||y%8==3||y%8==5||y%8==6){
             if(x%8==2||x%8==5){
               image(stone1, soilX, soilY, grid, grid);
               
               if(y%8==0||y%8==3||y%8==6){
                 image(stone2, soilX, soilY, grid, grid);
               }
             }
           }
           
         }
         
         //Layer 9-16
         else if(y/soilChange>=2){       
           if(y/soilChange>=3){
             image(soil3, soilX, soilY, grid, grid);
           }else{
             image(soil2, soilX, soilY, grid, grid);
           }         

           //stone1
           if(y%4==1 || y%4==2){     
             if(x%4==1 || x%4==2){
             image(stone1, soilX, soilY, grid, grid);
             }
           }else if(x%4==0 || x%4==3){
             image(stone1, soilX, soilY, grid, grid);
           }
         }
         
         //Layer 1-8
         else if(y/soilChange>=0){          
           if(y/soilChange>=1){
             image(soil1, soilX, soilY, grid, grid);
           }else{
             image(soil0, soilX, soilY, grid, grid);
           }
           
           //stone1
           if(x==y){
             image(stone1, soilX, soilY, grid, grid);
           }
         }
         
       } 
     }
     
         //Sodlier  
      float soldierUP = soldierY;
      float soldierDOWN = soldierY+soldier_H;
      float soldierLEFT = soldierX;
      float soldierRIGHT = soldierX+soldier_W;

        //soldier walking from left to right repeatedly
        soldierX += soldierSpeed;
        if(soldierX>width){
          soldierX = -soldierSize;
        }
        
        //put a soldier image
        image(soldier,soldierX,soldierY);
        
        //if(groundhogUP < soldierDOWN && groundhogDOWN > soldierUP 
        //   && groundhogLEFT < soldierRIGHT && groundhogRIGHT > soldierLEFT){
        //      playerHealth -=1;
        //      groundhogX = grid*4;
        //      groundhogY = grid;
        //      moveDOWN = 0;
        //      moveLEFT = 0;
        //      moveRIGHT = 0;
        // }
        
    //Cabbage
    float cabbageUP = cabbageY;
    float cabbageDOWN = cabbageY+cabbage_H;
    float cabbageLEFT = cabbageX;
    float cabbageRIGHT = cabbageX+cabbage_W;
    
      if(cabbageQuantity>0){
        //put a cabbage image
          image(cabbage,cabbageX,cabbageY);
          
           //if(groundhogUP < cabbageDOWN && groundhogDOWN > cabbageUP && 
           //   groundhogLEFT < cabbageRIGHT && groundhogRIGHT > cabbageLEFT){ 
           // playerHealth +=1;
           // cabbageQuantity -= 1;
           // }  
      }
        
    if (moveLayer) {
        popMatrix();
        //if(soilmove==0){moveLayer=false;}
    }
                          
    // Player
      groundhogUP = groundhogY;
      groundhogDOWN = groundhogY+groundhog_H;
      groundhogLEFT = groundhogX;
      groundhogRIGHT = groundhogX+groundhog_W;
      
      //groundhog movement
      if (moveDOWN>0 && nowLayer>20){
        groundhogY +=80.0/15.0;
      }  else if (moveLEFT>0){
        groundhogX -=80.0/15.0;
      }  else if (moveRIGHT>0){
        groundhogX +=80.0/15.0;
      }
      
      if(moveDOWN > 0) {
        moveDOWN--;}
      if(moveLEFT > 0) {
        moveLEFT--;}
      if(moveRIGHT > 0) {
        moveRIGHT--;}
      
      //hog             
      if(groundhogLEFT <0){groundhogX = 0;}
      if(groundhogRIGHT > width){groundhogX = width-groundhog_W;}
      if(groundhogDOWN > height){ groundhogY = height-groundhog_H;}
      
      if(moveUP==0 && moveDOWN==0 && moveLEFT==0 && moveRIGHT==0){
        image(groundhogIdle , groundhogX , groundhogY);}
      if(moveDOWN > 0){
        image (groundhogDown , groundhogX , groundhogY);}
      if(moveLEFT > 0){
        image (groundhogLeft , groundhogX , groundhogY);}
      if(moveRIGHT > 0){
        image (groundhogRight , groundhogX , groundhogY);}
        
        

		// Health UI
    for(int i=0;i<playerHealth;i++){
      image(life, lifePosition+(lifeSize+lifeGap)*i, lifePosition);
    }
    
    //Lose
    if(playerHealth == 0){
       gameState = GAME_OVER;
     }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
        playerHealth = 2;
        cabbageQuantity = 1;
        soldierX = -soldierSize;
        soldierY = floor(random(2,6))*grid;
        cabbageX = floor(random(2,8))*grid;
        cabbageY = floor(random(2,6))*grid;
        moveDOWN = 0;
        moveLEFT = 0;
        moveRIGHT = 0;
        soilmove = 0;
        nowLayer=0;
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}
    
    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
if (key == CODED && gameState == GAME_RUN && moveDOWN==0 && moveLEFT==0 && moveRIGHT==0) {
      
      switch( keyCode ){ 
        case DOWN:
          downPressed = true;
          if(groundhogY < height-groundhog_H-1){ moveDOWN = 15;}
          moveLayer = true;
          nowLayer+=1;
          if(nowLayer<=20){ soilmove -=80;}
          break;
        case LEFT :
          leftPressed = true;
          if(groundhogX>0+1){ moveLEFT = 15;}
          break;
        case RIGHT:
          rightPressed = true;
          if(groundhogX < width-groundhog_W-1){ moveRIGHT = 15;}
          break;     

      }
    }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
  if (key == CODED) {
      switch( keyCode )
      { 
        case UP :
        upPressed = false;
        break;
        case DOWN :
        downPressed = false;
        break;
        case LEFT :
        leftPressed = false;
        break;
        case RIGHT :
        rightPressed = false ;
        break;
      }
    }
}
