use std::io ;
use chrono::{NaiveDate } ;
use std::collections::HashSet ;

fn main() {
  println!("Enter a date as Foo => SD: '<start-date' ED: '<end-date>'" ) ;
  let mut input : String = String::new( ) ;
  io::stdin( ).read_line( &mut input ).unwrap( ) ;
  let first_line : &str = &*input ;
  let mut second_line : String = String::new( ) ;
  println!("Enter a second date in the same form as above!" ) ;
  io::stdin( ).read_line( &mut second_line ).unwrap( ) ;
  let second_string : &str = &*second_line ;
  let first_start_day : u32 = first_line[12..14].parse::<u32>().unwrap( ) ;
  let first_start_month : u32 = first_line[15..=16].parse::<u32>( ).unwrap( ) ;
  let first_end_day : u32 = first_line[24..=25].parse::<u32>().unwrap( ) ;
  let first_end_month : u32 = first_line[27..=28].parse::<u32>( ).unwrap( ) ;
  let second_start_day : u32 = second_string[12..14].parse::<u32>().unwrap( ) ;
  let second_start_month : u32 = second_string[15..=16].parse::<u32>( ).unwrap( ) ;
  let second_end_day : u32 = second_string[24..=25].parse::<u32>().unwrap( ) ;
  let second_end_month : u32 = second_string[27..=28].parse::<u32>( ).unwrap( ) ;
  let first_start : NaiveDate = NaiveDate::from_ymd( 2022 , first_start_month ,
    first_start_day ) ;
  let first_end : NaiveDate = NaiveDate::from_ymd( 2022 , first_end_month ,
    first_end_day ) ;
  let second_start : NaiveDate = NaiveDate::from_ymd( 2022 , second_start_month ,
    second_start_day ) ;
  let second_end : NaiveDate = NaiveDate::from_ymd( 2022 , second_end_month ,
    second_end_day ) ;
  let mut first_span : HashSet<NaiveDate> = HashSet::new( ) ;
  let mut second_span : HashSet<NaiveDate> = HashSet::new( ) ;
  first_span.insert( first_start ) ;
  first_span.insert( first_end ) ;
  second_span.insert( second_start ) ;
  second_span.insert( second_end ) ;
  let mut next_day : NaiveDate = first_start.succ( ) ;
  while  next_day != first_end  {
      first_span.insert( next_day)  ;
      next_day = next_day.succ( ) ;
  }
  next_day = second_start.succ( ) ;
  while  next_day != second_end  {
      second_span.insert( next_day ) ;
      next_day = next_day.succ( ) ;
  }
  let common_days : HashSet<_> = first_span.intersection( &second_span ).collect( ) ;
  println!("{} days" , common_days.len( ) ) ;
}
