// ゲームの状態を管理する列挙型
enum GameState {
  TITLE, PLAYING, GAME_OVER
}
// 方向を表す列挙型
enum Direction {
  UP, DOWN, LEFT, RIGHT
}

//GameクラスとGameパネルクラスを宣言
Game game;
GamePanel gamePanel;

void setup() {
  //game画面が600,600で、40に得点や時間を書く
  size(600, 640);
  //初期化
  game = new Game();
  gamePanel = new GamePanel(game);
}


void draw() {
  //Gameクラスのupdateメソッド(時間の更新、敵の移動、ポイントの収集計算)
  game.update();
  //GamePanelクラスのdrawメソッド(GameStateの状態で描画をわけている)
  gamePanel.draw();
}


void keyPressed() {
  //ゲームがプレイ状態の時 矢印キーで押されたものをdirに入れる
  if (game.state == GameState.PLAYING) {
    Direction dir = null;
    switch(keyCode) {
    case UP:
      dir = Direction.UP;
      break;
    case DOWN:
      dir = Direction.DOWN;
      break;
    case LEFT:
      dir = Direction.LEFT;
      break;
    case RIGHT:
      dir = Direction.RIGHT;
      break;
    }
    
    //dirの中に矢印キーが入っていれば,
    //Gameクラスのplayerに(押された方向、現在の迷路)が初期化して
    //Plyerクラスのmoveメソッドに送られる そして移動が完了する
    if (dir != null) {
      game.player.move(dir, game.currentMaze);
    }
    //もし、押されたキーがspaceキーかつ、ゲームの状態がタイトル画面か、ゲームオーバー時
    //であれば、GameクラスのinitializeGameメソッドでゲームの初期化を行い
    //Gameクラスのstart
  } else if (key == ' ') {
    if (game.state == GameState.TITLE || game.state == GameState.GAME_OVER) {
      //ゲームの初期化
      game.initializeGame();
      //spaceキーの入力によって、
      //PLAYINGに変更したいのでGameクラスのそれ用のstartメソッドを作成
      game.start();
    }
  }
}
