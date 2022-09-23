use chrono::NaiveDate ;
use std::io ;

fn is_leap( y : i32 ) -> bool {
  return ( y % 400 == 0 ) || ( y % 4 == 0 && y % 100 != 0 ) ;
}

fn start_year_condition( y : i32 , m : i32 , d : i32 ) -> bool {
  return is_leap( y ) && m == 1 && d == 1 ;
}

fn end_year_condition( y : i32 , m : i32 , d : i32 ) -> bool {
  return is_leap( y ) && m == 12 && d == 31 ;
}

fn main() {
    println!("Enter a start date in the form yyyy-mm-dd!");
    let mut input: String  = String::new( ) ;
    io::stdin( ).read_line( &mut input).unwrap( ) ;
    let year1 = &input[0..4].parse::<i32>( ).unwrap( ) ;
    let month1 = &input[5..=6].parse::<i32>( ).unwrap( ) ;
    let day1 = &input[8..].trim( ).parse::<i32>( ).unwrap( ) ;
    let mut date: &str = &*input ;
    date = date.trim( ) ;
    let start_date: NaiveDate = NaiveDate::parse_from_str( date ,
      "%Y-%m-%d").unwrap( ) ;
    println!("Enter an end date in the form yyyy-mm-dd!" ) ;
    input.clear( ) ;
    io::stdin( ).read_line( &mut input).unwrap( ) ;
    let mut end: &str = &*input ;
    end = end.trim( ) ;
    let year2 = &end[0..4].parse::<i32>( ).unwrap( ) ;
    let month2 = &end[5..=6].parse::<i32>( ).unwrap( ) ;
    let day2 = &end[8..].parse::<i32>( ).unwrap( ) ;
    let end_date = NaiveDate::parse_from_str( end , "%Y-%m-%d").unwrap( ) ;
    let days_passed: chrono::Duration = NaiveDate::
      signed_duration_since( end_date , start_date ) ;
    let mut to_be_subtracted : i64 = 0 ;
    if year2 - year1 == 1 {
      if start_year_condition( *year1 , *month1 , *day1 ) {
      to_be_subtracted += 1 ;
      }
      if end_year_condition( *year2 , *month2 , *day2 ) {
      to_be_subtracted += 1 ;
      }
    }
    if year2 - year1 > 1 {
      let yr = *year1 + 1..= *year2 ;
      for i in yr {
      if is_leap( i ) {
        to_be_subtracted += 1 ;
      }
      }
    }
    let all_days : i64 = days_passed.num_days( ) - to_be_subtracted ;
    let years : i64 = all_days.checked_div( 365 ).unwrap( ) ;
    let days : i64 = all_days - years * 365 ;
    match years {
      0 => {}
      1 => print!("1 year " ) ,
      _ => print!("{} years " , years)
    }
    match days {
      0 => if years > 0 {
          println!("") ;
            }
            else {
          println!("0 days") ;
        } ,
      1 => println!("1 day") ,
      _ => println!("{} days" , days )
    }
}
