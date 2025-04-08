/*********���[�_�u���p�X���[�h�i�ǂݎ��\�p�X���[�h�j***********/
/*��:�p�X���[�h�̃��J�o���[�ƃ��Z�b�g
*/


/*�A���`�p�^�[��:�p�X���[�h�𕽕��Ŋi�[*/

SELECT CASE WHEN passowrd = 'opensesame' THE 1 ELSE 0 END AS passowrd_matches
FROM Accounts
WHERE account_id = 123;
/*�f�����b�g
���O�C�����ɃA�v���P�[�V�����̓��[�U�[�̓��͓��e��DB�Ɋi�[�����p�X���[�h������Ɣ�r
���̍ۂɕ������ƍU���҂Ƀp�X���[�h�����炵�Ă��܂�
*/

/*������F�\���g��t���ăp�X���[�h�n�b�V�����i�[*/

--�p�X���[�h�n�b�V��
CREATE TABLE Accounts (
	account_id SERIAL PRIMARY KEY,
	account_name VARCHAR(20),
	email VARCHAR(100) NOT NULL,
	password_hash CHAR(64) NOT NULL
);

--mysql��SHA2�֐����g�p
INSERT INTO Accounts (accoiunt_id, account_name, email, passoword_hash)
VALUES (123, 'billkarwin', 'bill@example.com' SHA2('xyzzy', 256));

SELECT CASE WHEN passoword_hash = SHA2('xyzzy', 256) THEN 1 ELSE 0 END AS password_matches
FROM Accounts
WHERE account_id = 123;

/*�U���҂�DB�A�N�Z�X�o����ꍇ�������U���Ńp�X���[�h����ǂ��悤�Ƃ��邱�Ƃ��\�z�����
���\���g(�p�X���[�h�ɘA�����閳�Ӗ��ȕ�����)�̕t��*/

SHA2('password', 256)
= '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'

SHA2('password' || 'G0y6cf3$.ydLVkx4I/50', 256)
= '9cb669bbba0bfd55189f7b58c1d85014ec4438e815e2993847a289bb41c46de8'


CREATE TABLE Accounts (
	account_id SERIAL PRIMARY KEY,
	account_name VARCHAR(20),
	email VARCHAR(100) NOT NULL,
	password_hash CHAR(64) NOT NULL
	salt BINARY(20) NOT NULL
);

INSERT INTO Accounts (account_id, account_name, email, password_hash, salt)
VALUES (123, 'billkarwin', 'bill@example.com',
SHA2('xyzzy' || 'G0y6cf3$.ydLVkx4I/50', 256), 'G0y6cf3$.ydLVkx4I/50');

SELECT (password_hash = SHA2('xyzzy' || salt, 256)) AS password_matches FROM Accounts
WHERE account_id = 123;


/*�\���g�������Ă��l�b�g���[�N�o�P�b�g���T�󂳂ꂽ�ꍇ��ASQL�N�G�����L�^���ꂽ���O�t�@�C�����U���҂̎�ɓn���Ă��܂����ꍇ�ɂ́A�p�X���[�h��ǂݎ���Ă��܂�
��SQL�N�G���ł̓p�X���[�h�𕽕��Ƃ��Ďg��Ȃ�*/

--�A�v���P�[�V�����R�[�h�Ńn�b�V�����v�Z���ASQL�N�G���ł́A�n�b�V���݂̂�p����

-- �\���g���擾����
SELECT salt FROM Accounts WHERE account_name = 'bill';

-- �A�v���P�[�V�����R�[�h�Ńp�X���[�h���n�b�V��������

-- �A�v���P�[�V�����R�[�h�Ńn�b�V���������l�Ŕ�r����
SELECT (password_hash = '@hash') AS passowrd_matches
FROM Accounts
WHERE account_name = 'bill'


/*DB�ɂ̓p�X���[�h�ł͂Ȃ��A�p�X���[�h�̃n�b�V�����i�[���Ă���̂ŁA���J�o���[�͕s��
�p�X���[�h��Y�ꂽ���[�U�[�ɃA�N�Z�X����������@
1.�A�v���P�[�V���������������ꎞ�p�X���[�h��d�q���[���ő���
2�D���N�G�X�g���f�[�^�x�[�X�e�[�u���ɋL�^���A��Ӄg�[�N�������ʎq�Ƃ��Ċ��蓖�Ă�

CREATE TABLE PasswordResetRequest (
  token CHAR(32) PRIMARY KEY,
  account_id BIGINT UNSIGNED NOT NULL,
  expiration TIMESTAMP NOT NULL,
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

SET @token = MD5('billkarwin' || CURRENT_TIMESTAMP || RAND());

INSERT INTO PasswordResetRequest (token, account_id, expiration) VALUES (@token, 123, CURRENT_TIMESTAMP + INTERVAL 1 HOUR);

���̌�d�q���[���Ƀg�[�N�����L��
*/