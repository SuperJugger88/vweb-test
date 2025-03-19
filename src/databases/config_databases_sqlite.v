module databases

import db.pg
import os

pub fn create_db_connection() !pg.DB {
    db := pg.connect(pg.Config{
		host: os.getenv_opt('DB_HOST') or { 'localhost' },
		port: os.getenv_opt('DB_PORT') or { '5432' }.int(),
		user: os.getenv_opt('DB_USER') or { 'postgres' },
		password: os.getenv_opt('DB_PASSWORD') or { 'postgres' },
		dbname: os.getenv_opt('DB_NAME') or { 'postgres' },
    })!
    return db
}
