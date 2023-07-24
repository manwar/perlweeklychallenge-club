use std::io ;

fn main() {
    println!("Please enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let changed : &str = entered_line.trim( ) ;
    println!("Enter as many integers as the length of the string!");
    println!("They should go from 0 to the <length of the string> - 1!") ; 
    let mut second_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut second_line ).unwrap( ) ;
    let numberline : &str = &*second_line ;
    let numbers : Vec<usize> = numberline.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<usize>( ).unwrap( ) ).collect( ) ;
    let mut letters : Vec<(usize, char)> = numbers.into_iter( ).zip(
	  changed.chars( ) ).collect( ) ;
    let letterpairs : &mut [(usize, char)] = letters.as_mut_slice( ) ;
    letterpairs.sort_by( | a , b | a.0.cmp( &b.0 ) ) ;
    let mut solution : String = String::new( ) ;
    for p in letterpairs.iter( ) {
       solution.push( p.1 ) ;
    }
    println!("{}" , solution ) ;
}
