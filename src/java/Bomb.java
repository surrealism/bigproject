int BombNum, BlockNum; // 当前雷数,当前方块数
int rightBomb, restBomb, restBlock; // 找到的地雷数，剩余雷数，剩余方块数

JButton start = new JButton(" 开始 ");
JPanel MenuPamel = new JPanel();
JPanel bombPanel = new JPanel();
Bomb[][] bombButton;

class Bomb extends JButton {
int num_x, num_y; // 第几号方块
int BombRoundCount; // 周围雷数
boolean isBomb; // 是否为雷
boolean isClicked; // 是否被点击
int BombFlag; // 探雷标记
boolean isRight; // 是否点击右键

public Bomb(int x, int y) {
	num_x = x;
	num_y = y;
	BombFlag = 0;
	BombRoundCount = 9;
	isBomb = false;
	isClicked = false;
	isRight = false;
}
}

/* 计算方块周围雷数 */

public void CountRoundBomb() {
	for (int i = 0; i < (int) Math.sqrt(BlockNum); i++) {
		for (int j = 0; j < (int) Math.sqrt(BlockNum); j++) {
			int count = 0;
// 当需要检测的单元格本身无地雷的情况下,统计周围的地雷个数
			if (bombButton[i][j].isBomb != true) {
				for (int x = i - 1; x < i + 2; x++) {
					for (int y = j - 1; y < j + 2; y++) {
						if ( (x >= 0) && (y >= 0)
							&& (x < ( (int) Math.sqrt(BlockNum)))
							&& (y < ( (int) Math.sqrt(BlockNum)))) {
							if (bombButton[x][y].isBomb == true) {
								count++;
							}
						}
					}
				}
				bombButton[i][j].BombRoundCount = count;
			}
		}
	}
}