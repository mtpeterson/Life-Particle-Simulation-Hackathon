// Represents an atom - the building block
class Atom {
  float x;
  float y;
  float vx;
  float vy;
  int d;
  color fillColor;
  
  Atom(float xPos, float yPos, color fill) {
    d = 5;
    x = xPos;
    y = yPos;
    //vx = xVel;
    //vy = yVel;
    vx = 0;
    vy = 0;
    fillColor = color(fill);
  }
  
  void render() {
    fill(fillColor);
    circle(x, y, d);
  }
  
}
