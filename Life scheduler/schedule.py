import psycopg2
import sys

args=sys.argv   #schedule timeslice category->categories (or)

try:
    conn = psycopg2.connect(host="localhost",database="harisont", user="harisont", password="")
    print('Database connection established.')
    cur = conn.cursor()
    cur.execute('SET search_path TO lifescheduler')
    basicQuery='SELECT name AS activity, duration FROM activities '
    if (len(args)==1):  #no parameters
        cur.execute(basicQuery)
    elif (len(args)==2):
        try:
            arg1 = int(args[1])
        except ValueError:
            cur.execute(basicQuery+'WHERE category=\''+str(args[1])+'\'')
        else:
            cur.execute(basicQuery+'WHERE duration<='+str(arg1))
    elif (len(args)==3):
        cur.execute(basicQuery+'WHERE category=\''+str(args[1])+'\' AND duration='+args[2])
    else:
        print('Usage: schedule mins category')
    print("Rows: ", cur.rowcount)
    row = cur.fetchone()
    while row is not None:
        print(row)
        row = cur.fetchone()
    cur.close()
except (Exception, psycopg2.DatabaseError) as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
        print('Database connection closed.')

    #SELECT name AS activity, duration FROM activities WHERE duration <=30 AND (category='chores' OR category='study') order by duration DESC, priority ASC;
