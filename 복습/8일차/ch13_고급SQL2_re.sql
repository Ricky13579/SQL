SELECT department_id
     , employee_id
     , salary
     , sum(salary) OVER(Partition BY department_id) as sum_sal
  FROM employees
 ORDER BY department_id;

SELECT *
  FROM (SELECT department_id, job_id, salary
  		  FROM EMPLOYEES)
  PIVOT(Max(salary)
  			FOR department_id in(10, 20, 30)
  		)
  ORDER BY job_id;		
		  
SELECT job_id
     , department_id
     , max(salary)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID  < 40
 GROUP BY JOB_ID , DEPARTMENT_ID 
 ORDER BY DEPARTMENT_ID ;