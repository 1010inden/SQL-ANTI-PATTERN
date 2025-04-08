/*********SQLインジェクション***********/
/*状況:アプリケーションの変数を用いた動的SQLを安全に記述する
*/


/*アンチパターン:未検証の入力をコードとして実行する*/
SELECT * FROM Bugs WHERE bug_id = '$bug_id'
--$bug_idが1234; DELETE FROM Bugsならテーブルが全削除されてしまう


/*解決策
入力のフィルタリング
プリペアドステートメントを用いてパラメータを値であると解釈させる
*/

query := "SELECT `account_id`, `account_name`, `email` FROM `Accounts` "
placeholders := strings.Repeat("?, ", len(accountIDs))
query += fmt.Sprintf("WHERE `account_id` IN(%s) ", placeholders[:len(placeholders)-2])
query += "ORDER BY `account_id`"

args := make([]any, 0, len(accountIDs))
for _, id := range accountIDs {
	args = append(args, id)
}
rows, _ := tx.QueryContext(ctx, query, args...)
for rows.Next() {}