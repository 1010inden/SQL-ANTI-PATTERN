/*********�t�@���g���t�@�C���i���̃t�@�C���j***********/
/*��:��e�ʂ̃��f�B�A�t�@�C�����i�[�������B
*/


/*�A���`�p�^�[��:�����t�@�C���̎g�p��K�{�Ƒ����Ă��܂�*/
CREATE TABLE Accounts (
	account_id SERIAL PRIMARY KEY,
	account_name VARCHAR(20),
	portraite_image BLOB
);

CREATE TABLE Screenshots (
	bug_id BIGINT UNSIGNED NOT NULL,
	image_id BIGINT UNSIGNED NOT NULL,
	screenshot_image BLOB,
	caption VARCHAR(100),
	PRIMARY KEY (bug_id, image_id),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

/*�摜�̃f�[�^�^�I���͈ӌ���������A�t�@�C���p�X��VARCHAR�Ƃ��ăf�[�^�x�[�X�Ɋi�[����l��*/
CREATE TABLE Screenshots (
	bug_id BIGINT UNSIGNED NOT NULL,
	image_id BIGINT UNSIGNED NOT NULL,
	screenshot_path VARCHAR(100),
	caption VARCHAR(100),
	PRIMARY KEY (bug_id, image_id),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);


/*�O���Ƀt�@�C�����i�[����Ƃ����݌v�̃f�����b�g
1�D�摜�ւ̃p�X���܂ލs���폜���Ă��A���̃p�X�̎w���̃t�@�C���͎����I�ɍ폜����Ȃ�
2�DVARCHAR��Ɋi�[���ꂽ�p�X�����Q�Ƃ���t�@�C�����o�b�N�A�b�v�Ώۂɂ�����@���s��
3�D�O���t�@�C���ɂ�GRANT��REVOKE�Ȃǂ�sql�X�e�[�g�����g�Ŋ��蓖�Ă�A�N�Z�X�������K�p����Ȃ�
�A�N�Z�X�����̓e�[�u�����ւ̃A�N�Z�X���Ǘ����邪�A�摜���Ǘ��O�ɂȂ��Ă��܂�
4�D�p�X���������ȃp�X�ł��邱�Ƃ����؂ł��Ȃ�
�܂�f�[�^�x�[�X�O���̃��\�[�X�́A�f�[�^�x�[�X�ł͊Ǘ��ł��Ȃ�
*/



/*�A���`�p�^�[�����g�p���Ă悢��O
DB�̗e�ʂ����炵����
�o�b�N�A�b�v��Z���Ԃōς܂�����
�S�Ẳ摜���ꊇ�ŏC��������
*/

 /*������F�K�v�ɉ�����BLOB�^���̗p
 BLOB�̍ő�T�C�Y��DB�ňقȂ邪�قƂ�ǂ̉摜���i�[�\
*/
 CREATE TABLE Screenshots (
	bug_id BIGINT UNSIGNED NOT NULL,
	image_id BIGINT UNSIGNED NOT NULL,
	screenshot_image BLOB,
	caption VARCHAR(100),
	PRIMARY KEY (bug_id, image_id),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

/*�f�[�^�x�[�X�ɂ�BLOB��ɓǂݍ��ނ��߂̕��@���K�v
DB�̒��ɂ͊O���t�@�C�������[�h����֐����񋟂���Ă���
*/
UPDATE Screenshots
SET screenshot_image = LOAD_FILE('image/screenshot1234-1.jpg')
WHERE bug_id = 1234 AND image_id = 1;


