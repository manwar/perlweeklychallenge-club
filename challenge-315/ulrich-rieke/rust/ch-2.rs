use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter a sentence!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    println!("Enter a word!" ) ;
    let mut firstword : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstword ).unwrap( ) ;
    println!("Enter a second word!" ) ;
    let mut secondword : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondword ).unwrap( ) ;
    let _first : &str = firstword.trim( ) ;
    let second : &str = secondword.trim( ) ;
    let wordpositions : Vec<(usize , &str)> = words.into_iter( ).enumerate( ).
       collect( ) ;
    //in the solution we assume that the second word is immediately preceded by the
    //first. So we look only for positions of the second word!
    let mut secondword_positions : HashMap<&str , Vec<usize>> = HashMap::new( );
    for ( p , st ) in &wordpositions {
       if *st == second {
	  secondword_positions.entry( st ).and_modify( |v| v.push( *p )).
		or_insert( vec![*p] ) ;
       }
    }
    //increase the positions we found the second word at by 1
    //and pass the wordpositions array for the words that follow the second word!
    for ( _ , posis ) in secondword_positions.iter_mut( ) {
       for i in posis {
	  *i += 1 ;
       }
    }
    let new_positions : Vec<usize> = secondword_positions.get( second ).unwrap( ).
       to_vec( ) ;
    let mut solution : Vec<&str> = Vec::new( ) ;
    for ( p , st ) in wordpositions {
       if new_positions.contains( &p ) {
	  solution.push( st ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
