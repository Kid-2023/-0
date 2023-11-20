void setup() {
  size(640, 640); 
  background(255);
  noLoop();

  int linesCount = int(random(5, 10)); 
  float[] xLines = new float[linesCount];
  float[] yLines = new float[linesCount];

  for (int i = 0; i < linesCount; i++) {
    xLines[i] = random(width);
    yLines[i] = random(height);
  }

  color[] colors = {color(255, 0, 0), color(0, 0, 255), color(255, 255, 0), color(0), color(255)};

  strokeWeight(3);
  for (float x : xLines) {
    line(x, 0, x, height);
  }
  for (float y : yLines) {
    line(0, y, width, y);
  }

  strokeWeight(10);
  for (float x : xLines) {
    for (float y : yLines) {
      stroke(colors[int(random(colors.length))]);
      point(x, y);
    }
  }
}
