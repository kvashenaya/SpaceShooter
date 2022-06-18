GameBoy gb = new GameBoy();

int shipX = 5;

ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
ArrayList<Enemy> simpleEnemies = new ArrayList<Enemy>();

void setup() {
  size(285, 565);
  gb.begin(0);
}

void draw() {
  gb.drawDisplay();
  println(bulletList.size());
  shipDraw(shipX);
  drawBullet();
  drawEnemies();

  if (frameCount % 1 == 0) {
    moveBullets();
    checkCollision();
  }

  if (frameCount % 30 == 0) {
    moveEnemies();
  }

  if (frameCount % 60 == 0) {
    clearBullets();  
    simpleEnemies.add(new Enemy((int)random(0, 7), -1));
  }
}


void checkCollision() {
  if (bulletList.size() > 0 && simpleEnemies.size() > 0) {
    for (int i = 0; i < bulletList.size(); i++) {
      for (int j = 0; j < simpleEnemies.size(); j++) {
        if (bulletList.get(i).x == simpleEnemies.get(j).x && bulletList.get(i).y == simpleEnemies.get(j).y) {
          bulletList.get(i).y = -1;
          simpleEnemies.remove(simpleEnemies.get(j));
        }
      }
    }
  }
}

void moveEnemies() {
  if (simpleEnemies.size() > 0) {
    for (int i = 0; i < simpleEnemies.size(); i++) {
      simpleEnemies.get(i).y++;
    }
  }
}

void drawEnemies() {
  if (simpleEnemies.size() > 0) {
    for (int i = 0; i < simpleEnemies.size(); i++) {
      gb.drawPoint(simpleEnemies.get(i).x, simpleEnemies.get(i).y);
    }
  }
}

void clearBullets() {
  for (int i = 0; i < bulletList.size(); i++) {
    if (bulletList.get(i).y < 0) {
      bulletList.remove(bulletList.get(i));
    }
  }
}

void moveBullets() {
  if (bulletList.size() > 0) {
    for (int i = 0; i < bulletList.size(); i++) {
      Bullet currentBullet = bulletList.get(i);
      currentBullet.y--;
    }
  }
}

void drawBullet() {
  if (bulletList.size() > 0) {
    for (int i = 0; i < bulletList.size(); i++) {
      gb.drawPoint(bulletList.get(i).x, bulletList.get(i).y);
    }
  }
}

void shoot(int bulletX) {
  bulletList.add(new Bullet(bulletX, 14));
}

void shipDraw(int hX) {
  gb.drawPoint(hX, 14);
  gb.drawPoint(hX, 15);
  gb.drawPoint(hX + 1, 15);
  gb.drawPoint(hX - 1, 15);
}

void keyPressed() {
  if (gb.getKey() == 4 && shipX > 0) {
    shipX--;
  }

  if (gb.getKey() == 5 && shipX < 7) {
    shipX++;
  }

  if (gb.getKey() == 3) {
    shoot(shipX);
  }
}
