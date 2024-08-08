// ゲームの状態を管理する列挙型
enum GameState {
  TITLE, PLAYING, GAME_OVER
}
// 方向を表す列挙型
enum Direction {
  UP, DOWN, LEFT, RIGHT
}

Game game;
GamePanel gamePanel;
void setup() {
  size(600, 640);
  game = new Game();
  gamePanel = new GamePanel(game);
}
void draw() {
  game.update();
  gamePanel.draw();
}
void keyPressed() {
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
    if (dir != null) {
      game.player.move(dir, game.currentMaze);
    }
  } else if (key == ' ') {
    if (game.state == GameState.TITLE || game.state == GameState.GAME_OVER) {
      game.initializeGame();
      game.start();
    }
  }
}
