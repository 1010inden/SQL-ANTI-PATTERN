/*********IDリクワイアド(とりあえずID)***********/
/*状況:テーブル＝ID列を持たないといけないという幻想
全てのテーブルにID列を加えると、意図に反した影響が生じることがある
*/


/*アンチパターン:重複行を許可してしまう*/

CREATE TABLE BugsProducts (
  id SERIAL PRIMARY KEY,
  bug_id BIGINT UNSIGNED NOT NULL,
  product_id BIGINT UNSIGNED NOT NULL,
  FOREIN KEY (bug_id) REFERENCES Bugs(bug_id),
  FOREIN KEY (product_id) REFERENCES Products(product_id)
);

/*デメリット*/
/*
1.重複行を許可してしまう(bug_idとproduct_idの値の組み合わせが、テーブル上で一意でない)
Ex)INSERT INTO BugProducts(bug_id, product_id) VALUES (1234, 1), (1234, 1);
2.idが一般的用語で何を指すかわかりづらい
*/

/*アンチパターンを使用してよい例外*/
/*
主キーが物理的に長くインデックス作成が効率的でない場合は自然キーを無視して疑似キーを振ってもよい*/

/*解決策

複合主キーを定義... PRIMARY KEY (bug_id, product_id)
列名は識別する対象のエンティティを表すものにする
 */
