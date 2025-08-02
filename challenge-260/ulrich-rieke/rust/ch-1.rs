use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut uniques : HashSet<i32> = HashSet::new( ) ;
    for n in &numbers {
       uniques.insert( *n ) ;
    }
    let mut frequencies : HashSet<usize> = HashSet::new( ) ;
    uniques.iter( ).map( | n | {
	  let fr = numbers.iter( ).filter( | &d | *d == *n ).count( ) ;
	  fr
	  }).for_each( |f| {frequencies.insert( f ) ;} ) ;
    if uniques.len( ) == frequencies.len( ) {
       println!("1") ;
    }
    else {
       println!("0") ;
    }
}
