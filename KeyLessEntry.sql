/*********キーレスエントリ（外部キー嫌い）***********/
/*状況＆アンチパターン:
外部キー制約を省略すれば、DB設計はシンプルで柔軟性が高まり、実行速度が速くなるという誤解を持っている
*/


/*デメリット*/
/*
1.外部キー制約を設定しない場合、参照整合性が損なわれないことを確認する必要がある
Ex)アカウントが存在する事を確認し、そのアカウントを参照するレコードを追加
	SELECT account_id FROM Accounts WHERE account_id = 1; 親テーブル
	INSERT INTO Bugs (account_id) VALUES (1);　　子テーブル
確認クエリの直後にアカウントを消した場合存在しないアカウントにより報告されたバグというありえないレコードが
追加されることになってしまう
*/


/*解決策
外部キー制約を宣言

CREATE TABLE Bugs (
	-- 他の列...
  account_id BIGINT UNSIGNED NOT NULL,
  FOREIN KEY (account_id) REFERENCES Accounts(account_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT
);
またカスケード更新という、アプリケーションコードには真似できない機能も使用可能
*/
