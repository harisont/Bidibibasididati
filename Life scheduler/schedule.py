import psycopg2

try:
    conn = psycopg2.connect(host="localhost",database="harisont", user="harisont", password="")
    print('Database connection established.')
    cur = conn.cursor()
    cur.execute('SET search_path TO lifescheduler;')
    cur.execute('SELECT * FROM activities;')   #sample query
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
