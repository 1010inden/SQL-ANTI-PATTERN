/*********�W�F�C�E�H�[�N(�M������)***********/
/*��:���i�΃A�J�E���g�ő���1����������A�J�E���g�������̘A��������Ƃ����Ɩ��v�����ǉ�
=���i����A�J�E���g�ɑ΂���1�Α��̊֘A���K�v
*/


/*�A���`�p�^�[��:�J���}��؂�t�H�[�}�b�g�̃��X�g���i�[*/

CREATE TABLE Products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(1000),
  account_id VARCHAR(1000), -- �J���}��؂�̃��X�g
	-- ���̗�...
  FOREIN KEY (account_id) REFERENCES Accounts(account_id)
);


/*�f�����b�g*/
/*
1.���i�̌����ɐ��K�\���Ȃǂ��K�v�ɂȂ�@Ex)SELECT * FROM Products WHERE account_id REGEXP '[[:<:]]12[[:>:]]';
2.�C���f�b�N�X�̃����b�g������
3.���K�\����DB���i�ɂ���ĈقȂ�
4.account_id VARCHAR(1000)�ɂ��ł���߂ȓ��͂��\(�A�J�E���gID�̑Ó������؂��ł��Ȃ�)
5.���X�g�̒�������������=VARCHAR(30)�̏ꍇ�J���}���܂߂�1�G���g��3�����Ȃ烊�X�g�Ɋi�[�ł���̂�10�̂�
*/

/*������

 �����e�[�u�����쐬
 Products��Accounts�e�[�u���̊e��L�[���񂹏W�߂��e�[�u��Contacts���쐬���A����������Ŏg�p����
 Ex)SELECT * FROM Contacts WHERE account_id = 12;
 */
