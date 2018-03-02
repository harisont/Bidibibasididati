DROP SCHEMA IF EXISTS lifescheduler CASCADE;
CREATE SCHEMA lifescheduler;
SET search_path TO lifescheduler;

CREATE TABLE categories (
  name varchar(50) PRIMARY KEY
);

CREATE TABLE activities (
	name varchar(100) PRIMARY KEY,
	duration int,
	priority int CHECK (priority>0 AND priority<=3),
  category varchar(50) REFERENCES categories
);

\copy categories from categories.txt
\copy activities from activities.txt

--sample query
SELECT name, duration FROM activities WHERE duration <=30 AND (category='chores' OR category='study') order by duration DESC, priority ASC;
