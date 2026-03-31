use std::io ;

//determines whether second_time is later than first_time
fn is_later( first_time : &str , second_time : &str ) -> bool {
   let first_time_parts : Vec<&str> = first_time.split(":").collect( ) ;
   let second_time_parts : Vec<&str> = second_time.split(":").collect() ;
   if first_time_parts[0] != second_time_parts[0] {
      second_time_parts[0] > first_time_parts[0]
   }
   else {
      second_time_parts[1] > first_time_parts[1]
   }
}

fn main() {
    println!("Enter the start and end times of a first event!");
    let mut first_ev_line : String = String::new( ) ;
    io::stdin().read_line( &mut first_ev_line).unwrap( ) ;
    println!("Enter the start and end times of a second event!") ;
    let mut second_ev_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut second_ev_line ).unwrap( ) ;
    let mut result : bool = true ;
    let first_event_times : Vec<&str> = first_ev_line.trim( ).
       split_whitespace( ).collect( ) ;
    let second_event_times : Vec<&str> = second_ev_line.trim( ).
       split_whitespace( ).collect( ) ;
    if ! is_later( first_event_times[0] , second_event_times[0] ) {
       //there is a collision , result remains unchanged!
    }
    else {
       if is_later( first_event_times[1] , second_event_times[0] ) ||
        first_event_times[1] == second_event_times[0] {
          result = false ;
       }
       else { //result remains unchanged!
       }
    }
    println!("{}" , result ) ;
}
