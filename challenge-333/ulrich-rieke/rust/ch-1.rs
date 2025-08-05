use std::io ;
use regex::Regex ;

fn parse_pair( bracket : &str ) -> (i32 , i32) {
   let re = Regex::new( r"([0-9]+)").unwrap( ) ;
   let numbers : Vec<i32> = re.find_iter( bracket ).map( |m| {
	 let found = m.as_str( ) ;
	 let num : i32 = found.parse::<i32>( ).unwrap( ) ;
	 num 
	 }).collect( ) ;
   (numbers[0] , numbers[1])
}

fn on_straight_line( points : Vec<(i32 , i32)> ) -> bool {
   points.iter( ).all( |p| p.0 == points[0].0 || p.1 == points[0].1 ) ||
   { let first_slope : f32 = ((points[1].1 as f32) - (points[0].1 as f32)) / 
      ((points[1].0 as f32) - (points[0].0 as f32 )) ;
     let second_slope : f32 = ((points[2].1 as f32 ) - (points[1].1 as f32 )) /
	((points[2].0 as f32) - ( points[1].0 as f32 ) ) ;
     first_slope == second_slope 
   }
}

fn main() {
    println!("Enter 3 coordinates as a pair of integers in brackets!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let re = Regex::new( r"\[\s*([0-9]+)\s*\,\s*([0-9]+)\]").unwrap( ) ;
    let trimmed = inline.trim( ) ; 	  
    let parts : Vec<&str> = re.find_iter(trimmed).map( |m| m.as_str( )).
    collect( ) ;
    let coordinates : Vec<(i32 , i32)> = parts.into_iter( ).map( |s| 
	  parse_pair( s ) ).collect( ) ;
    println!("{}" , on_straight_line( coordinates ) ) ;
}
