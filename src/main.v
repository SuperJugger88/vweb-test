module main

import vweb
import databases
import os

const port = os.getenv_opt("APP_PORT") or {"8082"}.int()

struct App {
    vweb.Context
}

pub fn (app App) before_request() {
    println('[web] before_request: ${app.req.method} ${app.req.url}')
}

fn main() {
    mut db := databases.create_db_connection() or {
        panic('Failed to connect to database: $err')
    }
    defer {
        db.close()
    }

    sql db {
        create table User
        create table Product
    } or {
        panic('Error creating tables: $err')
    }

    mut app := &App{}
    app.serve_static('/favicon.ico', 'src/assets/favicon.ico')
    app.mount_static_folder_at(os.resource_abs_path('.'), '/')

	vweb.run_at(app, vweb.RunParams{
		port: port
		host: '0.0.0.0'
		family: .ip
	}) or { panic(err) }

}

pub fn (mut app App) index() vweb.Result {
    title := 'vweb app'
    return $vweb.html()
}
