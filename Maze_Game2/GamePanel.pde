// ゲームパネルクラス
class GamePanel {
  Game game;

  GamePanel(Game game) {
    this.game = game;
  }

  void draw() {
    background(200);
    switch(game.state) {
    case TITLE:
      drawTitle();
      break;
    case PLAYING:
      drawMaze();
      drawPlayer();
      drawEnemies();
      drawPoints();
      drawScore();
      break;
    case GAME_OVER:
      drawGameOver();
      break;
    }
  }
  void drawTitle() {
    background(110);
    PImage title = loadImage("start.png");
    image(title, 0, 0, 600, 600);
    // 文字を点滅させる処理
    if (frameCount / 10 % 2 == 0) {
      fill(110);
    } else {
      textAlign(CENTER, CENTER);
      textSize(32);
      fill(17, 255, 16);
      textSize(24);
      text("Press SPACE to start", width/2, height*2/3);
    }
  }
  void drawMaze() {
    
    int yOffset = 40;
    for (int y = 0; y < game.currentMaze.height; y++) {
      for (int x = 0; x < game.currentMaze.width; x++) {
        if (game.currentMaze.tiles[y][x] == 1) {
          fill(0);
        } else {
          fill(255);
        }
        rect(x * game.cellSize, y * game.cellSize + yOffset, game.cellSize, game.cellSize);
      }
    }
  }

  void drawPlayer() {
    int yOffset = 40;
    fill(0, 255, 0);
    ellipse(game.player.position.x * game.cellSize + game.cellSize/2,
      game.player.position.y * game.cellSize + game.cellSize/2 + yOffset,
      game.cellSize * 0.8, game.cellSize * 0.8);
  }

  void drawEnemies() {
    int yOffset = 40;
    fill(255, 0, 0);
    for (Enemy enemy : game.enemies) {
      ellipse(enemy.position.x * game.cellSize + game.cellSize/2,
        enemy.position.y * game.cellSize + game.cellSize/2 + yOffset,
        game.cellSize * 0.8, game.cellSize * 0.8);
    }
  }

  void drawPoints() {
    int yOffset = 40;
    fill(255, 255, 0);
    for (Point point : game.points) {
      ellipse(point.position.x * game.cellSize + game.cellSize/2,
        point.position.y * game.cellSize + game.cellSize/2 + yOffset,
        game.cellSize * 0.4, game.cellSize * 0.4);
    }
  }
  void drawScore() {
    // 背景を描画
    fill(211, 211, 211);
    rect(0, 0, width, 40);

    // テキストの設定
    fill(0, 0, 255);
    textAlign(LEFT, CENTER);
    textSize(20);

    // スコア、レベル、時間を横並びで表示
    text("Score: " + game.score, 10, 20);
    text("Level: " + game.currentLevel, width/3, 20);
    text("Time: " + game.remainingTime, 2*width/3, 20);
  }
  void drawGameOver() {
    background(110);
    textAlign(CENTER, CENTER);
    textSize(32);
    fill(17, 255, 16);

    if (game.currentLevel > 3) {
      text("Congratulations!\nYou cleared all levels!", width/2, height/3);
      textSize(24);
      text("Clear Time: " + (180 - game.remainingTime) + " seconds", width/2, height/2 + 40);
    } else {
      text("Game Over", width/2, height/3);
    }
    textSize(24);
    text("Final Score: " + game.score, width/2, height/2);

    //文字を点滅させる処理
      if (frameCount / 50 % 2 == 0) {
      fill(110);
    } else {
      textAlign(CENTER, CENTER);
      textSize(32);
      fill(17, 255, 16);
      textSize(24);
      text("Press SPACE to start", width/2, height*2/3);
    }
  }
}
