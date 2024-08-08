class Enemy {
  Position position;

  Enemy(Position position) {
    this.position = position;
  }

  void move(Maze maze, Player player) {
    if (isPlayerNearby(player, 5)) {
      moveTowardsPlayer(maze, player);
    } else {
      moveRandomly(maze);
    }
  }

  boolean isPlayerNearby(Player player, int range) {
    return abs(player.position.x - position.x) <= range &&
           abs(player.position.y - position.y) <= range;
  }
  void moveTowardsPlayer(Maze maze, Player player) {
    int dx = player.position.x - position.x;
    int dy = player.position.y - position.y;

    if (abs(dx) >= abs(dy)) {
      if (dx > 0 && maze.isWalkable(position.x + 1, position.y)) {
        position.x++;
      } else if (dx < 0 && maze.isWalkable(position.x - 1, position.y)) {
        position.x--;
      } else {
        if (dy > 0 && maze.isWalkable(position.x, position.y + 1)) {
          position.y++;
        } else if (dy < 0 && maze.isWalkable(position.x, position.y - 1)) {
          position.y--;
        }
      }
      } else {
      if (dy > 0 && maze.isWalkable(position.x, position.y + 1)) {
        position.y++;
      } else if (dy < 0 && maze.isWalkable(position.x, position.y - 1)) {
        position.y--;
      } else {
        if (dx > 0 && maze.isWalkable(position.x + 1, position.y)) {
          position.x++;
        } else if (dx < 0 && maze.isWalkable(position.x - 1, position.y)) {
          position.x--;
        }
      }
    }
  }
  
  void moveRandomly(Maze maze) {
    int[][] directions = {{0, -1}, {1, 0}, {0, 1}, {-1, 0}};
    int[] dir = directions[int(random(4))];
    int newX = position.x + dir[0];
    int newY = position.y + dir[1];
    if (maze.isWalkable(newX, newY)) {
      position.setPosition(newX, newY);
    }
  }
}
