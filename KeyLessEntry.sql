/*********�L�[���X�G���g���i�O���L�[�����j***********/
/*�󋵁��A���`�p�^�[��:
�O���L�[������ȗ�����΁ADB�݌v�̓V���v���ŏ_������܂�A���s���x�������Ȃ�Ƃ�������������Ă���
*/


/*�f�����b�g*/
/*
1.�O���L�[�����ݒ肵�Ȃ��ꍇ�A�Q�Ɛ����������Ȃ��Ȃ����Ƃ��m�F����K�v������
Ex)�A�J�E���g�����݂��鎖���m�F���A���̃A�J�E���g���Q�Ƃ��郌�R�[�h��ǉ�
	SELECT account_id FROM Accounts WHERE account_id = 1; �e�e�[�u��
	INSERT INTO Bugs (account_id) VALUES (1);�@�@�q�e�[�u��
�m�F�N�G���̒���ɃA�J�E���g���������ꍇ���݂��Ȃ��A�J�E���g�ɂ��񍐂��ꂽ�o�O�Ƃ������肦�Ȃ����R�[�h��
�ǉ�����邱�ƂɂȂ��Ă��܂�
*/


/*������
�O���L�[�����錾

CREATE TABLE Bugs (
	-- ���̗�...
  account_id BIGINT UNSIGNED NOT NULL,
  FOREIN KEY (account_id) REFERENCES Accounts(account_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT
);
�܂��J�X�P�[�h�X�V�Ƃ����A�A�v���P�[�V�����R�[�h�ɂ͐^���ł��Ȃ��@�\���g�p�\
*/
