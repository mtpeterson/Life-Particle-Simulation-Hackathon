int spawnTolerance;

//int atomNumber = 300;
int redNumber = 300;
int greenNumber = 500;
int blueNumber = 400;
int whiteNumber = 400;
int attractionRange = 80;
float dampener = 0.5;

Atom[] reds = new Atom[redNumber];
Atom[] greens = new Atom[greenNumber];
Atom[] blues = new Atom[blueNumber];
Atom[] whites = new Atom[whiteNumber];
Atom[][] atoms = {reds, greens, blues, whites};

int state;

boolean white;

void setup() {
  noStroke();
  size(800, 800);
  create(reds, color(255, 0, 0));
  create(greens, color(0, 255, 0));
  create(blues, color(0, 0, 255));
  create(whites, color(255));
  
  state = 0;
  white = false;
}

void draw() {
  background(32);
  
  switch(state) {
    case 0:
      white = false;
      preset0();
      break;
    case 1:
      white = false;
      preset1();
      break;
    case 2:
      white = false;
      preset2();
      break;
    case 3:
      preset3();
      white = true;
      break;
    case 4:
      white = true;
      preset4();
      break;
    case 5:
      white = true;
      preset5();
      break;
    case 6:
      state = 0;
      white = false;
      break;
  }
  //preset1();
  //preset2();
  
  render(atoms);
}

void preset5() {
  rule(greens, greens, -.025);
  rule(greens, reds, 0.15);
  rule(greens, whites, -0.085);
  rule(greens, blues, 0);
  
  rule(reds, reds, 0.17);
  rule(reds, greens, -0.175);
  rule(reds, whites, 0.16);
  rule(reds, blues, 0);
  
  rule(whites, whites, -0.17);
  rule(whites, reds, 0);
  rule(whites, greens, -0.14);
  rule(whites, blues, 0.225);
  
  rule(blues, blues, -0.04);
  rule(blues, whites, -0.015);
  rule(blues, reds, 0);
  rule(blues, greens, 0.265);
  
  if(mousePressed && (mouseButton == LEFT)) {
    mouseRule(whites, mouseX, mouseY, -10);
  }
}

void preset4() {
  rule(greens, greens, 0.6);
  rule(greens, reds, 0.965);
  rule(greens, whites, -0.565);
  rule(greens, blues, 0.375);
  
  rule(reds, reds, -0.635);
  rule(reds, greens, -0.31);
  rule(reds, whites, 0.65);
  rule(reds, blues, -0.315);
  
  rule(whites, whites, -0.205);
  rule(whites, reds, 0);
  rule(whites, greens, -0.445);
  rule(whites, blues, 0.68);
  
  rule(blues, blues, 0.1);
  rule(blues, whites, -0.495);
  rule(whites, reds, 0);
  rule(whites, greens, 1);
}

void preset3() {
  rule(greens, greens, 0.456);
  rule(greens, reds, 0.596);
  rule(greens, whites, -0.544);
  rule(greens, blues, 0.488);
  
  rule(reds, reds, -0.464);
  rule(reds, greens, 0.804);
  rule(reds, whites, -0.564);
  rule(reds, blues, -0.852);
  
  rule(whites, whites, -1);
  rule(whites, reds, -0.972);
  rule(whites, greens, 0.416);
  rule(whites, blues, -0.528);
  
  rule(blues, blues, 0.264);
  rule(blues, whites, -1);
  rule(whites, reds, 0.076);
  rule(whites, greens, -0.864);
  
  if(mousePressed && (mouseButton == LEFT)) {
    mouseRule(reds, mouseX, mouseY, -10);
    mouseRule(whites, mouseX, mouseY, -10);
    mouseRule(blues, mouseX, mouseY, -10);
  } else if(mousePressed && (mouseButton == RIGHT)) {
    mouseRule(reds, mouseX, mouseY, 10);
    mouseRule(whites, mouseX, mouseY, 10);
    mouseRule(blues, mouseX, mouseY, 10);
  }
}

void preset2() {
  rule(reds, reds, 0.1);
  rule(blues, reds, 0.15);
  rule(greens, greens, -0.7);
  rule(greens, reds, -0.2);
  rule(reds, greens, -0.1);
  
  if(mousePressed && (mouseButton == LEFT)) {
    mouseRule(reds, mouseX, mouseY, -10);
  }
}

