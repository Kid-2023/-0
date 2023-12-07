PImage sourceImage;
int maxTileSize = 11; 
PVector[][] positions; 
PVector[][] starts;    
float[][] progress;   
float[][] radii;       

void setup() {
  size(804, 826);
  sourceImage = loadImage("屏幕截图 2023-12-07 180233.png"); 
  sourceImage.resize(width, height);
  int cols = width / maxTileSize;
  int rows = height / maxTileSize;
  positions = new PVector[cols][rows];
  starts = new PVector[cols][rows];
  progress = new float[cols][rows];
  radii = new float[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      positions[i][j] = new PVector(i * maxTileSize + maxTileSize / 2, j * maxTileSize + maxTileSize / 2);
      starts[i][j] = new PVector(random(-width, 2 * width), random(-height, 2 * height));
      progress[i][j] = 0;
      radii[i][j] = random(3, maxTileSize / 2); 
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < positions.length; i++) {
    for (int j = 0; j < positions[0].length; j++) {
      PVector start = starts[i][j];
      PVector end = positions[i][j];
      float amt = sqrt(progress[i][j]); 
      PVector current = PVector.lerp(start, end, amt);
      int tileColor = sourceImage.get((int)end.x, (int)end.y);
      fill(tileColor);
      noStroke();
      ellipse(current.x, current.y, radii[i][j] * 2, radii[i][j] * 2); 
      progress[i][j] += 0.005; 
      progress[i][j] = constrain(progress[i][j], 0, 1);
    }
  }

  saveFrame("frame-####.png"); 

  if (allTilesSettled()) {
    noLoop();
  }
}

boolean allTilesSettled() {
  for (int i = 0; i < progress.length; i++) {
    for (int j = 0; j < progress[0].length; j++) {
      if (progress[i][j] < 1) {
        return false;
      }
    }
  }
  return true;
}
