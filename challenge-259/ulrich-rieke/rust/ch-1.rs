use std::io ;
use chrono::{NaiveDate , Datelike ,  Weekday} ;
use std::io::BufRead ;

fn main() -> io::Result<()> {
    println!("Enter a starting day in form year-month-day!");
    let mut dateline : String = String::new( ) ;
    io::stdin( ).read_line( &mut dateline ).unwrap( ) ;
    let dateparts : Vec<u32> = dateline.split("-").map( | p | p.trim( ).
	  parse::<u32>( ).unwrap( )).collect( ) ;
    let current : Option<NaiveDate> = NaiveDate::from_ymd_opt( dateparts[0] as i32 , 
	  dateparts[1] , dateparts[2] ) ;
    println!("Enter a day offset!") ;
    let mut os : String = String::new( ) ;
    io::stdin( ).read_line( &mut os ).unwrap( ) ;
    let someline : &str = &*os ;
    let mut offset : u32 = someline.trim( ).parse::<u32>( ).unwrap( ) ;
    println!("Enter some bank holidays, in the same way as above!") ;
    println!("Enter <return> to end!") ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    let mut all_input : String = String::new( ) ;
    while let Some( line ) = lines.next( ) {
       let last_input = line.unwrap( ) ;
       if last_input.len( ) == 0 {
	  break ;
       }
       else {
	  all_input.push_str( &last_input ) ;
	  all_input.push_str( "\n" ) ;
       }
    }
    let holidays : Vec<&str> = all_input.split( "\n" ).collect( ) ;
    let mut current_day : NaiveDate = current.unwrap( ) ;
    let mut nddi = current_day.iter_days( ) ;
    offset = offset + 1 ;
    while offset != 0 {
       let next_day = nddi.next( ).unwrap( ) ;
       let nd_string = next_day.format("%Y-%m-%d").to_string( ) ;
       let nd_str = nd_string.as_str( ) ;
       let wd = next_day.weekday( ) ;
       if wd != Weekday::Sat && wd != Weekday::Sun && ! holidays.contains( 
		&nd_str ) {
	  offset = offset - 1 ;
       }
       current_day = next_day.clone( ) ;
    }
    println!("{}" , current_day.format("%Y-%m-%d").to_string( ) ) ;
    Ok(())
}
