/*********ランダムセレクション***********/
/*状況:データのランダムサンプルのみを返す効率の良いSQLクエリを書く
*/


/*アンチパターン:データをランダムにソート*/
--従来のソート:複数回行っても同じ結果でソートには再現性がある。インデックスのメリットも得られる
SELECT * FROM Bugs ORDER BY date_reported;

--ランダムにソート:ソート結果の順番はソートするたびに変わりインデックスのメリットがない=テーブル全体のソート
SELECT * FROM Bugs ORDER BY RAND() LIMIT 1;

/*解決策：特定の順番に依存しない*/
--1.1から最大値までの間のすべての値が使用されていることが確実な場合1から主キーの最大値までの間の値をランダムに選択

SELECT b1.*
FROM Bugs AS b1
INNER JOIN (
	SELECT CEIL(RAND() * (SELECT MAC(bug_id) FROM Bugs)) AS rand_id
) AS b2 ON b1.bug_id b2.rand_id;


--2.アプリケーションコードを用いて、結果セットの主キーから値を1つ選択
--デメリット:リストのサイズが将来的に大きくなる可能性がある、2回クエリが必要

SELECT bug_id FROM Bugs;
-- アプリケーションコードで取得した`bug_id`からランダムな`bug_id`を1つ取得する

SELECT * FROM Bugs WHERE bug_id = 乱数;


--3.データの行数をカウントし、0と行数までの間の乱数を返す
SELECT FLOOR(RAND() * (SELECT COUNT(*) FROM Bugs)) AS id_ofset;

SELECT * FROM Bugs LIMIT 1 OFFSET id_ofset;