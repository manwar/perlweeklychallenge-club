use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers separated by blanks");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).
      map( | s | s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    let mut unique_numbers : HashSet<i32> = HashSet::new( ) ;
    for n in numbers {
      unique_numbers.insert( n ) ;
    }
    let mut uniques : Vec<i32> = Vec::new( ) ;
    for n in unique_numbers {
      uniques.push( n ) ;
    }
    uniques.sort_by( | a , b | b.cmp( a ) ) ;
    if uniques.len( ) < 3 {
      println!("{}" , uniques[0] ) ;
    }
    else {
      println!("{}" , uniques[2] ) ;
    }
}
