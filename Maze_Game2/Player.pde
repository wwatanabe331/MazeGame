// キャラクタークラス
abstract class Character {
  Position position;
  Character(Position position) {
    this.position = position;
  }
  void move(Direction dir, Maze maze) {
    int newX = position.x;
    int newY = position.y;
    switch(dir) {
    case UP:
      newY--;
      break;
    case DOWN:
      newY++;
      break;
    case LEFT:
      newX--;
      break;
    case RIGHT:
      newX++;
      break;
    }
    if (maze.isWalkable(newX, newY)) {
      position.setPosition(newX, newY);
    }
  }
}

// プレイヤークラス
class Player extends Character {
  Player(Position position) {
    super(position);
  }
}
// 敵クラス
class Enemy extends Character {
  Direction currentDirection;
  int stepsInCurrentDirection;
  final int MAX_STEPS = 5;

  Enemy(Position position) {
    super(position);
    chooseRandomDirection();
  }

  void chooseRandomDirection() {
    Direction[] directions = Direction.values();
    currentDirection = directions[int(random(directions.length))];
    stepsInCurrentDirection = 0;
  }

  void move(Maze maze, Player player) {
    // プレイヤーが5x5の範囲内にいるか確認
    if (isPlayerNearby(player, 5)) {
      // プレイヤーを追いかける
      moveTowardsPlayer(maze, player);
    } else {
      // 直線的に移動
      moveStraight(maze);
    }
  }

  void moveStraight(Maze maze) {
    if (stepsInCurrentDirection >= MAX_STEPS || !canMoveInDirection(maze, currentDirection)) {
      chooseRandomDirection();
    }

    int newX = position.x;
    int newY = position.y;
    switch(currentDirection) {
    case UP:
      newY--;
      break;
    case DOWN:
      newY++;
      break;
    case LEFT:
      newX--;
      break;
    case RIGHT:
      newX++;
      break;
    }

    if (maze.isWalkable(newX, newY)) {
      position.setPosition(newX, newY);
      stepsInCurrentDirection++;
    } else {
      chooseRandomDirection();
    }
  }

  boolean canMoveInDirection(Maze maze, Direction dir) {
    int newX = position.x;
    int newY = position.y;
    switch(dir) {
    case UP:
      newY--;
      break;
    case DOWN:
      newY++;
      break;
    case LEFT:
      newX--;
      break;
    case RIGHT:
      newX++;
      break;
    }
    return maze.isWalkable(newX, newY);
  }

  boolean isPlayerNearby(Player player, int range) {
    return abs(player.position.x - position.x) <= range &&
      abs(player.position.y - position.y) <= range;
  }

  void moveTowardsPlayer(Maze maze, Player player) {
    int dx = player.position.x - position.x;
    int dy = player.position.y - position.y;

    // 水平方向の移動を試みる
    if (abs(dx) >= abs(dy)) {
      if (dx > 0 && maze.isWalkable(position.x + 1, position.y)) {
        position.x++;
      } else if (dx < 0 && maze.isWalkable(position.x - 1, position.y)) {
        position.x--;
      } else {
        // 水平方向に移動できない場合、垂直方向を試みる
        if (dy > 0 && maze.isWalkable(position.x, position.y + 1)) {
          position.y++;
        } else if (dy < 0 && maze.isWalkable(position.x, position.y - 1)) {
          position.y--;
        }
      }
    }
    // 垂直方向の移動を試みる
    else {
      if (dy > 0 && maze.isWalkable(position.x, position.y + 1)) {
        position.y++;
      } else if (dy < 0 && maze.isWalkable(position.x, position.y - 1)) {
        position.y--;
      } else {
        // 垂直方向に移動できない場合、水平方向を試みる
        if (dx > 0 && maze.isWalkable(position.x + 1, position.y)) {
          position.x++;
        } else if (dx < 0 && maze.isWalkable(position.x - 1, position.y)) {
          position.x--;
        }
      }
    }
  }
}
