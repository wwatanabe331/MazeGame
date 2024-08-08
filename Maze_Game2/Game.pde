// メインゲームクラス
class Game {
  Maze currentMaze;
  Player player;
  ArrayList<Enemy> enemies;
  ArrayList<Point> points;
  int score;
  GameState state;
  int currentLevel;
  int remainingTime;
  int lastEnemyMoveTime;
  int cellSize;
  
  
  Game() {
    state = GameState.TITLE;
    currentLevel = 1;
    initializeGame();
  }
  void initializeGame() {
    score = 0;
    currentLevel = 1;
    loadLevel(currentLevel);
    lastEnemyMoveTime = millis();
    state = GameState.PLAYING; // 追加start() メソッドを統合
  }
  
  void loadLevel(int level) {
    switch(level) {
    case 1:
      currentMaze = new Maze(20, 20);
      break;
    case 2:
      currentMaze = new Maze(24, 24);
      break;
    case 3:
      currentMaze = new Maze(30, 30);
      break;
    }
    // 迷路全体が表示されるように cellSize を計算
  cellSize = min((height - 40) / currentMaze.height, width / currentMaze.width);
  // 迷路の幅に合わせてウィンドウサイズを調整
  surface.setSize(currentMaze.width * cellSize, height);
  remainingTime = 60 + (level - 1) * 30; // レベルに応じて時間を設定
  

    player = new Player(new Position(1, 1));
    
    
    
    // 敵の配置
    enemies = new ArrayList<Enemy>();
    enemies.add(new Enemy(findWalkablePosition()));
    if (level > 1) {
      enemies.add(new Enemy(findWalkablePosition()));
    }
    if (level > 2) {
      enemies.add(new Enemy(findWalkablePosition()));
      enemies.add(new Enemy(findWalkablePosition()));
    }
    // ポイントの配置
    points = new ArrayList<Point>();
    for (int i = 0; i < 5 * level; i++) {
      points.add(new Point(findWalkablePosition())); // findWalkablePositionForPoint を簡略化
    }
  }
  
  
  //Position findWalkablePositionForPoint() {
  //  Position pos;
  //  boolean isValidPosition;
  //  do {
  //    pos = findWalkablePosition();
  //    isValidPosition = hasAdjacentWalkableCell(pos);
  //  } while (!isValidPosition);
  //  return pos;
  //}
  //boolean hasAdjacentWalkableCell(Position pos) {
  //  int[][] directions = {{0, -1}, {1, 0}, {0, 1}, {-1, 0}}; // 上、右、下、左
  //  for (int[] dir : directions) {
  //    int newX = pos.x + dir[0];
  //    int newY = pos.y + dir[1];
  //    if (currentMaze.isWalkable(newX, newY)) {
  //      return true;
  //    }
  //  }
  //  return false;
  //}
  
  Position findWalkablePosition() {
    int x, y;
    do {
      x = int(random(1, currentMaze.width - 1));
      y = int(random(1, currentMaze.height - 1));
    } while (!currentMaze.isWalkable(x, y));
    return new Position(x, y);
  }
  void start() {
    state = GameState.PLAYING;
  }
  void update() {
    if (state != GameState.PLAYING) return;
    // 時間の更新
    if (frameCount % 60 == 0) {
      remainingTime--;
      if (remainingTime <= 0) {
        gameOver();
        return;
      }
    }
    // 敵の移動（0.5秒に1回）
    if (millis() - lastEnemyMoveTime > 500) {
      for (Enemy enemy : enemies) {
        enemy.move(currentMaze, player);
        if (enemy.position.equals(player.position)) {
          gameOver();
          return;
        }
      }
      lastEnemyMoveTime = millis();
    }
    // ポイントの収集
    for (int i = points.size() - 1; i >= 0; i--) {
      if (points.get(i).position.equals(player.position)) {
        points.remove(i);
        score += 10;
        if (points.isEmpty()) {
          nextLevel();
        }
      }
    }
  }
  void nextLevel() {
    currentLevel++;
    if (currentLevel > 3) {
      // ゲームクリア
      state = GameState.GAME_OVER;
    } else {
      loadLevel(currentLevel);
    }
  }
  void gameOver() {
    state = GameState.GAME_OVER;
  }
}
