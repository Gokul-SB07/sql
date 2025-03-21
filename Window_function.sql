select * from employee_windowfn;


select * from (select e.*,
				row_number() over(partition by dept_name order by emp_id) rnk from 
				employee_windowfn e )
where rnk<=2;

select e.*, lead(salary) over(partition by dept_name order by emp_id ) next_emp_salary, 
			lag(salary) over(partition by dept_name order by emp_id ) previous_emp_salary
			from employee_windowfn e;

select e.*, lead(salary) over(partition by dept_name order by emp_id ) next_emp_salary, 
			case when e.salary > lead(salary) over(partition by dept_name order by emp_id ) then 'Greater'
			     when e.salary < lead(salary) over(partition by dept_name order by emp_id ) then 'Less'
				 when e.salary = lead(salary) over(partition by dept_name order by emp_id ) then 'Match'
					 end as check
			from employee_windowfn e;
