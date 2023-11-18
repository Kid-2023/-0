import java.util.ArrayList;

class MovingCircle {
    float x, y;
    float diameter;
    float xSpeed, ySpeed;
    color c;
    ArrayList<PVector> history;

    MovingCircle(float x, float y, float diameter, color c) {
        this.x = x;
        this.y = y;
        this.diameter = diameter;
        this.c = c;
        xSpeed = random(-3, 3);
        ySpeed = random(-3, 3);
        history = new ArrayList<PVector>();
    }

    void update() {
        x += xSpeed;
        y += ySpeed;

        if (x < diameter / 2 || x > width - diameter / 2) {
            xSpeed *= -1;
        }
        if (y < diameter / 2 || y > height - diameter / 2) {
            ySpeed *= -1;
        }

        history.add(new PVector(x, y));
        if (history.size() > 10) {
            history.remove(0);
        }
    }

    void display() {
        for (int i = 0; i < history.size(); i++) {
            float alpha = map(i, 0, history.size(), 0, 255);
            fill(c, alpha);
            PVector pos = history.get(i);
            ellipse(pos.x, pos.y, diameter, diameter);
        }

        fill(c);
        noStroke();
        ellipse(x, y, diameter, diameter);
    }

    void shake() {
        xSpeed += random(-1, 1);
        ySpeed += random(-1, 1);
    }
}

MovingCircle[] circles;
int numCircles = 20;
float shakeAmount = 0;
boolean recording = false; // 控制录制状态的标志

void setup() {
    size(800, 600);
    circles = new MovingCircle[numCircles];

    for (int i = 0; i < numCircles; i++) {
        float diameter = random(20, 50);
        color c = color(random(255), random(255), random(255));
        circles[i] = new MovingCircle(random(diameter, width - diameter), random(diameter, height - diameter), diameter, c);
    }
}

void draw() {
    if (shakeAmount > 0) {
        translate(random(-shakeAmount, shakeAmount), random(-shakeAmount, shakeAmount));
        shakeAmount *= 0.9;
    }

    fill(255, 10); 
    noStroke();
    rect(0, 0, width, height);

    for (int i = 0; i < numCircles; i++) {
        circles[i].update();
        circles[i].display();
    }

    // 如果正在录制，则保存当前帧
    if (recording) {
        saveFrame("frame-####.png");
    }
}

void mousePressed() {
    shakeAmount = 10;

    for (int i = 0; i < numCircles; i++) {
        circles[i].shake();
    }

    // 切换录制状态
    recording = !recording;
}

// 可选：添加一个键盘事件处理函数来手动停止录制
void keyPressed() {
    if (key == 's' || key == 'S') {
        recording = false;
    }
}
