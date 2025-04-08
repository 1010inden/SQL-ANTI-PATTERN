/*********�C���f�b�N�X�V���b�g�K���i�ŉ_�C���f�b�N�X�j***********/

/*�A���`�p�^�[��:�ŉ_�ɃC���f�b�N�X���g�p

�C���f�b�N�X�̍X�V��DB�ɃI�[�o�[�w�b�h�������邽�߁A�ꕔ�̊J���҂́A�C���f�b�N�X��r�����悤�Ƃ���
��ʂɃe�[�u���ɑ΂���N�G�����s�񐔂̕����A�e�[�u���̍X�V�񐔂����������ߖړI�̍s��f������������Ȃ�
�����b�g�����󂵂₷��
*/
CREATE TABLE Bugs (
	bug_id SERIAL PRIMARY KEY,
	date_reported DATE NOT NULL,
	summary VARCHAR(80) NOT NULL,
	status VARCHAR(10) NOT NULL,
	hours NUMERIC(9,2),
	INDEX (bug_id) ---1
	INDEX (summary) ---2
	INDEX (hours) ---3
	INDEX (bug_id, date_reported, status) ---4
);
/*
1.��L�[�̃C���f�b�N�X�������I�ɍ쐬�����̂ŏ璷
2�DVARCHAR(80)�Ȃǒ��������񂾂ƃC���f�b�N�X�̃T�C�Y���c���
3.hours��ɑ΂��Č�����A�\�[�g�����s���邱�Ƃ͂Ȃ�����
4�D�����C���f�b�N�X�̑����͏璷�Ŏg�p�p�x�����Ȃ��Ȃ�₷��
�܂���̏������d�v�Ō����A�����A���������A�\�[�g���ɂ����āA����`�������Ɏg�p����K�v����
*/

/*������uMENTOR�v�̌����Ɋ�Â��ĊǗ�
Measure�i����j�ł������̎��Ԃ������N�G�������
Explain�i��́j�N�G���̏������x���Ȃ��Ă��錴�������
Nominate�i�w���j�N�G�����C���f�b�N�X���g�p���Ȃ��Ńe�[�u���ɃA�N�Z�X���Ă���ӏ���T��
Test�i�e�X�g�j���ʂ̊m�F
Optimize�i�œK���j�C���f�b�N�X�̓R���p�N�g�ŃL���b�V���������Ɋi�[����₷���Ȃ�
�@�@�@�@�@�@�@�@�@�@LOAD INDEX INTO CACHE�X�e�[�g�����g�Ŗ����I�ɐݒ���o����
Rebuild�i�č\�z�j�@�s�̍X�V��폜�ŁA�C���f�b�N�X�͕s�ϓ��ɂȂ�̂Ń����e����
*/
