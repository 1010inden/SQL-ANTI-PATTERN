/*********�����_���Z���N�V����***********/
/*��:�f�[�^�̃����_���T���v���݂̂�Ԃ������̗ǂ�SQL�N�G��������
*/


/*�A���`�p�^�[��:�f�[�^�������_���Ƀ\�[�g*/
--�]���̃\�[�g:������s���Ă��������ʂŃ\�[�g�ɂ͍Č���������B�C���f�b�N�X�̃����b�g��������
SELECT * FROM Bugs ORDER BY date_reported;

--�����_���Ƀ\�[�g:�\�[�g���ʂ̏��Ԃ̓\�[�g���邽�тɕς��C���f�b�N�X�̃����b�g���Ȃ�=�e�[�u���S�̂̃\�[�g
SELECT * FROM Bugs ORDER BY RAND() LIMIT 1;

/*������F����̏��ԂɈˑ����Ȃ�*/
--1.1����ő�l�܂ł̊Ԃ̂��ׂĂ̒l���g�p����Ă��邱�Ƃ��m���ȏꍇ1�����L�[�̍ő�l�܂ł̊Ԃ̒l�������_���ɑI��

SELECT b1.*
FROM Bugs AS b1
INNER JOIN (
	SELECT CEIL(RAND() * (SELECT MAC(bug_id) FROM Bugs)) AS rand_id
) AS b2 ON b1.bug_id b2.rand_id;


--2.�A�v���P�[�V�����R�[�h��p���āA���ʃZ�b�g�̎�L�[����l��1�I��
--�f�����b�g:���X�g�̃T�C�Y�������I�ɑ傫���Ȃ�\��������A2��N�G�����K�v

SELECT bug_id FROM Bugs;
-- �A�v���P�[�V�����R�[�h�Ŏ擾����`bug_id`���烉���_����`bug_id`��1�擾����

SELECT * FROM Bugs WHERE bug_id = ����;


--3.�f�[�^�̍s�����J�E���g���A0�ƍs���܂ł̊Ԃ̗�����Ԃ�
SELECT FLOOR(RAND() * (SELECT COUNT(*) FROM Bugs)) AS id_ofset;

SELECT * FROM Bugs LIMIT 1 OFFSET id_ofset;