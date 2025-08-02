use std::io ;
use chrono::{NaiveDate , Datelike} ;

fn main() {
    println!("Enter a day in the format YYYY-MM-DD!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let trimmed = inline.trim( ) ;
    let year : i32 = trimmed[0..4].parse::<i32>( ).unwrap( ) ;
    let mo : u32 = trimmed[5..7].parse::<u32>( ).unwrap( ) ;
    let d : u32 = trimmed[8..10].parse::<u32>( ).unwrap( ) ;
    let date = NaiveDate::from_ymd_opt( year , mo , d ).unwrap( ) ;
    println!("{}" , Datelike::ordinal0( &date ) + 1) ;
}
