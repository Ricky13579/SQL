SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID , JOB_ID 
 ORDER BY DEPARTMENT_ID , JOB_ID;
 
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY ROLLUP(DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID ;
 
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY CUBE(DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID;
 
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY GROUPING SETS (DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID;
 
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
     , GROUPING(DEPARTMENT_ID)
     , GROUPING(JOB_ID)
  FROM EMPLOYEES
 GROUP BY CUBE(DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID;
 
SELECT department_id
     , LISTAGG(LAST_NAME, ', ')
     	WITHIN GROUP(ORDER BY salary DESC) AS last_name
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY DEPARTMENT_ID;