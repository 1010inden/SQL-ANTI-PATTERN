/*********�C���v���V�b�g�J�����i�Öق̗�j***********/
/*��:�S�Ă̗񖼂��w�肷��
*/
SELECT bug_id, date_reported, summary, description, resolution
       reported_by, assigned_to, verified_by, status, priority, hours
FROM Bugs;

--���C���h�J�[�h���ƊȒP�ōς�
SELECT * FROM Bugs;


/*�A���`�p�^�[��:���C���h�J�[�h��ÖٓI�ȗ�̎w��ɂ���ĕύX�ɑΉ��ł��Ȃ�*/

ALTER TABLE Bugs ADD COLUMN date_due DATE;
--�ÖٓI�ȗ�̎w���INSERT�X�e�[�g�����g���G���[��Ԃ�
INSERT INTO Bugs VALUES (DEFAULT, CURRENT_DATE, '�V�K�o�O', '�e�X�g�����s���܂�', NULL, 123, NUUl, NULL, DEFAULT, 'MEDIUM', NULL);

-- SQLSTEATE 21S01; Column count doesn't match value count at row 1


/*�A���`�p�^�[�����g�p���Ă悢��O
SQL��f�������������ꍇ�A�܂�1�񂵂��g�p���Ȃ��N�G���ł́A�ێ琫�̒Ⴓ�͖��ɂȂ�Ȃ�
*/

/*������F�񖼂𖾎��I�Ɏw��*/
SELECT bug_id, date_reported, summary, description, resolution
       reported_by, assigned_to, verified_by, status, priority, hours
FROM Bugs;

INSERT INTO Accounts (account_name, first_name, last_name, email, passowrd_hash, portrait_image, hourly_rate) VALUES ('bkarwin', 'Bill', 'Karwin', 'bill@example.com', SHA2('xyzzy', 256), NULL, 49.95);