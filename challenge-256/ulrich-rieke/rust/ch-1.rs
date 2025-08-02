use std::io ;
use std::collections::HashSet ;

//the principle of the solution is : create 2 sets of words, one orthodromic
//and the other of the reversed words. The size of the intersection is the
//number of pairs

fn main() {
    println!("Enter some words, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let strings : Vec<&str> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ) ).collect( ) ;
    let mut orthodromic : HashSet<String> = HashSet::new( ) ;
    for s in &strings {
       let ortho = s.to_string( ) ;
       orthodromic.insert( ortho ) ;
    }
    let mut reversed : HashSet<String> = HashSet::new( ) ;
    for w in &orthodromic {
       let mut reverse_str : String = String::new( ) ;
       let mut iter = w.chars( ).rev( ) ;
       while let Some( c ) = iter.next( ) {
	  reverse_str.push( c ) ;
       }
       reversed.insert( reverse_str ) ;
    }
    let common : HashSet<_> = orthodromic.intersection( &reversed ).
       collect( ) ;
    println!("{}" , common.len( ) / 2 ) ; //we look at pairs, so we have
    //to divide by 2
}
