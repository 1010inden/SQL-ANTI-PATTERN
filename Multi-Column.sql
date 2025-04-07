/*********�}���`�J�����A�g���r���[�g�i�����񑮐��j***********/
/*��:1�̃e�[�u���ɑ�����ׂ����Ǝv���鑮���ɕ����̒l������ꍇ�ǂ̂悤�Ɋi�[���邩
*/


/*�A���`�p�^�[��:�����̗���`*/
CREATE TABLE Bugs (
	bug_id SERIAL PRIMARY KEY,
	description VARCHAR(1000),
	tag1 VARCHAR(20),
	tag2 VARCHAR(20),
	tag3 VARCHAR(20)
);

/*image
bug_id	description	tag1	tag2	tag3
1234	�ۑ������ŃN���b�V������	crash	NULL	NULL
3456	�p�t�H�[�}���X�̌���	printing	performance	NULL
5678	XML�̃T�|�[�g	NULL	NULL	NULL
*/


/*�f�����b�g
1.����̃^�O���������悤�Ƃ���ƁA3��S�Ă��擾����K�v������A�N�G�������G

SELECT * FROM Bugs
WHERE tag1 = 'performance'
OR tag2 = 'performance'
OR tag3 = 'performance';

performance ��printing�̗����̃^�O��t�����o�O�̏ꍇ
SELECT * FROM Bugs
WHERE (tag1 = 'performance' OR tag2 = 'performance' OR tag3 = 'performance')
AND (tag1 = 'printing' OR tag2 = 'printing' OR tag3 = 'printing');


2.1��݂̂�ΏۂƂ���UPDATE�̍ۂɂǂ̗񂪋󂢂Ă��邩�킩��Ȃ��A�m�F�N�G�����K�v
3�D������ɓ����l������Ȃ���Ӑ����ۏ؂ł��Ȃ�
4�D�񐔂������I��3��ő���Ȃ��󋵂�����
*/


/*������F�]���e�[�u�����쐬
*/
CREATE TABLE Tags (
	bug_id BIGINT UNSIGNED NOT NULL,
	tag VARCHAR(20),
	PRIMARY KEY (bug_id, tag),
	FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

INSERT INTO Tags (bug_id, tag) VALUES (1234, 'crash'), (3456, 'printing'), (3456, 'performance');

--�����N�G�����ȒP
SELECT * FROM Bugs INNER JOIN Tags USING (bug_id) WHERE tag = 'performance';
SELECT * FROM Bugs
INNER JOIN Tags AS t1 USING (bug_id)
INNER JOIN Tags AS t2 USING (bug_id)
WHERE t1.tag = 'printing' AND t2.tag = 'performance';