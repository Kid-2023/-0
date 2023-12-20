ArrayList<Leaf> leaves;
ArrayList<Sunlight> sunlights;
int sunlightCount = 100;
int leafCount = 50;
boolean recording = false;

void setup() {
  size(800, 600);
  leaves = new ArrayList<Leaf>();
  sunlights = new ArrayList<Sunlight>();
  for (int i = 0; i < leafCount; i++) {
    leaves.add(new Leaf(random(width), random(height - 100, height)));
  }
  for (int i = 0; i < sunlightCount; i++) {
    sunlights.add(new Sunlight(random(width), random(-500, -50)));
  }
}

void draw() {
  drawBackground();
  for (Sunlight s : sunlights) {
    s.disperseBasedOnMouse(mouseX);
    s.update();
    s.display();
  }
  for (Leaf l : leaves) {
    l.seekSunlight(sunlights);
    l.display();
  }

  if (recording) {
    saveFrame("frame-####.png");
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    recording = !recording; // 开始或停止录制
  }
}

void drawBackground() {
  for (int i = height; i >= 0; i--) {
    float inter = map(i, 0, height, 0, 1);
    int c = lerpColor(color(135, 206, 235), color(85, 107, 47), inter);
    stroke(c);
    line(0, i, width, i);
  }
}

// ... (其他类的定义保持不变)


class Sunlight {
  PVector position;
  PVector velocity;
  float disperseSpeed = 1;

  Sunlight(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 2);
  }

  void update() {
    position.add(velocity);
    if (position.y > height) {
      reset();
    }
  }

  void disperseBasedOnMouse(float mouseX) {
    float diff = position.x - mouseX;
    velocity.x = map(abs(diff), 0, width/2, 0, disperseSpeed) * sign(diff);
  }

  void reset() {
    position.y = random(-500, -50);
    position.x = random(width);
    velocity.x = 0;
  }

  void display() {
    fill(255, 204, 0);
    stroke(255, 204, 0, 50);
    strokeWeight(4);
    ellipse(position.x, position.y, 8, 8);
  }

  int sign(float value) {
    return value > 0 ? 1 : value < 0 ? -1 : 0;
  }
}

class Leaf {
  PVector position;
  float energy;

  Leaf(float x, float y) {
    position = new PVector(x, y);
    energy = 0;
  }

  void seekSunlight(ArrayList<Sunlight> sunlights) {
    for (Sunlight s : sunlights) {
      float d = PVector.dist(position, s.position);
      if (d < 20) {
        energy += 1;
        s.reset();
      }
    }
  }

  void display() {
    float brightGreen = map(energy, 0, 20, 100, 255);
    fill(0, brightGreen, 0);
    noStroke();
    ellipse(position.x, position.y + sin(frameCount / 10.0) * 2, 20 + energy, 10 + energy);
  }
}
