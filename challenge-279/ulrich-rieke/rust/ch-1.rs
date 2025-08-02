use std::io ;

fn main() {
    println!("Enter some letters!");
    let mut letterline : String = String::new( ) ;
    io::stdin( ).read_line( &mut letterline ).unwrap( ) ;
    let letterstr : &str = letterline.as_str( ).trim( ) ;
    println!("Enter some weights!") ;
    let mut weightline : String = String::new( ) ;
    io::stdin( ).read_line( &mut weightline ).unwrap( ) ;
    let weightstr : &str = weightline.as_str( ).trim( ) ;
    let weights : Vec<usize> = weightstr.split_whitespace( ).map( | s | 
	  s.parse::<usize>( ).unwrap( )).collect( ) ;
    let mut letters_entered : String = String::new( ) ;
    for c in letterstr.chars( ) {
       if c != ' ' {
	  letters_entered.push( c ) ;
       }
    }
    let single_letters = letters_entered.as_str( ) ;
    let mut pairs : Vec<(char,usize)> = single_letters.chars( ).zip( weights.into_iter( )).
       collect( ) ;
    let pair_slice = pairs.as_mut_slice( ) ;
    pair_slice.sort_by( | a , b | a.1.cmp( &b.1 )) ;
    let sorted_pairs : Vec<(char, usize)> = pair_slice.to_vec( ) ;
    let final_chars : Vec<char> = sorted_pairs.into_iter( ).map( | p | p.0 ).
       collect( ) ;
    let mut solution : String = String::new( ) ;
    for c in final_chars {
       solution.push( c ) ;
    }
    println!("{:?}" , solution ) ;
}
