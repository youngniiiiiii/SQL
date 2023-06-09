/**
2p
1. 논리 설계
2. 데이터 모델링

3p
1. E-R모델
2. e-R모델
3. Entity

4p
1.E-R Diagram(Entity-Relation Diagram)
2. 관계

5p
1. 카디널리티
2. 옵셔널리티

6p
1.스키마
2.테이블

7p
1. table
2. index
3. sequence
**/

--실습과제 1
SELECT EMPNO AS "EMPLOYEE_NO"
		, ENAME AS "EMPLOYEE_NAME"
		, JOB
		, MGR AS "MANAGER"
		, HIREDATE 
		, SAL AS "SALARY"
		, comm AS "COMMISSION"
		, DEPTNO AS "DEPARTMENT_NO"
FROM emp
ORDER BY DEPTNO DESC , ENAME;

--2-1
SELECT *
FROM EMP
WHERE COMM IS NULL
  AND SAL IS NOT NULL;

--2-2
SELECT *
FROM EMP
WHERE MGR IS NULL
  AND COMM IS NULL;
  
-- 3-1 
SELECT *
  FROM EMP
 WHERE ENAME LIKE '%S';

-- 3-2
SELECT *
  FROM EMP
 WHERE JOB='SALESMAN' 
   AND DEPTNO = 30 ;

-- 3-3
SELECT * 
  FROM EMP
 WHERE DEPTNO IN (20,30)
   AND SAL > 2000 ;

-- 3-4
SELECT * 
  FROM EMP
 WHERE DEPTNO = 20
   AND SAL > 2000
UNION
SELECT * 
  FROM EMP
 WHERE DEPTNO = 30
   AND SAL > 2000;

--3-5
SELECT * 
FROM EMP
WHERE COMM IS NULL
  AND MGR IS NOT NULL
  AND JOB IN ('MANAGER', 'CLERK')
  AND ename NOT LIKE '_L%';
 
--4-1
SELECT EMPNO
		, ENAME
		, RPAD(SUBSTR(EMPNO,1,2)
		, LENGTH(ENAME),'*') AS EMPNO마스킹
		, RPAD(SUBSTR(ENAME,1,1)
		, LENGTH(ENAME),'*') AS ENAME마스킹
  FROM emp
 WHERE LENGTH(ENAME)>=6;
 
--4-2
SELECT EMPNO, ENAME, JOB, SAL
		, SAL/20 AS DAY_PER_SAL
		, SAL/20/8 AS HOUR_PER_SAL
  FROM EMP 
 WHERE JOB IN ('SALESMAN','CLERK')
ORDER BY SAL;

--5-1
SELECT EMPNO
		, ENAME
		, To_char(NEXT_DAY(ADD_MONTHS(HIREDATE,3), '월요일'),'YYYY-MM-DD') AS "HIREDATE"
		, NVL(TO_CHAR(COMM), 'N/A') AS "COMM"
  FROM EMP;
  
--5-2
SELECT EMPNO
		, ENAME
		, MGR
		, CASE WHEN MGR IS NULL THEN '0000'
			   WHEN SUBSTR(MGR,1,2) = 75 THEN '5555'
			   WHEN SUBSTR(MGR,1,2) = 76 THEN '6666'
			   WHEN SUBSTR(MGR,1,2) = 77 THEN '7777'
			   WHEN SUBSTR(MGR,1,2) = 78 THEN '8888'
			   ELSE '9999' END AS CHA_MGR
FROM EMP;