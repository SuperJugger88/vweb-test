module databases

import db.pg

pub fn create_db_connection() !pg.DB {
    db := pg.connect(pg.Config{
        host: 'localhost',
        port: 5432,
        user: 'postgres', 
        password: 'postgres', 
        dbname: 'postgres'    
    })!
    return db
}