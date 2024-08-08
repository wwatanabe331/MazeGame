// メインのゲームクラス
class Game {
  // レベルによって現在の迷路を設定する
  Maze currentMaze;
  // プレイヤーオブジェクト
  Player player;
  // 敵のリスト
  ArrayList<Enemy> enemies;
  // ポイントのリスト
  ArrayList<Point> points;
  
  int score;
  // ゲームの状態
  GameState state;
  // 現在のレベル
  int currentLevel;
  // 残り時間
  int remainingTime;
  // 最後の敵移動時間　敵を0.5秒に1マス動かしたいので設定
  int lastEnemyMoveTime;
  // セルのサイズ
  int cellSize;

  // コンストラクタ
  Game() {
    // 初期状態はタイトル画面
    state = GameState.TITLE;
    // ゲームを初期化
    initializeGame();
  }

  // ゲームの初期化
  void initializeGame() {
    // スコアを0にリセット
    score = 0;
    // レベルを1に設定
    currentLevel = 1;
    // レベルをロードして、レベルごとに迷路を作成したり、主人公の初期位置や、残り時間、
    loadLevel(currentLevel);
    
    // 最後の敵移動時間を現在のミリ秒に設定
    lastEnemyMoveTime = millis();
  }

  // ゲームを開始
  void start() {
    // ゲームの状態をプレイ中に設定
    state = GameState.PLAYING;
  }
  
  // ゲームオーバー
  void gameOver() {
    state = GameState.GAME_OVER;
  }

  // レベルをロード
  void loadLevel(int level) {
    // レベルに応じて迷路のサイズを設定してMazeクラスに初期化する
    //ゲームの画面は変えず、1マスの細かさで難易度を表す
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
        
    //1マスのサイズを計算
    cellSize = width / currentMaze.width;
    
    // レベルに応じて残り時間を設定
    remainingTime = 60 + (level - 1) * 30;

    // プレイヤーを初期位置に設定
    player = new Player(new Position(1, 1));


    // 敵の配置
    //ステージごとに敵のリストをリセット
    enemies = new ArrayList<Enemy>();
    //レベル1: 2体の敵　レベル2: 3体の敵　レベル3: 4体の敵
    for(int i = 0; i < level + 1; i++){
      enemies.add(new Enemy(findWalkablePosition()));
    }

    // ポイントの配置
    points = new ArrayList<Point>();
    for (int i = 0; i < 5 * level; i++) {
      points.add(new Point(findWalkablePosition()));
    }
  }

  // 歩行可能な位置を見つける
  Position findWalkablePosition() {
    int x, y;
    do {
      //最初にランダムな位置を生成
      x = int(random(1, currentMaze.width - 1));
      y = int(random(1, currentMaze.height - 1));
    } while (!currentMaze.isWalkable(x, y));
    return new Position(x, y);
  }

  // ゲームの更新
  void update() {
    // プレイ中でない場合は何もしない
    if (state != GameState.PLAYING) return;
    
    // 1秒ごとに残り時間を更新
    if (frameCount % 60 == 0) {
      remainingTime--;
      if (remainingTime <= 0) {
        // 時間切れでゲームオーバーを呼び出す
        gameOver();
        return;
      }
    }
    
    
    // 敵の移動（0.5秒に1回）
    if (millis() - lastEnemyMoveTime > 500) {
      //Enemyオブジェクトのenemiesをenemy変数に代入し一体ずつ動かしてく
      for (Enemy enemy : enemies) {
        //Enemyクラスのmoveメソッドに現在の迷路と主人公の位置をおくる
        enemy.move(currentMaze, player);
        if (enemy.position.equals(player.position)) {
          // 敵とプレイヤーが同じ位置に来たらゲームオーバー
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
        // 全てのポイントを収集したら次のレベルへ
        if (points.isEmpty()) {
          nextLevel();
        }
      }
    }
  }

  // 次のレベルに進む
  void nextLevel() {
    currentLevel++;
    if (currentLevel > 3) {
      // すべてのレベルをクリアしたらゲームオーバー
      state = GameState.GAME_OVER;
    } else {
      // 次のレベルをロード
      loadLevel(currentLevel);
    }
  }

  
}
