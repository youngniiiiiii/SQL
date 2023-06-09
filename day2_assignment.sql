-----------------------------이론과제 2일차------------------------------------------

1.
1) 테이블
2) 외래키(FK)
3) 널(NULL)

2-2
1) 문자셋(CharacterSet)
2) 문자셋(CharSet)

2-3.
1) VARCHAR2(N)
2) CHAR(N)

2-4.
1) 제약조건
2) 기본키
3) 외래키

2-5.
1) 무결성
2) 무결성
3) 무결성

2-6.
1) Unique
2) Not Null
3) INDEX

-----------------------------실습과제 2일차------------------------------------------

--2-1
SELECT DEPTNO, TRUNC(AVG(SAL),0) ,MAX(SAL),MIN(SAL), COUNT(EMPNO)
FROM EMP
GROUP BY DEPTNO;

--2-2
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(JOB)>=3;

--2-3
SELECT  HIREDATE_YEAR,DEPTNO, COUNT(*) AS COUNT
FROM (
    SELECT DEPTNO, EXTRACT(YEAR FROM HIREDATE) AS HIREDATE_YEAR
    FROM EMP
)
GROUP BY DEPTNO, HIREDATE_YEAR;


--2-4
SELECT 
    CASE 
        WHEN COMM IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS "추가수당 여부", 
    COUNT(*) AS "인원 수" 
FROM EMP 
GROUP BY 
    CASE 
        WHEN COMM IS NOT NULL THEN 'Y'
        ELSE 'N'
    END;
    
  --2-5
   SELECT 
   DEPTNO, 
    EXTRACT(YEAR FROM HIREDATE) AS "HIRE_YEAR", 
    COUNT(*) AS "CNT", 
    MAX(SAL),
    SUM(SAL),
    AVG(SAL)
FROM EMP 
GROUP BY ROLLUP (DEPTNO, EXTRACT(YEAR FROM HIREDATE))
ORDER BY DEPTNO;


--P10.1

1-(1)오라클
SELECT A.DEPTNO, A.DNAME, B.EMPNO, B.ENAME, B.SAL
FROM DEPT A, EMP B
WHERE A.DEPTNO = B.DEPTNO AND B.SAL > 2000;

1-(2)표준
SELECT A.DEPTNO, A.DNAME, B.EMPNO, B.ENAME, B.SAL
FROM DEPT A INNER JOIN EMP B
ON A.DEPTNO = B.DEPTNO 
WHERE B.SAL>2000
;

--10P.-2
SELECT DEPTNO, DNAME, TRUNC(AVG(SAL),0), MAX(SAL), MIN(SAL), COUNT(EMPNO)
FROM EMP NATURAL JOIN DEPT
GROUP BY DEPTNO, DNAME ;


--10P.-3
SELECT A.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
FROM EMP A RIGHT JOIN DEPT B
ON A.DEPTNO = B.DEPTNO 
;

--10P.-4
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.MGR, E.SAL , D.DEPTNO
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;



--11P.-3
SELECT A.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
FROM EMP A RIGHT JOIN DEPT B
ON A.DEPTNO = B.DEPTNO 
;

--11P.-4
SELECT d.DEPTNO
      , d.DNAME 
      , e1.EMPNO 
      , e1.ENAME
      , e1.MGR
      , e1.SAL
      , e1.DEPTNO
      , s.LOSAL
      , s.HISAL
      , s.GRADE
      , e1.MGR AS MGR_EMPNO
      , e2.ENAME AS MGR_NAME
  FROM EMP e1 LEFT JOIN EMP e2 ON e1.MGR = e2.EMPNO
             LEFT JOIN SALGRADE s ON e1.SAL >= s.LOSAL AND e1.SAL <= s.HISAL
             RIGHT JOIN DEPT d ON e1.DEPTNO = d.DEPTNO
ORDER BY 1, 3;


--12P. -1
SELECT e.job,  e.empno, e.ename, e.sal,  d.deptno, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.job = (SELECT job FROM emp WHERE ename = 'ALLEN')
;


--12P. -2
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.SAL > (SELECT AVG(SAL) FROM EMP);


--P13--3
SELECT A.EMPNO, A.ENAME, A.JOB, A.DEPTNO, B.DNAME, B.LOC
FROM EMP A ,DEPT B
WHERE A.DEPTNO = B.DEPTNO
AND A.DEPTNO = 10
AND A.JOB NOT IN (SELECT JOB 
				FROM EMP			
				WHERE DEPTNO = 30
				)
;


--13P. -4
SELECT EMPNO, ENAME, SAL, GRADE
FROM EMP E
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE SAL > (SELECT MAX(SAL)
            FROM EMP
            WHERE JOB IN ('SALESMAN')
             GROUP BY JOB);
            
            
 --13P-5 
SELECT E.EMPNO
      , E.ENAME
      , E.SAL
      , S.GRADE
  FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE JOB IN ('SALESMAN'));
