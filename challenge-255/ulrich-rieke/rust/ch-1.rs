use std::io ;

fn main() {
    println!("Enter a first word!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    let entered_line : &str = &*firstline ;
    let changed1 = entered_line.trim( ) ;
    let mut first_letters : Vec<char> = changed1.chars( ).collect( ) ;
    first_letters.sort( ) ;
    println!("Enter a second word with all the same characters and an additional one!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let sec_line : &str = &*secondline ;
    let changed2 = sec_line.trim( ) ;
    let mut second_letters : Vec<char> = changed2.chars( ).collect( ) ;
    second_letters.sort( ) ;
    let mut solution : Vec<char> = Vec::new( ) ;
     second_letters.iter().zip( first_letters.iter( ) ).
       filter( | ( &a, &b ) | a != b ).for_each( |( a , _ )| solution.push( *a ) ) ;
    if solution.len( ) > 0 {
       println!("{}" , solution[0] ) ;
    }
    else {
       println!("{}" , second_letters.pop( ).unwrap( ) ) ;
    }
}
