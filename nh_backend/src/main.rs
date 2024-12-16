use actix_web::{web, App, HttpServer, HttpResponse};
use sqlx::mysql::MySqlPool;
use serde::Serialize;
use dotenv::dotenv;
use std::env;

#[derive(Serialize)]
struct Macroregion {
    macro_id: i64,
    macro_name: String,
    macro_name_en: String,
    macro_center: String,
    macro_center_id: String
}

async fn get_macroregions(pool: web::Data<MySqlPool>) -> Result<HttpResponse, actix_web::Error> {
    let regions = sqlx::query_as!(
        Macroregion,
        r#"
            SELECT * FROM Macroregions;
        "#
    )
    .fetch_all(pool.get_ref())
    .await;

    match regions {
        Ok(reglist) => Ok(HttpResponse::Ok().json(reglist)),
        Err(err) =>{
            eprintln!{"Error querying database: {:?}", err};
            Ok(HttpResponse::InternalServerError().body("Failed to fetch macroregions"))
        }
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();
    let db_url = env::var("DATABASE_URL").expect("DATABASE_URL must be in .env file");

    let pool = MySqlPool::connect(&db_url)
        .await
        .expect("Failed to connect to MySQL");

    println!("STarting server at http://127.0.0.1:8080");

    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(pool.clone()))
            .route("/macroregions", web::get().to(get_macroregions))
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}
