import psycopg2
import sys

args=sys.argv   #schedule timeslice category->categories (or)

try:
    conn = psycopg2.connect(host="localhost",database="harisont", user="harisont", password="")
    # print('Database connection established.')
    cur = conn.cursor()
    cur.execute('SET search_path TO lifescheduler')
    queryStart='SELECT name AS activity, duration FROM activities '
    queryEnd='ORDER BY duration DESC, priority ASC '
    if (len(args)==1):  #no parameters
        cur.execute(queryStart+queryEnd)
    elif (len(args)==2):
        par=(str(args[1]), )
        try:
            arg1 = int(args[1])
        except ValueError:
            cur.execute(queryStart+'WHERE category=%s '+queryEnd, par)
        else:
            cur.execute(queryStart+'WHERE duration<=%s '+queryEnd, par)
    elif (len(args)==3):
        pars=(str(args[1]), str(args[2]))
        cur.execute(queryStart+'WHERE duration<=%s AND category=%s '+queryEnd, pars)
    else:
        print('Usage: schedule mins category')
    for record in cur:
        print(record)
    cur.close()
except (Exception, psycopg2.DatabaseError) as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
