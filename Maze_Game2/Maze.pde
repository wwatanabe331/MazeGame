// 迷路クラス
class Maze {
  int[][] tiles;
  int width, height;
  
  Maze(int w, int h) {
    width = w;
    height = h;
    tiles = new int[height][width];
    generateMaze();
  }
  void generateMaze() {
    // 全てを壁(1)で埋める
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        tiles[y][x] = 1;
      }
    }
    // 深さ優先探索で迷路を生成
    dfs(1, 1);
    // 追加の通路を作成
    for (int i = 0; i < width * height / 10; i++) {
      int x = int(random(1, width - 1));
      int y = int(random(1, height - 1));
      tiles[y][x] = 0;
    }
    // スタートとゴールを確保
    tiles[1][1] = 0;
    tiles[height - 2][width - 2] = 0;
  }
  void dfs(int x, int y) {
    int[][] directions = {{0, -2}, {2, 0}, {0, 2}, {-2, 0}};
    shuffleArray(directions);
    for (int[] d : directions) {
      int nx = x + d[0];
      int ny = y + d[1];
      if (nx > 0 && ny > 0 && nx < width - 1 && ny < height - 1 && tiles[ny][nx] == 1) {
        tiles[y + d[1]/2][x + d[0]/2] = 0;
        tiles[ny][nx] = 0;
        dfs(nx, ny);
      }
    }
  }
  void shuffleArray(int[][] array) {
    for (int i = array.length - 1; i > 0; i--) {
      int index = floor(random(i + 1));
      int[] temp = array[index];
      array[index] = array[i];
      array[i] = temp;
    }
  }
  boolean isWalkable(int x, int y) {
    if (x < 0 || y < 0 || x >= width || y >= height) {
      return false;
    }
    return tiles[y][x] == 0;
  }
}
