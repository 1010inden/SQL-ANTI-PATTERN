/*********スパゲッティクエリ***********/
/*状況:目の前の仕事を1つのクエリで実現する
*/

/*アンチパターン:ワンステップで解決しようとする*/
/*デメリット*/
/*
複数タスクを実現する中で意図しないデカルト積が発生
(結合するテーブルが関連を制限する条件を持たないとき片方が全ての行が結合されてしまう)
*/
SELECT p.product_id, COUNT(f.bug_id) AS count_fixed, COUNT(o.bug_id) AS count_open
FROM BugsProdcuts AS p
INNER JOIN Bugs AS f ON p.bug_id = f.bug_id AND f.status = 'FIXED'
INNER JOIN BugsProducts AS p2 USING (product_id)
INNER JOIN Bugs AS o ON p2.bug_id = o.bug_id AND o.status = 'OPEN'
WHERE p.product_id = 1
GROUP BY p.product_id;
/*
product_id:1 count_fixed:77　本来11  count_open:77     本来7
f,o間で結合がないので11行の修正済みバグ*7行の未修正バグ＝77となってしまう
*/

/*解決策：分割統治*/
--処理を分ける
SELECT p.product_id, COUNT(f.bug_id) AS count_fixed
FROM BugsProdcuts AS p
LEFT OUTER JOIN Bugs AS f ON p.bug_id = f.bug_id AND f.status = 'FIXED'
WHERE p.product_id = 1;
GROUP BY p.product_id;

SELECT p.product_id, COUNT(o.bug_id) AS count_open
FROM BugsProdcuts AS p
LEFT OUTER JOIN Bugs AS o ON p2.bug_id = o.bug_id AND o.status = 'OPEN'
WHERE p.product_id = 1;
GROUP BY p.product_id;

--unionを使用
(
	SELECT p.product_id, COUNT(f.bug_id) AS bug_count
	FROM BugsProdcuts AS p
	LEFT OUTER JOIN Bugs AS f ON p.bug_id = f.bug_id AND f.status = 'FIXED'
	WHERE p.product_id = 1;
	GROUP BY p.product_id;
)
UNION ALL
(
	SELECT p.product_id, COUNT(o.bug_id) AS bug_count
	FROM BugsProdcuts AS p
	LEFT OUTER JOIN Bugs AS o ON p2.bug_id = o.bug_id AND o.status = 'OPEN'
	WHERE p.product_id = 1;
	GROUP BY p.product_id;
)
ORDER BY bug_count DESC;
