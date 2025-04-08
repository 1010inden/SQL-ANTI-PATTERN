/*********�X�p�Q�b�e�B�N�G��***********/
/*��:�ڂ̑O�̎d����1�̃N�G���Ŏ�������
*/

/*�A���`�p�^�[��:�����X�e�b�v�ŉ������悤�Ƃ���*/


/*�f�����b�g*/


/*
�����^�X�N���������钆�ňӐ}���Ȃ��f�J���g�ς�����
(��������e�[�u�����֘A�𐧌���������������Ȃ��Ƃ��Е����S�Ă̍s����������Ă��܂�)
*/
SELECT p.product_id, COUNT(f.bug_id) AS count_fixed, COUNT(o.bug_id) AS count_open
FROM BugsProdcuts AS p
INNER JOIN Bugs AS f ON p.bug_id = f.bug_id AND f.status = 'FIXED'
INNER JOIN BugsProducts AS p2 USING (product_id)
INNER JOIN Bugs AS o ON p2.bug_id = o.bug_id AND o.status = 'OPEN'
WHERE p.product_id = 1
GROUP BY p.product_id;
/*
product_id:1
count_fixed:77�@�@�{��11
count_open:77     �{��7
f,o�ԂŌ������Ȃ��̂�11�s�̏C���ς݃o�O*7�s�̖��C���o�O��77�ƂȂ��Ă��܂�
*/

/*������F��������*/
--�����𕪂���
SELECT p.product_id, COUNT(f.bug_id) AS count_fixed
FROM BugsProdcuts AS p
LEFT OUTER JOIN Bugs AS f ON p.bug_id = f.bug_id AND f.status = 'FIXED'
WHERE p.product_id = 1;
GROUP BY p.product_id;

SELECT p.product_id, COUNT(o.bug_id) AS count_open
FROM BugsProdcuts AS p
LEFT OUTER JOIN Bugs AS o ON p2.bug_id = o.bug_id AND o.status = 'OPEN'
WHERE p.product_id = 1;
GROUP BY p.product_id;

--union���g�p
(
	SELECT p.product_id, COUNT(f.bug_id) AS bug_count
	FROM BugsProdcuts AS p
	LEFT OUTER JOIN Bugs AS f ON p.bug_id = f.bug_id AND f.status = 'FIXED'
	WHERE p.product_id = 1;
	GROUP BY p.product_id;
)
UNION ALL
(
	SELECT p.product_id, COUNT(o.bug_id) AS bug_count
	FROM BugsProdcuts AS p
	LEFT OUTER JOIN Bugs AS o ON p2.bug_id = o.bug_id AND o.status = 'OPEN'
	WHERE p.product_id = 1;
	GROUP BY p.product_id;
)
ORDER BY bug_count DESC;