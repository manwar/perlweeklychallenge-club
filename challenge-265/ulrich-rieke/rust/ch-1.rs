use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
    let elements : usize = numbers.iter( ).count( ) ;
    let mut unique_numbers : HashSet<i32> = HashSet::new( ) ;
    numbers.iter( ).for_each( | d | {unique_numbers.insert( *d ) ; } ) ;
    let mut selected : Vec<i32> = unique_numbers.into_iter( ).filter( | &d | {
	  let freq = numbers.iter( ).filter( | &i | *i == d ).count( ) ;
	  (freq as f32) >= (elements as f32) / 3.0f32 } ).collect( ) ;
    selected.sort( ) ;
    if selected.len( ) > 0 {
       println!("{}" , selected[ 0 ] ) ;
    }
    else {
       println!("undef") ;
    }
}
