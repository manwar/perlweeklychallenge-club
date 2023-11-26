use std::io ;
use std::collections::HashSet ;
fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut first_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut first_line ).unwrap( ) ;
    let a_line : &str = &*first_line ;
    let first_nums : Vec<i32> = a_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Enter some more integers, separated by blanks!") ;
    let mut second_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut second_line ).unwrap( ) ;
    let b_line : &str = &*second_line ;
    let second_nums : Vec<i32> = b_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut first_set : HashSet<i32> = HashSet::new( ) ;
    let mut second_set : HashSet<i32> = HashSet::new( ) ;
    for i in first_nums {
       first_set.insert( i ) ;
    }
    for i in second_nums {
       second_set.insert( i ) ;
    }
    let first_diff : HashSet<_> = second_set.difference( &first_set )
       .collect( ) ;
    let second_diff : HashSet<_> = first_set.difference( &second_set )
       .collect( ) ;
    println!("({:?} , {:?})" , second_diff , first_diff ) ;
}
