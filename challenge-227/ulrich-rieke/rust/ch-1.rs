use std::io ;
use chrono::{NaiveDate , Datelike , Weekday} ;

fn main() {
    println!("Enter a year!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let year : i32 = entered_line.trim( ).parse::<i32>().unwrap( ) ;
    let months : Vec<u32> = vec![1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 ,
	11 , 12] ;
    let mut sum : usize = 0 ;
    for m in months {
       if NaiveDate::from_ymd_opt( year , m , 13 ).unwrap( ).weekday( ) 
	  == Weekday::Fri {
	  sum += 1 ;
       }
    }
    println!("There are {} Friday 13th in {} !" , sum , year ) ;
}
