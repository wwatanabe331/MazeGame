//主人公クラス
class Player {
  Position position;

  Player(Position position) {
    this.position = position;
  }

  void move(Direction dir, Maze maze) {
    
    int newX = position.x;
    int newY = position.y;
    
    switch(dir) {
      case UP: newY--; break;
      case DOWN: newY++; break;
      case LEFT: newX--; break;
      case RIGHT: newX++; break;
    }
    
    if (maze.isWalkable(newX, newY)) {
      position.setPosition(newX, newY);
    }
  }
}
