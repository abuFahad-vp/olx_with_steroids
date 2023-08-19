# just to test the database functions. Nothing to do with server
using SQLite

db = SQLite.DB("vendor.db")
command = """
SELECT * FROM vendor
WHERE email LIKE 'fahadabu30c@gmail.com';
"""
for row in DBInterface.execute(db,command)
    count = 0
    for value in row
        if count == 4
            if "123" == value
                println("succes")
            else
                println("failed")
            end
        end
        count +=1
    end
end

SQLite.close(db)
