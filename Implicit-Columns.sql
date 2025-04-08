/*********インプリシットカラム（暗黙の列）***********/
/*状況:全ての列名を指定する
*/
SELECT bug_id, date_reported, summary, description, resolution
       reported_by, assigned_to, verified_by, status, priority, hours
FROM Bugs;

--ワイルドカードだと簡単で済む
SELECT * FROM Bugs;


/*アンチパターン:ワイルドカードや暗黙的な列の指定によって変更に対応できない*/

ALTER TABLE Bugs ADD COLUMN date_due DATE;
--暗黙的な列の指定でINSERTステートメントがエラーを返す
INSERT INTO Bugs VALUES (DEFAULT, CURRENT_DATE, '新規バグ', 'テストが失敗します', NULL, 123, NUUl, NULL, DEFAULT, 'MEDIUM', NULL);

-- SQLSTEATE 21S01; Column count doesn't match value count at row 1


/*アンチパターンを使用してよい例外
SQLを素早く書きたい場合、つまり1回しか使用しないクエリでは、保守性の低さは問題にならない
*/

/*解決策：列名を明示的に指定*/
SELECT bug_id, date_reported, summary, description, resolution
       reported_by, assigned_to, verified_by, status, priority, hours
FROM Bugs;

INSERT INTO Accounts (account_name, first_name, last_name, email, passowrd_hash, portrait_image, hourly_rate) VALUES ('bkarwin', 'Bill', 'Karwin', 'bill@example.com', SHA2('xyzzy', 256), NULL, 49.95);