# 多表查询
#案例一:查询女神名和对应的男神名
SELECT 
  `name`,
  `boyName` 
FROM
  `beauty`,
  `boys` 
WHERE beauty.`boyfriend_id` = boys.`id` ;

#案例二:查询员工名和对应的部门名
SELECT 
  `last_name`,
  `department_name` 
FROM
  `departments`,
  `employees` 
WHERE employees.`department_id` = departments.`department_id` ;

#为表起别名,查询员工名,工种号,工种名
SELECT 
  e.`last_name`,
  e.`job_id`,
  j.`job_title` 
FROM
  `employees` AS e,
  `jobs` AS j 
WHERE e.`job_id` = j.`job_id` ;

#自连接
#查询员工和其上级的名称
SELECT 
  e.`employee_id`,
  e.`last_name`,
  m.`employee_id`,
  m.`last_name` 
FROM
  `employees` AS e,
  `employees` AS m 
WHERE e.`manager_id` = m.`employee_id` ;

#sql99语法
/*
语法：
	select 查询列表
	from 表1别名【连接类型】
	join表2别名
	on连接条件
	【where 筛选条件】
	【group by分组】
	【having 筛选条件】
	【order by 排序列表】
	
分类：
	内连接（★）：inner
	外连接
		左外（★）：left【outer】
		右外（★）：right【outer】
		全外：full【outer】
	交叉连接：cross
*/
#内连接
#查询名字包含e的员工名和工种名
SELECT 
  last_name,
  job_title 
FROM
  employees e 
  INNER JOIN jobs j 
    ON e.job_id = j.job_id 
WHERE e.last_name LIKE '%e%' ;

#查询部门个数>3的城市名和部门名
#1.查询每个城市的部门个数
#2.在1基础上筛选满足条件
SELECT 
  city,
  COUNT(*) 部门个数 
FROM
  departments d 
  INNER JOIN locations l 
    ON d.`location_id` = l.`location_id` 
GROUP BY city 
HAVING COUNT(*) > 3 ;

#外连接
/*
应用场景：用于查询一个表中有，另一个表没有的记录
特点：
1、外连接的查询结果为主表中的所有记录如果从表中有和它匹配的，则显示匹配的值
如果从表中没有和它匹配的，则显示nul1
外连接查询结果=内连接结果+主表中有而从表没有的记录
2、左外连接，left join左边的是主表
右外连接，right join右边的是主表
3、左外和右外交换两个表的顺序，可以实现同样的效果	
*/
#引入：查询男朋友不在男神表的的女神名
#左外连接
SELECT 
  b.name,
  bo.* 
FROM
  beauty b 
  LEFT JOIN boys bo 
    ON b.`boyfriend_id` = bo.`id` 
WHERE bo.`id` IS NULL ;

#交叉连接(笛卡尔积)
SELECT 
  b.*,
  bo.* 
FROM
  beauty b 
  CROSS JOIN boys bo ;

#子查询
/*
含义：
出现在其他语句中的select语句，称为子查询或内查询外部的查询语句，称为主查询或外查询分类：
	按子查询出现的位置：
		select后面：仅仅支持标量子查询
		from后面：支持表子查询
		where或having后面：
			标量子查询(单行)
			列子查询(多行)
			行子查询
	exists后面（相关子查询）
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果集有一行多列）
	表子查询（结果集一般为多行多列）
*/
#一、where或having后面
/*
1、标量子查询（单行子查询）
2、列子查询（多行子查询）
3、行子查询（多列多行）特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配着单行操作符使用
> < >= <= = <>
列子查询，一般搭配着多行操作符使用IN、ANY/SOME、ALL
*/
#1.标量子查询
#案例1：谁的工资比Abel高？
#①查询Abe1的工资
SELECT 
  salary 
FROM
  employees 
WHERE last_name = 'Abel' ;

#②查询员工的信息，满足salary>①结果
SELECT 
  * 
FROM
  employees 
WHERE salary > 
  (SELECT 
    salary 
  FROM
    employees 
  WHERE last_name = 'Abel') ;

#案例2：返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
#①查询141号员工的job_id 
SELECT 
  job_id 
FROM
  employees 
WHERE employee_id = 141 ;

#②查询143号员工的salary
SELECT 
  salary 
FROM
  employees 
WHERE employee_id = 143 ;

#③查询员工的姓名，job_id和工资，要求job_id=①并且salary>②
SELECT 
  last_name,
  job_id,
  salary 
FROM
  employees 
WHERE job_id = 
  (SELECT 
    job_id 
  FROM
    employees 
  WHERE employee_id = 141) 
  AND salary > 
  (SELECT 
    salary 
  FROM
    employees 
  WHERE employee_id = 143) ;

#二、select后面
#案例：查询每个部门的员工个数
SELECT 
  d.*,
  (SELECT 
    COUNT(*) 
  FROM
    employees e 
  WHERE e.department_id = d.`department_id`) 个数 
FROM
  departments d ;

