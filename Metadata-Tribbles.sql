/*********���^�f�[�^�g���u���i���^�f�[�^�呝�B�j***********/
/*��:�N�G���̎��s���x��򉻂������ɁA�f�[�^��������������e�[�u����z�肵��DB�\����݌v������
*/


/*�A���`�p�^�[��:
��ʂ��₷���f�[�^�l����ɁA�s���̑����e�[�u���𕡐��̃e�[�u���ɕ���
��ʂ��₷���f�[�^�l����ɁA��𕡐���ɕ���*/
CREATE TABLE Bugs_202310(...);
CREATE TABLE Bugs_202311(...);
CREATE TABLE Bugs_202312(...);


/*������*/
/*1�D�����p�[�e�B�V���j���O
�e�[�u���͕����I�ɂ͕�������Ă��邪1�̃e�[�u���������悤�ɁASQ�����s�\
*/
CREATE TABLE Bugs (
	bug_id SERIAL PRIMARY KEY,
	-- ���̗�E�E�E
	date_reported DATE
) 
PARTITION BY HASH ( YEAR(date_reported) )
PARTITIONs 4;

/*1�D�����p�[�e�B�V���j���O
��Ńe�[�u������
���1���̃T�C�Y���傫���ꍇ��A�߂����Ɏg�p����Ȃ��ꍇ�ɗL��
*/
