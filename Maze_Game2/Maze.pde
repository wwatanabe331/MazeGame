// Mazeクラス: 迷路の生成と管理を行う
class Maze {
  int[][] tiles;  // 迷路の構造を表す2次元配列。0が通路、1が壁
  int width, height;  // 迷路の幅と高さ

  // コンストラクタ: 迷路のサイズを設定し、生成する
  Maze(int w, int h) {
    width = w;
    height = h;
    tiles = new int[height][width];  // tilesを初期化
    generateMaze();  // 迷路を生成
  }

  // 迷路を生成するメソッド
  void generateMaze() {
    
    // 全てのマスを壁(1)で埋める
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        tiles[y][x] = 1;
      }
    }
    
    // 深さ優先探索で迷路を生成
    dfs(1, 1);

    // ランダムに追加の道を作成
    // 複雑にする
    for (int i = 0; i < width * height / 10; i++) {
      int x = int(random(1, width - 1));
      int y = int(random(1, height - 1));
      tiles[y][x] = 0;
    }

  }

  // 深さ優先探索で迷路を生成するメソッド
  void dfs(int x, int y) {
    // 上下左右の2マス先の座標変化量
    int[][] directions = {{0, -2}, {2, 0}, {0, 2}, {-2, 0}};
    // 方向をランダムに並べ替え
    shuffleArray(directions);

    // 各方向に対して処理を行う
    for (int i = 0; i < directions.length; i++) {
      int[] d = directions[i];
      int nx = x + d[0];  // 2マス先のx座標
      int ny = y + d[1];  // 2マス先のy座標
      
      // 2マス先が迷路内かつ壁(1)なら
      if (nx > 0 && ny > 0 &&
      nx < width - 1 && ny < height - 1 && tiles[ny][nx] == 1) {
        
        // 間のマスを通路にする
        tiles[y + d[1]/2][x + d[0]/2] = 0;
        // 2マス先を通路にする
        tiles[ny][nx] = 0;
        // 2マス先から再帰的にdfsを呼び出す
        dfs(nx, ny);
      }
    }
  }

  // 配列をランダムに並べ替えるメソッド
  void shuffleArray(int[][] array) {
    for (int i = array.length - 1; i > 0; i--) {
      int index = int(random(i + 1));
      int[] temp = array[index];
      array[index] = array[i];
      array[i] = temp;
    }
  }

  // 指定された座標が歩行可能かどうかを判定するメソッド
  boolean isWalkable(int x, int y) {
    // 迷路の範囲外ならfalse
    if (x < 0 || y < 0 || x >= width || y >= height) {
      return false;
    }
    // 壁(1)ならfalse、通路(0)ならtrue
    return tiles[y][x] == 0;
  }
}
