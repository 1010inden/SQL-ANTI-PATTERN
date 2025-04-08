/*********フェア・オブ・ジ・アンノウン（恐怖のunknown）***********/
/*状況:NULL列を含む列に対してクエリを書く
*/


/*アンチパターン:NULLを一般値として使う

ULLを用いた比較は、TRUEやFALSEではなく、全て不明（unknown）を返す
SELECT * FROM Bugs WHERE assigned_to = NULL;
SELECT * FROM Bugs WHERE assigned_to <> NULL;

プリペアドステートメントでパラメータ化したSQLでNULLを一般値のように扱うこともできない
一般的な整数値のみで予期する結果を返す
SELECT * FROM Bugs WHERE assigned_to = ?;
*/

/*アンチパターン:NULLの代わりに不明を意味する値を新たに定義

NOT NULL制約が動作しない
-1という負の値を定義したならz合、SUMやAVGのような計算を混乱させる
*/


/*解決策：
1.NULLを一意な値として使う
SELECT * FROM Bugs WHERE assigned_to IS NULL;
SELECT * FROM Bugs WHERE assigned_to IS NOT NULL;

2.列においてNULLが意味をなさないならそもそもNOT NULL制約を宣言する
*/
