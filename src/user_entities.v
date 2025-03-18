module main

@[table: 'users']
pub struct User {
mut:
	id       int    @[primary; sql: serial]
    username string
    password string
    active   bool
	products []Product @[fkey: 'user_id']
}
