// 生命之树的基本参数
float angle; // 分支间的角度
float branchRatio; // 分支长度比率
int treeColor; // 树的颜色
float initialBranchLength = 120; // 初始主干长度
float growthSpeed = 0.5; // 生长速度
float maxBranchLength = 200; // 最大分枝长度

void setup() {
  size(800, 600); // 设置画布大小
  smooth(); // 平滑边缘
  angle = PI / 4; // 初始化分支角度
  branchRatio = 0.67; // 初始化分支长度比率
  treeColor = color(34, 139, 34); // 初始化树的颜色
}

void draw() {
  // 动态背景
  float time = millis() / 2000.0; // 获取当前时间
  setGradient(0, 0, width, height, color(135 + sin(time) * 60, 206, 250), color(255, 223 - cos(time) * 60, 186), Y_AXIS);

  // 更新树的颜色
  treeColor = color(34 + sin(time) * 30, 139, 34 + cos(time) * 30);
  stroke(treeColor);
  strokeWeight(2);
  translate(width/2, height);

  // 根据时间调整主干长度
  float currentBranchLength = initialBranchLength + sin(time) * growthSpeed;
  currentBranchLength = constrain(currentBranchLength, initialBranchLength, maxBranchLength);

  // 画树
  drawBranch(currentBranchLength);

  // 保存当前帧
  saveFrame("frame-####.png");
}

// 递归函数用于画树枝
void drawBranch(float len) {
  strokeWeight(map(len, 2, maxBranchLength, 1, 10));
  stroke(treeColor, 160 - len / maxBranchLength * 100);
  line(0, 0, 0, -len);
  translate(0, -len);

  len *= branchRatio;

  if (len > 2) {
    pushMatrix();
    rotate(angle);
    drawBranch(len);
    popMatrix();

    pushMatrix();
    rotate(-angle);
    drawBranch(len);
    popMatrix();
  }
}

void mouseMoved() {
  angle = map(mouseX, 0, width, 0, PI/2);
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {
  noFill();
  if (axis == Y_AXIS) {
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      stroke(lerpColor(c1, c2, inter));
      line(x, i, x+w, i);
    }
  }
}

final int Y_AXIS = 1;
