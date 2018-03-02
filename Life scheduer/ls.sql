DROP SCHEMA IF EXISTS lifescheduler CASCADE;
CREATE SCHEMA lifescheduler;
SET search_path TO lifescheduler;

CREATE TABLE activities (
	name varchar(100) PRIMARY KEY,
	duration int,  --or new type int+strings
	priority int,  --check 1-3
  category varchar(50)  --check
);

\copy activities from activities.txt

--sample query
SELECT name, duration FROM activities WHERE duration <=30 AND (category='chores' OR category='study') order by duration DESC, priority ASC;
