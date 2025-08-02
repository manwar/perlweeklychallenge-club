use std::io ;
use itertools::Itertools ;

fn condition( permu : &Vec<i32> ) -> bool {
   permu.iter( ).enumerate( ).all( |p| {
	 *p.1 % ((p.0 + 1) as i32) == 0 ||
	 ((p.0 + 1) as i32) % *p.1 == 0 
	 } )
}

fn main() {
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let number : i32 = inline.trim( ).parse::<i32>( ).unwrap( ) ;
    let mut sum : usize = 0 ;
    for v in (1..=number).permutations( number as usize ) {
       if condition( &v ) {
	  sum += 1 ;
       }
    }
    println!("{}" , sum ) ;
}
