/*********ジェイウォーク(信号無視)***********/
/*状況:製品対アカウントで多対1→ここからアカウントが複数の連絡先を持つという業務要件が追加
=製品からアカウントに対する1対多の関連が必要
*/


/*アンチパターン:カンマ区切りフォーマットのリストを格納*/

CREATE TABLE Products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(1000),
  account_id VARCHAR(1000), -- カンマ区切りのリスト
	-- 他の列...
  FOREIN KEY (account_id) REFERENCES Accounts(account_id)
);


/*デメリット*/
/*
1.製品の検索に正規表現などが必要になる　Ex)SELECT * FROM Products WHERE account_id REGEXP '[[:<:]]12[[:>:]]';
2.インデックスのメリットが無い
3.正規表現はDB製品によって異なる
4.account_id VARCHAR(1000)によりでたらめな入力も可能(アカウントIDの妥当性検証ができない)
5.リストの長さ制限がある=VARCHAR(30)の場合カンマを含めて1エントリ3文字ならリストに格納できるのは10個のみ
*/

/*解決策

 交差テーブルを作成
 Products＆Accountsテーブルの各主キーを寄せ集めたテーブルContactsを作成し、それを検索で使用する
 Ex)SELECT * FROM Contacts WHERE account_id = 12;
 */
