// 敵キャラクターを表すクラス
class Enemy {
  Position position;  // 敵の現在位置

  // コンストラクタ: 初期位置を設定
  Enemy(Position position) {
    this.position = position;
  }

  // 敵の移動を制御するメソッド
  void move(Maze maze, Player player) {
    // プレイヤーが近くにいるかチェック（範囲5マスまで）
    if (isPlayerNearby(player, 5)) {
      moveTowardsPlayer(maze, player);  // プレイヤーに向かって移動
    } else {
      moveRandomly(maze);  // ランダムに移動
    }
  }

  // プレイヤーが指定された範囲内にいるかチェックするメソッド
  boolean isPlayerNearby(Player player, int range) {
    // X軸とY軸の距離がともにrange以下ならtrueを返す
    return abs(player.position.x - position.x) <= range &&
      abs(player.position.y - position.y) <= range;
  }

  // プレイヤーに向かって移動するメソッド
  void moveTowardsPlayer(Maze maze, Player player) {
    // プレイヤーとの距離を計算
    int dx = player.position.x - position.x;
    int dy = player.position.y - position.y;

    // X軸の距離がY軸の距離以上の場合
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

  // ランダムに移動するメソッド
  void moveRandomly(Maze maze) {
    // 上下左右の4方向を定義
    int[][] directions = {{0, -1}, {1, 0}, {0, 1}, {-1, 0}};
    // ランダムに方向を選択
    int[] dir = directions[int(random(4))];
    // 新しい位置を計算
    int newX = position.x + dir[0];
    int newY = position.y + dir[1];
    // 新しい位置が歩行可能であれば移動
    if (maze.isWalkable(newX, newY)) {
      position.setPosition(newX, newY);
    }
  }
}
