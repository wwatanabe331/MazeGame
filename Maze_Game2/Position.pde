// 位置クラス
class Position {
  int x, y;
  Position(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void setPosition(int newX, int newY) {
    this.x = newX;
    this.y = newY;
  }
  boolean equals(Position other) {
    return this.x == other.x && this.y == other.y;
  }
}
