/*********アンビギュアスグループ（曖昧なグループ）***********/
/*状況:GROUP BYを用いて最大値や平均値だけではなく、その最大値が見つかった行の他の属性も取得するクエリを実行する
*/

/*アンチパターン:非グループ化列を参照*/

--SELECT句で列挙される全ての列は、行グループごとに単一の値の行でないといけない＝単一値の原則
SELECT product_id, MAX(date_reported) AS latest
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;

--この場合product_idに対応したbug_idは複数存在＝単一値の原則に反する
SELECT product_id, MAX(date_reported) AS latest, bug_id
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;





/*解決策1．曖昧でない列を使用*/
--曖昧な列を排除
SELECT product_id, MAX(date_reported) AS latest
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;


/*解決策2. 相関サブクエリを使用*/
SELECT bp1.product_id, b1.date.reported AS latest, b1.bug_id
FROM Bugs AS b1 INNER JOIN BugsProducts AS bp1 USING (bug_id)
WHERE NOT EXISTS
(
	SELECT * FROM Bugs AS b2 INNER JOIN BugsProducts AS bp2 USING (bug_id)
	WHERE bp1.product_id = bp2.product_id 
	--date_reportedが最新でないデータを抽出し、NOT EXISTで除外
	AND b1.date_reported < b2.date_reported
);

/*解決策3. サブクエリを導出テーブルとして使用*/
SELECT m.product_id, m.latest, b1.bug_id
FROM Bugs AS b1
INNER JOIN BugsProducts AS bp1 USING (bug_id)
INNER JOIN (
	SELECT bp2.product_id, MAX(b2.date_reported) AS latest
	FROM Bugs AS b2
	INNER JOIN BugsProducts bp2 USING (bug_id)
	GROUP BY bp2.product_id
) AS m
ON bp1.product_id = m.product_id AND b1.date_reported = m.latest;


/*解決策4. OUTER JOINを使用する*/
SELECT bp1.product_id, b1.date_reported AS latest, b1.bug_id
FROM Bugs AS b1
INNER JOIN BugsProducts AS bp1
ON b1.bug_id = bp1.bug_id
LEFT OUTER JOIN (
	Bug AS b2 INNER JOIN BugsProducts AS bp2
	ON b2.bug_id = bp2.bug_id
)
ON (
	bp1.product_id = bp2.product_id
	AND (
		b1.date_reported < b2.date_reported
		OR b1.date_reported = b2.date_reported
		AND b1.bug_id < b2.bug_id
	)
)
WHERE b2.bug_id IS NULL;


/*解決策5. 他の列に対しても集約関数を使用*/
SELECT product_id, MAX(date_reported) AS latest, MAX(bug_id) AS latest_bug_id
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;

/*解決策6. グループごとに全ての値を連結*/
SELECT product_id, MAX(date_reported) AS latest, GROUP_CONCAT(bug_id) AS bug_id_list
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;



