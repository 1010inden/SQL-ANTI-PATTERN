/*********�V���[�h�L�[�E�j�[�g�t���[�N�i�^���L�[���ȏǁj***********/
/*��:���R�[�h�̌��Ԃ��C�ɂ���
*/
/*
bud_id	status	product_name
1		OPEN	Open RoundFile
2		4	�@�@ReConsider
4		OPEN	ReConsider

*/

/*�A���`�p�^�[��:���Ԃ𖄂߂�*/
/*
1.���Ԃ����蓖��
bud_id	status		product_name
1		OPEN		Open RoundFile
2		4	�@�@		ReConsider
4		OPEN		ReConsider
3		NEW	Visual  TurboBuilder

�ł������Ȍ��Ԃ̒l����肷�邽�ߕs�v�Ȏ��Ȍ����N�G�����K�v
SELECT b1.bug_id = 1 AS max_bug_id
FROM Bugs AS b1
LEFT OUTER JOIN Bugs AS b2 ON b1.bug_id + 1 = b2.bug_id
WHERE b2.bug_id IS NULL
ORDER BY b1.bug_id LIMIT 1;
 */

 /*
 2.�����s�ɔԍ���U�蒼��
 bud_id	status	product_name
1		OPEN	Open RoundFile
2		4	�@�@ReConsiderl
3		OPEN	ReConsider

 1.���l�Ɍ��Ԃ̃L�[�l����肷��K�v������
 �܂��X�V�ŋ�����Ԃ������N�����\��������A����Ɍ��Ԃ�������Ή��x�����Ȃ��Ƃ����Ȃ�
*/



/*������F�[���L�[�̌��Ԃ͖��߂Ȃ�
��L�[�̒l���[���͈�ӂŔ�NULL�̒l�Ƃ������Ƃ����Ȃ̂Ŋe�s�̎��ʂ����o���Ă���΂悢�B

*/

