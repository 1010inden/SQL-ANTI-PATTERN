/*********�t�F�A�E�I�u�E�W�E�A���m�E���i���|��unknown�j***********/
/*��:NULL����܂ޗ�ɑ΂��ăN�G��������
*/


/*�A���`�p�^�[��:NULL����ʒl�Ƃ��Ďg��

ULL��p������r�́ATRUE��FALSE�ł͂Ȃ��A�S�ĕs���iunknown�j��Ԃ�
SELECT * FROM Bugs WHERE assigned_to = NULL;
SELECT * FROM Bugs WHERE assigned_to <> NULL;

�v���y�A�h�X�e�[�g�����g�Ńp�����[�^������SQL��NULL����ʒl�̂悤�Ɉ������Ƃ��ł��Ȃ�
��ʓI�Ȑ����l�݂̂ŗ\�����錋�ʂ�Ԃ�
SELECT * FROM Bugs WHERE assigned_to = ?;
*/

/*�A���`�p�^�[��:NULL�̑���ɕs�����Ӗ�����l��V���ɒ�`

NOT NULL���񂪓��삵�Ȃ�
-1�Ƃ������̒l���`�����Ȃ�z���ASUM��AVG�̂悤�Ȍv�Z������������
*/


/*������F
1.NULL����ӂȒl�Ƃ��Ďg��
SELECT * FROM Bugs WHERE assigned_to IS NULL;
SELECT * FROM Bugs WHERE assigned_to IS NOT NULL;

2.��ɂ�����NULL���Ӗ����Ȃ��Ȃ��Ȃ炻������NOT NULL�����錾����
*/
