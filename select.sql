# 1.查询同时存在1课程和2课程的情况
SELECT studentId FROM student_course 
WHERE courseId = 1 AND studentId IN
(SELECT studentId FROM student_course
WHERE courseId=2);

# 2.查询同时存在1课程和2课程的情况
SELECT studentId FROM student_course 
WHERE courseId = 1 AND studentId IN
(SELECT studentId FROM student_course
WHERE courseId=2);

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
SELECT id, NAME FROM student INNER JOIN
(SELECT studentId,AVG(score) AS average 
FROM student_course 
GROUP BY studentId HAVING average>=60) c
ON id = c.studentId;

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
/*
SELECT student.* FROM student 
LEFT JOIN student_course 
ON id = studentId WHERE score IS NULL;
*/
SELECT * FROM student WHERE id NOT IN 
(SELECT studentId FROM student_course);

# 5.查询所有有成绩的SQL
SELECT * FROM student WHERE id IN 
(SELECT studentId FROM student_course 
WHERE score IS NOT NULL);

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
SELECT s.* FROM student s, student_course c
WHERE s.id = c.studentId AND courseId=1 AND s.id IN
(SELECT studentId FROM student s, student_course c
WHERE s.id = c.`studentId` AND courseId=2);

# 7.检索1课程分数小于60，按分数降序排列的学生信息
SELECT * FROM student WHERE id IN
(SELECT studentId FROM student_course 
WHERE courseId=1 AND score<60 
ORDER BY score DESC);

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
SELECT course.NAME AS course, t.name AS teacher,c.* FROM course INNER JOIN
(SELECT courseId,AVG(score) AS average 
FROM student_course GROUP BY courseId 
ORDER BY average DESC,courseId ASC) c
INNER JOIN teacher t
ON course.id = c.courseId AND t.id=course.teacherId;

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT s.name,c.score FROM student s 
JOIN student_course c 
ON s.id=c.studentId 
WHERE score<60 AND courseId IN
(SELECT id FROM course WHERE NAME='数学')

