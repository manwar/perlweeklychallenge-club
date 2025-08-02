use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    let first_entered : &str = &*firstline ;
    println!("Enter the same number of integers, separated by blanks!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let sec_entered : &str = &*secondline ;
    let mut first_numbers : Vec<i32> = first_entered.trim( ).
       split_whitespace( ).map( | s | s.parse::<i32>( ).unwrap( ) ).
       collect( ) ;
    let mut second_numbers : Vec<i32> = sec_entered.trim( ).
       split_whitespace( ).map( | s | s.parse::<i32>( ).unwrap( ) ).
       collect( ) ;
    first_numbers.sort( ) ;
    second_numbers.sort( ) ;
    let zipped : Vec<(i32 , i32)> = first_numbers.into_iter( ).zip( 
	  second_numbers.into_iter( )).collect( ) ;
    let comp : i32 = zipped[0].1 - zipped[0].0 ;
    if zipped.iter( ).all( | p | p.1 - p.0 == comp ) {
       println!("{}" , comp ) ;
    }
    else {
       println!(" ") ;
    }
}
