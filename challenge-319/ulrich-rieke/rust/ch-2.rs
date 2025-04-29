use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    println!("Enter some more integers separated by blanks!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let firstnumbers : Vec<i32> = inline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let secondnumbers : Vec<i32> = secondline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut first_set : HashSet<i32> = HashSet::new( ) ;
    let mut second_set : HashSet<i32> = HashSet::new( ) ;
    for n in firstnumbers {
       first_set.insert( n ) ;
    }
    for n in secondnumbers {
       second_set.insert( n ) ;
    }
    let common : HashSet<i32> = &first_set & &second_set ;
    if common.len( ) > 0 {
       println!("{}" , common.into_iter( ).min( ).unwrap( ) ) ;
    }
    else {
       println!("-1") ;
    }
}
