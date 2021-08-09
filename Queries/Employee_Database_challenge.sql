-- Number of retiring employees by title
SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Filter for current employees current title
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO unique_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND ti.to_date = ('9999-01-01')
ORDER BY e.emp_no;


--Get number of titles
SELECT COUNT(DISTINCT title) FROM unique_titles


-- Create a table with the counts of retiring employees based on title
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC

-- Mentorship Eligibility
SELECT DISTINCT ON(e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE ti.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no

SELECT COUNT(emp_no), title
INTO mentorship_elig_title
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC

DROP TABLE mentorship_eligibility_broad


--Broaden the eligibility age
SELECT DISTINCT ON(e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibility_broad
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE ti.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
ORDER BY e.emp_no

SELECT COUNT(emp_no), title
INTO mentorship_broad_title
FROM mentorship_eligibility_broad
GROUP BY title
ORDER BY count DESC