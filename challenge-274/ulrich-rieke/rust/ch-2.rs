use std::io ;
use std::io::BufRead ;

fn find_next_departures( minute : u8 , schedule : &Vec<Vec<u8>> ) -> Vec<(u8 , u8)> {
   let mut dep_pairs : Vec<(u8 , u8)> = Vec::new( ) ;
   let len = schedule.len( ) ;
   for i in 0..len {
      let mut dep : u8 = schedule[i][1] ;
      while dep < minute {
	 dep += schedule[i][0] ;
      }
      dep_pairs.push( (i as u8 , dep) ) ;
   }
   let pairs = &mut dep_pairs[..] ;
   pairs.sort_by( | a , b | a.1.partial_cmp( &b.1).unwrap( ) ) ;
   let result : Vec<(u8 , u8)> = pairs.to_vec( ) ;
   result 
}

fn find_arrivals( schedule : &Vec<Vec<u8>> , next_buses : &Vec<(u8,u8)>)
    -> Vec<u8> {
       let mut arrivals : Vec<u8> = Vec::new( ) ;
       for pair in next_buses {
	  let arri : u8 = pair.1 + schedule[pair.0 as usize][2] ;
	  arrivals.push( arri ) ;
       }
       arrivals 
}

fn let_pass_one( minute : u8 , schedule : &Vec<Vec<u8>> ) -> bool {
   let next_departures : Vec<(u8 , u8)> = find_next_departures( minute , &schedule ) ;
   let arrivals : Vec<u8> = find_arrivals( &schedule , &next_departures ) ;
   if next_departures[0].1 != next_departures[1].1 && arrivals[0] > arrivals[1] {
      return true ;
   }
   false 
}

fn main() -> io::Result<()> {
    println!("Enter some lines of 3 digits marking interval, start and travel time!") ;
    println!( "Enter <return> to end!" ) ;
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
    let all_lines : &str = all_input.as_str( ).trim( ) ;
    let rows : Vec<&str> = all_lines.split( "\n" ).collect( ) ;
    let mut schedule : Vec<Vec<u8>> = Vec::new( ) ;
    for r in &rows {
       if r.len( ) > 0 {
	  let sub_schedule : Vec<u8> = r.split_whitespace( ).map( | s | 
		s.trim( ).parse::<u8>( ).unwrap( ) ).collect( ) ;
	  schedule.push( sub_schedule ) ;
       }
    }
    let result : Vec<u8> = (0..60).filter( | &i | let_pass_one( i , &schedule ) ).
       collect( ) ;
    println!("{:?}" , result) ;
    Ok(())
}
