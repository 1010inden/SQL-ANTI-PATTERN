/*********SQL�C���W�F�N�V����***********/
/*��:�A�v���P�[�V�����̕ϐ���p�������ISQL�����S�ɋL�q����
*/


/*�A���`�p�^�[��:�����؂̓��͂��R�[�h�Ƃ��Ď��s����*/
SELECT * FROM Bugs WHERE bug_id = '$bug_id'
--$bug_id��1234; DELETE FROM Bugs�Ȃ�e�[�u�����S�폜����Ă��܂�


/*������
���͂̃t�B���^�����O
�v���y�A�h�X�e�[�g�����g��p���ăp�����[�^��l�ł���Ɖ��߂�����
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