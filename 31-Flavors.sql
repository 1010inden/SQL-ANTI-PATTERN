/*********�T�[�e�B�����t���[�o�[�i31�̃t���[�o�[�j***********/
/*��:��ɓo�^�ł���l�����̒l�Ɍ��肷��
*/


/*�A���`�p�^�[��:���`�Œl�����肷��*/
CREATE TABLE Bugs (
	-- ���̗�...
	status VARCHAR(20) CHECK (status IN ('NEW', 'IN PROGRESS', 'FIXED'))
);

/*�f�����b�g
1�D�X�e�[�^�X�l�̑I�������h���b�v�_�E�����X�g�ŕ\���������ꍇ�����v�����̂�
SELECT DISTINCT status FROM Bugs;
�������S�Ẵo�O��NEW�̃X�e�[�^�X�Ȃ猋�ʂ�NEW�ɂȂ��Ă��܂�

2�DCHECK�����ǉ��܂��͍폜���邽�߂̍\���͖����V�����l�Z�b�g�ōĒ�`���K�v
ALTER TABLE Bugs MODIFY COLUMN status ENUM('NEW', 'IN PROGRESS', 'FIXED', 'DUPLICATE');

3�DFIXED���폜����ꍇ���̃X�e�[�^�X�����������R�[�h�̈������킩��Ȃ��Ȃ�
*/

/*������F���肷��l���f�[�^�Ŏw��
�Q�ƃe�[�u��BugStatus���쐬���A������l��status��Ɋi�[
*/
CREATE TABLE BugStatus (
	status VARCHAR(20) PRIMARY KEY
);
INSERT INTO BugStatus (status) VALUES ('NEW'), ('IN PROGRESS'), ('FIXED');

CREATE TABLE Bugs (
	-- ���̗�...
	status VARCHAR(20),
	FOREIGN KEY (status) REFERENCES BugStatus(status) ON UPDATE CASCADE
);

/*�l�̍X�V���ȒP�ɉ\*/

INSERT INTO BugStatus (status) VALUES ('DUPLICATE');
UPDATE BugStatus SET status = 'INVALID' WHERE status = 'BOGUS';

/*�p�~���ꂽ�l�̃T�|�[�g*/
ALTER TABLE BugStatus ADD COLUMN active ENUM('INACTIVE', 'ACTIVE') NOT NULL DEFAULT 'ACTIVE';
UPDATE BugStatus SET active = 'INACTIVE' WHERE status = 'DUPLICATE';

/*���[�U�[�C���^�t�F�[�X�ɕ\������l���擾*/
SELECT status FROM BugsStatus WHERE active = 'ACTIVE';