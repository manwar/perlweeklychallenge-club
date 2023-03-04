use std::io ;
use itertools::Itertools ;

//we assume the second time to be the later one
fn find_difference( first_time : &str , second_time : &str ) -> i32 {
  let first_time_parts : Vec<&str> = first_time.split( ':' ).collect( ) ;
  let second_time_parts : Vec<&str> = second_time.split( ':' ).collect( ) ;
  let first_times : Vec<i32> = first_time_parts.iter( ).map( | s | s.trim( ).
    parse::<i32>( ).unwrap( )).collect( ) ;
  let second_times : Vec<i32> = second_time_parts.iter( ).map( | s |
    s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
  let first_time_hours : i32 = first_times[0] ;
  let first_time_minutes : i32 = first_times[1] ;
  let second_time_hours : i32 = second_times[0] ;
  let second_time_minutes : i32 = second_times[1] ;
  let mut second_timepoint : i32 = second_time_hours * 60 + second_time_minutes ;
  let first_timepoint : i32 = first_time_hours * 60 + first_time_minutes ;
  let mut diff = second_timepoint - first_timepoint ;
  if diff < 0 {
      second_timepoint += 24 * 60 ;
      diff = second_timepoint - first_timepoint ;
  }
  diff
}

fn main() {
    println!("Please enter some times, separated by blanks , times with ':'");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let times : Vec<&str> = entered_line.split_whitespace( ).map( | s |
      s.trim( )).collect( ) ;
    let mut differences : Vec<i32> = Vec::new( ) ;
    for ts in times.into_iter( ).permutations( 2 ) {
      let diff = find_difference( ts[0] , ts[1] ) ;
      differences.push( diff ) ;
    }
    println!("{:?}" , differences.iter( ).min( ).unwrap( ) ) ;
}
