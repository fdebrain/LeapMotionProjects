int taille = 1;
int life = 3;
int score = 0;
PVector dir = new PVector(0,0);
boolean gameover;
PImage images[] = new PImage[7];

Snak snake = new Snak();
Fruit fruit = new Fruit();

void setup(){
  size(1600,800);
  smooth();
  gameover = false;
  background(255);
  
// Chargement des images :
  images[0] = loadImage("jeuvitalite.png");
  images[1] = loadImage("bananas.png");
  images[2] = loadImage("pear.png");
  images[3] = loadImage("grapes.png");
  images[4] = loadImage("cherry.png");
  images[5] = loadImage("apple.png");
  images[6] = loadImage("watermelon.png");
}

void draw(){
  snake.update();
  fruit.update();
    
  if(!gameover){
    background(255);
    fill(255,10);
    rect(0,0,width,height);
  
    snake.checkEdges();
    fruit.display();
    snake.display();
  }
}

void keyPressed(){
  if (keyCode == UP){dir.x = 0; dir.y = -1;}
  if (keyCode == RIGHT){dir.x = 1; dir.y = 0;}
  if (keyCode == DOWN){dir.x = 0; dir.y = 1;}
  if (keyCode == LEFT){dir.x = -1; dir.y = 0;}
  if (keyCode == ENTER){gameover = false; snake.init(); fruit.init(); life = 3; taille = 1; score = 0;}    
}


class Fruit {
  PVector location;
  int value; 
  int fruitType;
  
  Fruit(){
    location = new PVector(int(random(80,width-80)),int(random(80,height-80)));
    value = int(random(1,10));
    fruitType = int(random(1,6));
  }
  
  void init(){
    fruit.location.x = int(random(80,width-80));
    fruit.location.y = int(random(80,height-80));
    fruit.fruitType = int(random(1,6));
  }
  
  void update(){
    //if( abs(location.x - snake.location.x)< 30 && abs(location.y - snake.location.y)< 30){
    if ( sqrt( pow(fruit.location.x-snake.location.x + 20 ,2) + pow(fruit.location.y-snake.location.y + 30,2) )< 20){ 
      score++;
      fruit.init();
    }
  }
  
  void display(){
    stroke(1);
    fill(255,0,0);
    images[fruitType].resize(40,0);
    image(images[fruitType],location.x,location.y);
  }
}

class Snak {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int topspeed;
  
// Constructeur :
  Snak(){
    location = new PVector(800,400);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 10;
  }
  
// Reinitialisation :
  void init(){
    location.x = 800;
    location.y = 400;
    velocity.x = 0;
    velocity.y = 0;
    acceleration.x = 0;
    acceleration.y = 0;
  }
  
// Update position serpent :
  void update(){
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void display(){
// Affichage serpent :
    stroke(1);
    fill(175);
    for(int j = 0; j<taille; j++){
      ellipse(location.x + 50*j*(dir.x+0.5),location.y + 50*j*(dir.y+0.5),16,16);      
    }

// Affichage score et vie :
    textSize(20);
    fill(0,102,133);
    text("Score : " + score,width/1.1,height/15);
    for(int k=0; k<life; k++){
      image(images[0],width/1.1+20*k,height/14,20,20);
    }
  }

// Verification des bords :
  void checkEdges() {
    if (location.x > width || location.x < 0 || location.y > height || location.y < 0) {
      life--;
      fruit.init();
      if (life>0){snake.init();}
      
// Game Over : 
      if (life == 0){gameover = true;}
      if(gameover){
        textSize(100);
        fill(0,102,133);
        println("GAME OVER");
        text("GAME OVER",width/3,height/2.5);
        }
    }
  }
}