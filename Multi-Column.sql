/*********マルチカラムアトリビュート（複数列属性）***********/
/*状況:1つのテーブルに属するべきだと思える属性に複数の値がある場合どのように格納するか
*/


/*アンチパターン:複数の列を定義*/
CREATE TABLE Bugs (
	bug_id SERIAL PRIMARY KEY,
	description VARCHAR(1000),
	tag1 VARCHAR(20),
	tag2 VARCHAR(20),
	tag3 VARCHAR(20)
);

/*image
bug_id	description	tag1	tag2	tag3
1234	保存処理でクラッシュする	crash	NULL	NULL
3456	パフォーマンスの向上	printing	performance	NULL
5678	XMLのサポート	NULL	NULL	NULL
*/


/*デメリット
1.特定のタグを検索しようとすると、3列全てを取得する必要があり、クエリが複雑

SELECT * FROM Bugs
WHERE tag1 = 'performance'
OR tag2 = 'performance'
OR tag3 = 'performance';

performance とprintingの両方のタグを付いたバグの場合
SELECT * FROM Bugs
WHERE (tag1 = 'performance' OR tag2 = 'performance' OR tag3 = 'performance')
AND (tag1 = 'printing' OR tag2 = 'printing' OR tag3 = 'printing');


2.1列のみを対象としたUPDATEの際にどの列が空いているかわからない、確認クエリが必要
3．複数列に同じ値が入らない一意性が保証できない
4．列数が将来的に3列で足りない状況が来る
*/


/*解決策：従属テーブルを作成
*/
CREATE TABLE Tags (
	bug_id BIGINT UNSIGNED NOT NULL,
	tag VARCHAR(20),
	PRIMARY KEY (bug_id, tag),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

INSERT INTO Tags (bug_id, tag) VALUES (1234, 'crash'), (3456, 'printing'), (3456, 'performance');

--検索クエリが簡単
SELECT * FROM Bugs INNER JOIN Tags USING (bug_id) WHERE tag = 'performance';
SELECT * FROM Bugs
INNER JOIN Tags AS t1 USING (bug_id)
INNER JOIN Tags AS t2 USING (bug_id)
WHERE t1.tag = 'printing' AND t2.tag = 'performance';