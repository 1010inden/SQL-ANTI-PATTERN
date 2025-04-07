/*********ポリモーフィック関連***********/
/*状況:複数の親テーブルを参照したい
BugsテーブルとFeatureRequestsテーブル両方を参照するCommentsテーブルなど
*/


/*アンチパターン:二重目的の外部キーを使用*/

CREATE TABLE Comments (
	comment_id SERIAL PRIMARY KEY,
	issue_type VARCHAR(20), -- 'Bugs'または'FeatureRequests'が格納される
	issue_id BIGINT UNSIGNED NOT NULL,
	author BIGINT UNSIGNED NOT NULL,
	comment_date DATETIME,
	comment TEXT,
	FOREIGN KEY (author) REFERENCES Accounts(account_id),
);
/*外部キーでは、テーブルを1つのみ指定しなければならない（複数のテーブルを指定できない）ので
issue_idのための外部キー宣言が出来ない
ポリモーフィック関連を定義すると参照整合性制約を定義できない
またポリモーフィック関連は、親テーブル同時に全く関係がない場合にも使用される
Ex:顧客（Users）と注文（Orders）の2つのテーブルに関連する住所（Addresses）テーブルの住所属性など
*/





/*解決策*/
/*
1.複数の親テーブルそれぞれに交差テーブルを作成、
各テーブルでは、Commentsへの外部キーに加えて、各親テーブルへも同じく外部キーを定義
*/

CREATE TABLE BugsComments (
	issue_id BIGINT UNSIGNED NOT NULL,
	comment_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (issue_id, comment_id),
	FOREIGN KEY (issue_id) REFERENCES Bugs(issue_id),
	FOREIGN KEY (comment_id) REFERENCES Comments(comment_id)
);

CREATE TABLE FeaturesComments (
	issue_id BIGINT UNSIGNED NOT NULL,
	comment_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (issue_id, comment_id),
	FOREIGN KEY (issue_id) REFERENCES FeatureRequests(issue_id),
	FOREIGN KEY (comment_id) REFERENCES Comments(comment_id)
);

/*テーブル間のリレーションシップには、参照元テーブルと参照先テーブルが常にそれぞれ1つしかないことを意識しておく*/