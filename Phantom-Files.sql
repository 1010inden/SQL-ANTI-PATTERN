/*********ファントムファイル（幻のファイル）***********/
/*状況:大容量のメディアファイルを格納したい。
*/


/*アンチパターン:物理ファイルの使用を必須と捉えてしまう*/
CREATE TABLE Accounts (
	account_id SERIAL PRIMARY KEY,
	account_name VARCHAR(20),
	portraite_image BLOB
);

CREATE TABLE Screenshots (
	bug_id BIGINT UNSIGNED NOT NULL,
	image_id BIGINT UNSIGNED NOT NULL,
	screenshot_image BLOB,
	caption VARCHAR(100),
	PRIMARY KEY (bug_id, image_id),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

/*画像のデータ型選択は意見が分かれ、ファイルパスをVARCHARとしてデータベースに格納する人も*/
CREATE TABLE Screenshots (
	bug_id BIGINT UNSIGNED NOT NULL,
	image_id BIGINT UNSIGNED NOT NULL,
	screenshot_path VARCHAR(100),
	caption VARCHAR(100),
	PRIMARY KEY (bug_id, image_id),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);


/*外部にファイルを格納するという設計のデメリット
1．画像へのパスを含む行を削除しても、そのパスの指定先のファイルは自動的に削除されない
2．VARCHAR列に格納されたパス名が参照するファイルをバックアップ対象にする方法が不明
3．外部ファイルにはGRANTやREVOKEなどのsqlステートメントで割り当てるアクセス権限が適用されない
アクセス権限はテーブルや列へのアクセスを管理するが、画像が管理外になってしまう
4．パス名が正当なパスであることを検証できない
つまりデータベース外部のリソースは、データベースでは管理できない
*/



/*アンチパターンを使用してよい例外
DBの容量を減らしたい
バックアップを短時間で済ませたい
全ての画像を一括で修正したい
*/

 /*解決策：必要に応じてBLOB型を採用
 BLOBの最大サイズはDBで異なるがほとんどの画像を格納可能
*/
 CREATE TABLE Screenshots (
	bug_id BIGINT UNSIGNED NOT NULL,
	image_id BIGINT UNSIGNED NOT NULL,
	screenshot_image BLOB,
	caption VARCHAR(100),
	PRIMARY KEY (bug_id, image_id),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

/*データベースにはBLOB列に読み込むための方法が必要
DBの中には外部ファイルをロードする関数が提供されている
*/
UPDATE Screenshots
SET screenshot_image = LOAD_FILE('image/screenshot1234-1.jpg')
WHERE bug_id = 1234 AND image_id = 1;


