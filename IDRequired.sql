/*********ID���N���C�A�h(�Ƃ肠����ID)***********/
/*��:�e�[�u����ID��������Ȃ��Ƃ����Ȃ��Ƃ������z
�S�Ẵe�[�u����ID���������ƁA�Ӑ}�ɔ������e���������邱�Ƃ�����
*/


/*�A���`�p�^�[��:�d���s�������Ă��܂�*/

CREATE TABLE BugsProducts (
  id SERIAL PRIMARY KEY,
  bug_id BIGINT UNSIGNED NOT NULL,
  product_id BIGINT UNSIGNED NOT NULL,
  FOREIN KEY (bug_id) REFERENCES Bugs(bug_id),
  FOREIN KEY (product_id) REFERENCES Products(product_id)
);

/*�f�����b�g*/
/*
1.�d���s�������Ă��܂�(bug_id��product_id�̒l�̑g�ݍ��킹���A�e�[�u����ň�ӂłȂ�)
Ex)INSERT INTO BugProducts(bug_id, product_id) VALUES (1234, 1), (1234, 1);
2.id����ʓI�p��ŉ����w�����킩��Â炢
*/

/*�A���`�p�^�[�����g�p���Ă悢��O*/
/*
��L�[�������I�ɒ����C���f�b�N�X�쐬�������I�łȂ��ꍇ�͎��R�L�[�𖳎����ċ^���L�[��U���Ă��悢*/

/*������

������L�[���`... PRIMARY KEY (bug_id, product_id)
�񖼂͎��ʂ���Ώۂ̃G���e�B�e�B��\�����̂ɂ���
 */
