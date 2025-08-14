use std::io ;
use regex::Regex ;

fn manhattan( first_pair : &(i32 , i32) , second_pair: &(i32 , i32) ) -> u32 {
   first_pair.0.abs_diff( second_pair.0) + first_pair.1.abs_diff( 
	 second_pair.1) 
}

fn main() {
    println!("Enter 2 integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let nums : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>().unwrap( ) ).collect( ) ;
    let comparison : (i32 , i32) = (nums[0] , nums[1] ) ;
    println!("Enter some integer coordinates in brackets separated by blanks!") ;
    let mut coordline : String = String::new( ) ;
    io::stdin( ).read_line( &mut coordline ).unwrap( ) ;
    let coords : &str = coordline.trim() ;
    let coordre = Regex::new(r"\[.+?\]").unwrap( ) ;
    let coordinates : Vec<&str> = coordre.find_iter( coords ).map( |m| 
	  m.as_str( ) ).collect( ) ;
    let numberre = Regex::new(r"\d+" ).unwrap( ) ;
    let points : Vec<(i32, i32)> = coordinates.into_iter().map( |s| {
	  let numbers : Vec<i32> = numberre.find_iter( s ).map( |m| {
		let found = m.as_str( ) ;
		let number : i32 = found.parse::<i32>( ).unwrap( ) ;
		number }).collect( ) ;
	  (numbers[0] , numbers[1] ) }).collect( ) ;
    let valid_points : Vec<(usize, &(i32 , i32))> = points.iter( ).enumerate( ).
       filter( |&(_ , (x , y))| *x == comparison.0 || *y == comparison.1 ).collect( );
    let distances : Vec<(usize , u32)> = valid_points.iter( ).map( |p| (p.0 , 
	     manhattan( &p.1 , &comparison ))).collect( ) ;
    let result : i32 = match distances.len() {
       0 => -1 ,
       1 => distances[0].0 as i32 , 
       _ => {
	  let mini_pair : &(usize , u32 ) = distances.iter().min_by( |p , q| p.1.
		cmp(&q.1)).unwrap( ) ;
	  mini_pair.0 as i32 
       }
    } ;
    println!("{}" , result ) ;
}
