use chrono::{NaiveDate , Weekday , Datelike}  ;
use std::io ;

fn main() {
    println!("Enter the year , the month , the number of given weekday and the weekday!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<usize> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<usize>( ).unwrap( )).collect( ) ;
    let y : i32 = numbers[0] as i32 ;
    let m : u32 = numbers[1] as u32 ;
    let num : u8 = numbers[2] as u8 ;
    let wd : Weekday = match numbers[3] {
       1 => Weekday::Mon ,
       2 => Weekday::Tue ,
       3 => Weekday::Wed , 
       4 => Weekday::Thu ,
       5 => Weekday::Fri , 
       6 => Weekday::Sat , 
       7 => Weekday::Sun , 
       _ => Weekday::Sun 
    } ; 
    if NaiveDate::from_weekday_of_month_opt( y , m , 
	  wd , num ).is_some( ) {
       let day =  NaiveDate::from_weekday_of_month_opt( y , m , 
	     wd , num ).unwrap( ).day( ) ;
       println!("{}" , day ) ;
    }
    else {
       println!("0") ;
    }
}