void preset1() {
  rule(greens, greens, -0.32);
  rule(greens, reds, -0.17);
  rule(greens, blues, 0.34);
  rule(reds, reds, -0.10);
  rule(reds, greens, -0.34);
  rule(blues, blues, 0.15);
  rule(blues, greens, -0.20);
  
  if(mousePressed && (mouseButton == LEFT)) {
    mouseRule(reds, mouseX, mouseY, -10);
  }
}

void preset0() {
  rule(greens, greens, 0.1);
  rule(reds, reds, 0.1);
  rule(blues, blues, 0.1);
  rule(whites, whites, 0.1);
  
  if(mousePressed && (mouseButton == LEFT)) {
    mouseRule(reds, mouseX, mouseY, -10);
    mouseRule(greens, mouseX, mouseY, -10);
    mouseRule(blues, mouseX, mouseY, -10);
  } else if(mousePressed && (mouseButton == RIGHT)) {
    mouseRule(reds, mouseX, mouseY, 10);
    mouseRule(greens, mouseX, mouseY, 10);
    mouseRule(blues, mouseX, mouseY, 10);
  }
}

void render(Atom[][] atomss) {
  for(int j = 0; j < atomss.length; j++) {
    for(int i = 0; i < atomss[j].length; i++) {
      if(j < 3) {
        atomss[j][i].render();
      } else if (white == true) {
        atomss[j][i].render();
      }
      //reds[i].render();
      //greens[i].render();
      //blues[i].render();
    }
  }
}

void rule(Atom[] array1, Atom[] array2, float g) {
  for(int i = 0; i < array1.length; i++) {
    float fx = 0;
    float fy = 0;
    Atom a = array1[i];
    for(int j = 0; j < array2.length; j++) {
      Atom b = array2[j];
      float dx = a.x - b.x;
      float dy = a.y - b.y;
      float dist = sqrt((dx*dx) + (dy*dy));
      if(dist > 0 && dist < attractionRange) {
        float F = g * 1/dist;
        fx += (F * dx);
        fy += (F * dy);
      }
    }
    a.vx = (a.vx + fx) * dampener;
    a.vy = (a.vy + fy) * dampener;
    a.x += a.vx;
    a.y += a.vy;
    if(a.x <= 0 || a.x >= width) {
      if(a.x <= 0) {
        a.vx = abs(a.vx);
      } else if (a.x >= width) {
        a.vx = -abs(a.vx); 
      }
    }
    if(a.y <= 0 || a.y >= height) {
      if(a.y <= 0) {
        a.vy = abs(a.y);
      } else if (a.y >= height) {
        a.vy = -abs(a.vy); 
      }
    }
  }
}

void create(Atom[] array, color col) {
  for(int i = 0; i < array.length; i++) {
    array[i] = new Atom(random(spawnTolerance, width-spawnTolerance),
                        random(spawnTolerance, height-spawnTolerance),
                        col);
  }
}

void keyPressed() {
  if(key == ' ') {
    state ++;
  }
  if(key == 'e') {
    state = 0;
  }
  if(key == '1') {
    state = 1;
  }
  if(key == '2') {
    state = 2;
  }
  if(key == '3') {
    state = 3;
  }
  if(key == '4') {
    state = 4;
  }
  if(key == '5') {
    state = 5;
  }
}

void mouseRule(Atom[] array1, int x, int y, float g) {
  for(int i = 0; i < array1.length; i++) {
    float fx = 0;
    float fy = 0;
    Atom a = array1[i];
    
      float dx = a.x - x;
      float dy = a.y - y;
      float dist = sqrt((dx*dx) + (dy*dy));
      if(dist > 0 && dist < attractionRange) {
        float F = g * 1/dist;
        fx += (F * dx);
        fy += (F * dy);
      }
    
    a.vx = (a.vx + fx) * dampener;
    a.vy = (a.vy + fy) * dampener;
    a.x += a.vx;
    a.y += a.vy;
    if(a.x <= 0 || a.x >= width) {
      if(a.x <= 0) {
        a.vx = abs(a.vx);
      } else if (a.x >= width) {
        a.vx = -abs(a.vx); 
      }
    }
    if(a.y <= 0 || a.y >= height) {
      if(a.y <= 0) {
        a.vy = abs(a.y);
      } else if (a.y >= height) {
        a.vy = -abs(a.vy); 
      }
    }
  }
}
