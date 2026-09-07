use std::io ;
use itertools::Itertools ;

//no more D's than U's in the initial prefix
fn condition( word : &String ) -> bool {
   let len = word.len( ) ;
   let value : bool = (1..len).all( |n| {
         let substring : String = word[0..n].to_string( ) ;
         substring.chars( ).filter( |&c| c == 'U' ).count( ) >= 
         substring.chars( ).filter( |&c| c == 'D' ).count( ) 
         } ) ;
   value
}

fn main() {
    println!("Enter a number!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let number : usize = inline.trim( ).parse::<usize>( ).unwrap( ) ;
    let mut current_word : String = String::new( ) ;
    for _ in 0..number {
       current_word.push( 'U' ) ;
       current_word.push( 'D' ) ;
    }
    let mut solution : Vec<String> = Vec::new( ) ;
    let mut permu : String = String::new( ) ;
    let mut iter = current_word.chars( ).permutations( 2 * number ) ;
    while let Some( c ) = iter.next( ) {
       for letter in c {
          permu.push( letter ) ;
       }
       if condition( &permu ) && ! solution.contains( &permu ) {
          solution.push( permu.clone( ) ) ;
       }
       permu.clear( ) ;
    }
    solution.sort( ) ;
    println!("{:?}" , solution ) ;
}
