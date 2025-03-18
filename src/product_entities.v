module main

@[table: 'products']
struct Product {
	id      int    @[primary; sql: serial]
    name    string
    user_id int
	created_at string @[default: 'CURRENT_TIMESTAMP']
}
