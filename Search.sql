/*********�v���}���Y�E�T�[�`�G���W���i�n�҂̃T�[�`�G���W���j***********/
/*��:����������̔�r
*/


/*�A���`�p�^�[��:�p�^�[���}�b�`�q����g�p
�p�^�[���}�b�`�q��ł̓C���f�b�N�X�̃����b�g�������Ȃ����߁A�t���X�L�����ɂȂ�
*/
SELECT * FROM Bugs WHERE description LIKE '%crash%';
SELECT * FROM Bugs WHERE descritpion REGEXP 'crash';

/*�Ӑ}���Ȃ��}�b�`�������Ă��܂����Ƃ�*/
SELECT * FROM Bugs WHERE description LIKE '%one%';--money�Ȃǂ���v���Ă��܂�


/*������F�K�؂ȃc�[�����g�p*/
--mysql�̏ꍇMyISAM�X�g���[�W�G���W���݂̂��T�|�[�g����t���e�L�X�g�C���f�b�N�X���񋟂����
ALTER TABLE Bugs ADD FULLTEXT INDEX bugfts (summary, description);
SELECT * FROM Bugs WHERE MATCH(summary, description) AGAINST ('crash');

