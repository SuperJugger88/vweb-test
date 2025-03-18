module main

import databases

fn (mut app App) service_add_product(product_name string, user_id int) ! {
    mut db := databases.create_db_connection() or {
        return err
    }
    defer {
        db.close()
    }

    product_model := Product{
        name: product_name
        user_id: user_id
    }

    sql db {
        insert product_model into Product
    } or {
        return err
    }
}

fn (mut app App) service_get_all_products_from(user_id int) ![]Product {
    mut db := databases.create_db_connection() or {
        return err
    }
    defer {
        db.close()
    }

    results := sql db {
        select from Product where user_id == user_id
    } or {
        return err
    }
    return results
}