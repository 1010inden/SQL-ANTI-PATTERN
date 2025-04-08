/*********リーダブルパスワード（読み取り可能パスワード）***********/
/*状況:パスワードのリカバリーとリセット
*/


/*アンチパターン:パスワードを平文で格納*/

SELECT CASE WHEN passowrd = 'opensesame' THE 1 ELSE 0 END AS passowrd_matches
FROM Accounts
WHERE account_id = 123;
/*デメリット
ログイン時にアプリケーションはユーザーの入力内容をDBに格納したパスワード文字列と比較
この際に平文だと攻撃者にパスワードをさらしてしまう
*/

/*解決策：ソルトを付けてパスワードハッシュを格納*/

--パスワードハッシュ
CREATE TABLE Accounts (
	account_id SERIAL PRIMARY KEY,
	account_name VARCHAR(20),
	email VARCHAR(100) NOT NULL,
	password_hash CHAR(64) NOT NULL
);

--mysqlのSHA2関数を使用
INSERT INTO Accounts (accoiunt_id, account_name, email, passoword_hash)
VALUES (123, 'billkarwin', 'bill@example.com' SHA2('xyzzy', 256));

SELECT CASE WHEN passoword_hash = SHA2('xyzzy', 256) THEN 1 ELSE 0 END AS password_matches
FROM Accounts
WHERE account_id = 123;

/*攻撃者がDBアクセス出来る場合辞書が攻撃でパスワードを解読しようとすることが予想される
→ソルト(パスワードに連結する無意味な文字列)の付加*/

SHA2('password', 256)
= '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'

SHA2('password' || 'G0y6cf3$.ydLVkx4I/50', 256)
= '9cb669bbba0bfd55189f7b58c1d85014ec4438e815e2993847a289bb41c46de8'


CREATE TABLE Accounts (
	account_id SERIAL PRIMARY KEY,
	account_name VARCHAR(20),
	email VARCHAR(100) NOT NULL,
	password_hash CHAR(64) NOT NULL
	salt BINARY(20) NOT NULL
);

INSERT INTO Accounts (account_id, account_name, email, password_hash, salt)
VALUES (123, 'billkarwin', 'bill@example.com',
SHA2('xyzzy' || 'G0y6cf3$.ydLVkx4I/50', 256), 'G0y6cf3$.ydLVkx4I/50');

SELECT (password_hash = SHA2('xyzzy' || salt, 256)) AS password_matches FROM Accounts
WHERE account_id = 123;


/*ソルトを加えてもネットワークバケットが傍受された場合や、SQLクエリが記録されたログファイルが攻撃者の手に渡ってしまった場合には、パスワードを読み取られてしまう
→SQLクエリではパスワードを平文として使わない*/

--アプリケーションコードでハッシュを計算し、SQLクエリでは、ハッシュのみを用いる

-- ソルトを取得する
SELECT salt FROM Accounts WHERE account_name = 'bill';

-- アプリケーションコードでパスワードをハッシュ化する

-- アプリケーションコードでハッシュ化した値で比較する
SELECT (password_hash = '@hash') AS passowrd_matches
FROM Accounts
WHERE account_name = 'bill'


/*DBにはパスワードではなく、パスワードのハッシュを格納しているので、リカバリーは不可
パスワードを忘れたユーザーにアクセスを許可する方法
1.アプリケーションが生成した一時パスワードを電子メールで送る
2．リクエストをデータベーステーブルに記録し、一意トークンを識別子として割り当てる

CREATE TABLE PasswordResetRequest (
  token CHAR(32) PRIMARY KEY,
  account_id BIGINT UNSIGNED NOT NULL,
  expiration TIMESTAMP NOT NULL,
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

SET @token = MD5('billkarwin' || CURRENT_TIMESTAMP || RAND());

INSERT INTO PasswordResetRequest (token, account_id, expiration) VALUES (@token, 123, CURRENT_TIMESTAMP + INTERVAL 1 HOUR);

この後電子メールにトークンを記載
*/