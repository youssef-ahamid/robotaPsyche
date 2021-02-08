Mover m;
PImage bg;

void setup() {
  bg = loadImage("bg.png");
  size(900,600);
  m = new Mover();
}
void keyPressed(){
  if(key == CODED){
    if (keyCode == LEFT) {
      m.velocity.x -= 0.5;
    }
    if (keyCode == RIGHT) {
      m.velocity.x += 0.5;
    }
    if (keyCode == UP) {
      m.velocity.y -= 0.5;
    }
    if (keyCode == DOWN) {
      m.velocity.y += 0.5;
    }
    if (keyCode == DELETE) {
      m.velocity.mult(0.3);
    }
  }
}

void draw() {
  background(255);
  image(bg, 0, 0, width, height);
  m.update();
  m.display();
}

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  PImage img = loadImage("car.png");

  Mover() {
    location = new PVector(100, 100);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update() {
    checkCollision();
    velocity.add(acceleration);
    acceleration.mult(0); // this makes sure the acceleration is zer0 for the next fram
    location.add(velocity);
    velocity.limit(4);
  }
  void checkCollision(){
    if(location.x < 0){
      velocity.x = -0.5*velocity.x;
      location.x = 0;
    } else if(location.x +40 > width){
      velocity.x = -0.5*velocity.x;
      location.x = width - 40;
    } else if(location.y < 20){
      velocity.y = -0.5*velocity.y;
      location.y = 20;
    } else if(location.y +20 > height){
      velocity.y = -0.5*velocity.y;
      location.y = height - 20;
    }
  }

  void display() {
    stroke(0);
    fill(175);

    rectMode(CENTER);
    pushMatrix();
    translate(location.x,location.y);
    rotate(velocity.heading());
    image(img, 0,0, 43, 23);
    popMatrix();
  }

}
