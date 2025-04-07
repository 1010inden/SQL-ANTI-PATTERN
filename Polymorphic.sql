/*********�|�����[�t�B�b�N�֘A***********/
/*��:�����̐e�e�[�u�����Q�Ƃ�����
Bugs�e�[�u����FeatureRequests�e�[�u���������Q�Ƃ���Comments�e�[�u���Ȃ�
*/


/*�A���`�p�^�[��:��d�ړI�̊O���L�[���g�p*/

CREATE TABLE Comments (
	comment_id SERIAL PRIMARY KEY,
	issue_type VARCHAR(20), -- 'Bugs'�܂���'FeatureRequests'���i�[�����
	issue_id BIGINT UNSIGNED NOT NULL,
	author BIGINT UNSIGNED NOT NULL,
	comment_date DATETIME,
	comment TEXT,
	FOREIGN KEY (author) REFERENCES Accounts(account_id),
);
/*�O���L�[�ł́A�e�[�u����1�̂ݎw�肵�Ȃ���΂Ȃ�Ȃ��i�����̃e�[�u�����w��ł��Ȃ��j�̂�
issue_id�̂��߂̊O���L�[�錾���o���Ȃ�
�|�����[�t�B�b�N�֘A���`����ƎQ�Ɛ�����������`�ł��Ȃ�
�܂��|�����[�t�B�b�N�֘A�́A�e�e�[�u�������ɑS���֌W���Ȃ��ꍇ�ɂ��g�p�����
Ex:�ڋq�iUsers�j�ƒ����iOrders�j��2�̃e�[�u���Ɋ֘A����Z���iAddresses�j�e�[�u���̏Z�������Ȃ�
*/





/*������*/
/*
1.�����̐e�e�[�u�����ꂼ��Ɍ����e�[�u�����쐬�A
�e�e�[�u���ł́AComments�ւ̊O���L�[�ɉ����āA�e�e�e�[�u���ւ��������O���L�[���`
*/

CREATE TABLE BugsComments (
	issue_id BIGINT UNSIGNED NOT NULL,
	comment_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (issue_id, comment_id),
	FOREIGN KEY (issue_id) REFERENCES Bugs(issue_id),
	FOREIGN KEY (comment_id) REFERENCES Comments(comment_id)
);

CREATE TABLE FeaturesComments (
	issue_id BIGINT UNSIGNED NOT NULL,
	comment_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (issue_id, comment_id),
	FOREIGN KEY (issue_id) REFERENCES FeatureRequests(issue_id),
	FOREIGN KEY (comment_id) REFERENCES Comments(comment_id)
);

/*�e�[�u���Ԃ̃����[�V�����V�b�v�ɂ́A�Q�ƌ��e�[�u���ƎQ�Ɛ�e�[�u������ɂ��ꂼ��1�����Ȃ����Ƃ��ӎ����Ă���*/