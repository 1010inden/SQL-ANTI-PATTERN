/*********プラマンズ・サーチエンジン（貧者のサーチエンジン）***********/
/*状況:部分文字列の比較
*/


/*アンチパターン:パターンマッチ述語を使用
パターンマッチ述語ではインデックスのメリットが得られないため、フルスキャンになる
*/
SELECT * FROM Bugs WHERE description LIKE '%crash%';
SELECT * FROM Bugs WHERE descritpion REGEXP 'crash';

/*意図しないマッチが生じてしまうことも*/
SELECT * FROM Bugs WHERE description LIKE '%one%';--moneyなども一致してしまう


/*解決策：適切なツールを使用*/
--mysqlの場合MyISAMストレージエンジンのみがサポートするフルテキストインデックスが提供される
ALTER TABLE Bugs ADD FULLTEXT INDEX bugfts (summary, description);
SELECT * FROM Bugs WHERE MATCH(summary, description) AGAINST ('crash');

