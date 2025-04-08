/*********�A���r�M���A�X�O���[�v�i�B���ȃO���[�v�j***********/
/*��:GROUP BY��p���čő�l�╽�ϒl�����ł͂Ȃ��A���̍ő�l�����������s�̑��̑������擾����N�G�������s����
*/

/*�A���`�p�^�[��:��O���[�v������Q��*/

--SELECT��ŗ񋓂����S�Ă̗�́A�s�O���[�v���ƂɒP��̒l�̍s�łȂ��Ƃ����Ȃ����P��l�̌���
SELECT product_id, MAX(date_reported) AS latest
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;

--���̏ꍇproduct_id�ɑΉ�����bug_id�͕������݁��P��l�̌����ɔ�����
SELECT product_id, MAX(date_reported) AS latest, bug_id
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;





/*������1�D�B���łȂ�����g�p*/
--�B���ȗ��r��
SELECT product_id, MAX(date_reported) AS latest
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;


/*������2. ���փT�u�N�G�����g�p*/
SELECT bp1.product_id, b1.date.reported AS latest, b1.bug_id
FROM Bugs AS b1 INNER JOIN BugsProducts AS bp1 USING (bug_id)
WHERE NOT EXISTS
(
	SELECT * FROM Bugs AS b2 INNER JOIN BugsProducts AS bp2 USING (bug_id)
	WHERE bp1.product_id = bp2.product_id 
	--date_reported���ŐV�łȂ��f�[�^�𒊏o���ANOT EXIST�ŏ��O
	AND b1.date_reported < b2.date_reported
);

/*������3. �T�u�N�G���𓱏o�e�[�u���Ƃ��Ďg�p*/
SELECT m.product_id, m.latest, b1.bug_id
FROM Bugs AS b1
INNER JOIN BugsProducts AS bp1 USING (bug_id)
INNER JOIN (
	SELECT bp2.product_id, MAX(b2.date_reported) AS latest
	FROM Bugs AS b2
	INNER JOIN BugsProducts bp2 USING (bug_id)
	GROUP BY bp2.product_id
) AS m
ON bp1.product_id = m.product_id AND b1.date_reported = m.latest;


/*������4. OUTER JOIN���g�p����*/
SELECT bp1.product_id, b1.date_reported AS latest, b1.bug_id
FROM Bugs AS b1
INNER JOIN BugsProducts AS bp1
ON b1.bug_id = bp1.bug_id
LEFT OUTER JOIN (
	Bug AS b2 INNER JOIN BugsProducts AS bp2
	ON b2.bug_id = bp2.bug_id
)
ON (
	bp1.product_id = bp2.product_id
	AND (
		b1.date_reported < b2.date_reported
		OR b1.date_reported = b2.date_reported
		AND b1.bug_id < b2.bug_id
	)
)
WHERE b2.bug_id IS NULL;


/*������5. ���̗�ɑ΂��Ă��W��֐����g�p*/
SELECT product_id, MAX(date_reported) AS latest, MAX(bug_id) AS latest_bug_id
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;

/*������6. �O���[�v���ƂɑS�Ă̒l��A��*/
SELECT product_id, MAX(date_reported) AS latest, GROUP_CONCAT(bug_id) AS bug_id_list
FROM Bugs INNER JOIN BugsProducts USING (bug_id)
GROUP BY product_id;



