/*********サーティワンフレーバー（31のフレーバー）***********/
/*状況:列に登録できる値を特定の値に限定する
*/


/*アンチパターン:列定義で値を限定する*/
CREATE TABLE Bugs (
	-- 他の列...
	status VARCHAR(20) CHECK (status IN ('NEW', 'IN PROGRESS', 'FIXED'))
);

/*デメリット
1．ステータス値の選択肢をドロップダウンリストで表示したい場合すぐ思いつくのは
SELECT DISTINCT status FROM Bugs;
しかし全てのバグがNEWのステータスなら結果はNEWになってしまう

2．CHECK制約を追加または削除するための構文は無く新しい値セットで再定義が必要
ALTER TABLE Bugs MODIFY COLUMN status ENUM('NEW', 'IN PROGRESS', 'FIXED', 'DUPLICATE');

3．FIXEDを削除する場合そのステータスを持つ既存レコードの扱いがわからなくなる
*/

/*解決策：限定する値をデータで指定
参照テーブルBugStatusを作成し、許可する値をstatus列に格納
*/
CREATE TABLE BugStatus (
	status VARCHAR(20) PRIMARY KEY
);
INSERT INTO BugStatus (status) VALUES ('NEW'), ('IN PROGRESS'), ('FIXED');

CREATE TABLE Bugs (
	-- 他の列...
	status VARCHAR(20),
	FOREIGN KEY (status) REFERENCES BugStatus(status) ON UPDATE CASCADE
);

/*値の更新が簡単に可能*/

INSERT INTO BugStatus (status) VALUES ('DUPLICATE');
UPDATE BugStatus SET status = 'INVALID' WHERE status = 'BOGUS';

/*廃止された値のサポート*/
ALTER TABLE BugStatus ADD COLUMN active ENUM('INACTIVE', 'ACTIVE') NOT NULL DEFAULT 'ACTIVE';
UPDATE BugStatus SET active = 'INACTIVE' WHERE status = 'DUPLICATE';

/*ユーザーインタフェースに表示する値を取得*/
SELECT status FROM BugsStatus WHERE active = 'ACTIVE';