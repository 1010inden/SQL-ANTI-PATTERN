/*********シュードキー・ニートフリーク（疑似キー潔癖症）***********/
/*状況:レコードの欠番を気にする
*/
/*
bud_id	status	product_name
1		OPEN	Open RoundFile
2		4	　　ReConsider
4		OPEN	ReConsider
*/
/*アンチパターン:隙間を埋める*/
/*
1.欠番を割り当て
bud_id	status		product_name
1		OPEN		Open RoundFile
2		4	　　		ReConsider
4		OPEN		ReConsider
3		NEW	Visual  TurboBuilder

最も小さな欠番の値を特定するため不要な自己結合クエリが必要
SELECT b1.bug_id = 1 AS max_bug_id
FROM Bugs AS b1
LEFT OUTER JOIN Bugs AS b2 ON b1.bug_id + 1 = b2.bug_id
WHERE b2.bug_id IS NULL
ORDER BY b1.bug_id LIMIT 1;
 */

 /*
 2.既存行に番号を振り直す
 bud_id	status	product_name
1		OPEN	Open RoundFile
2		4	　　ReConsiderl
3		OPEN	ReConsider

 1.同様に欠番のキー値を特定する必要がある
 また更新で競合状態を引き起こす可能性があり、さらに欠番が多ければ何度もやらないといけない
*/
/*解決策：擬似キーの欠番は埋めない
主キーの値ルールは一意で非NULLの値ということだけなので各行の識別さえ出来ていればよい。
*/

