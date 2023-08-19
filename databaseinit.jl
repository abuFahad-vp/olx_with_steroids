# to create database.
# only need to run once.
using SQLite

db = SQLite.DB("vendor.db")

SQLite.execute(db, """
    CREATE TABLE IF NOT EXISTS vendor (
        id INTEGER PRIMARY KEY,
        storeName TEXT,
        storeAddress TEXT,
        contactNumber INTEGER,
        password TEXT,
        email TEXT
    );
""")

SQLite.close(db)

