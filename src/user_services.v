module main

import crypto.bcrypt
import databases

fn (mut app App) service_add_user(username string, password string) ! {
    mut db := databases.create_db_connection() or {
        return err
    }
    defer {
        db.close()
    }

    hashed_password := bcrypt.generate_from_password(password.bytes(), bcrypt.min_cost) or {
        return err
    }

    user_model := User{
        username: username
        password: hashed_password
        active: true
    }

    sql db {
        insert user_model into User
    } or {
        return err
    }
}

fn (mut app App) service_get_all_user() ![]User {
    mut db := databases.create_db_connection() or {
        return err
    }
    defer {
        db.close()
    }

    results := sql db {
        select from User
    } or {
        return err
    }
    return results
}

fn (mut app App) service_get_user(id int) !User {
    mut db := databases.create_db_connection() or {
        return err
    }
    defer {
        db.close()
    }
    results := sql db {
        select from User where id == id
    } or {
        return err
    }
    if results.len == 0 {
        return error('no results')
    }
    return results[0]
}