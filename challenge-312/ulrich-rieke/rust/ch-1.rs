use std::{io , cmp} ;
use std::collections::HashMap ;

fn main() {
    println!("Enter a string in English non-capital letters!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let trimmed = inline.trim( ) ;
    let mut letters : Vec<char> = Vec::new( ) ;
    for c in trimmed.chars( ) {
       letters.push( c ) ;
    }
    let letter_pos : Vec<(char , i32)> = ('a'..='z').into_iter( ).
       enumerate( ).map( |p| (p.1 , (p.0 + 1) as i32)).collect( ) ;
    let mut letterpositions : HashMap<char , i32> = HashMap::new( ) ; 
    letter_pos.into_iter( ).for_each( |p| {letterpositions.insert( p.0 , 
	     p.1) ; }) ;
    //the basic idea is to compute the minimum of either the differenc
    //of the letterpositions clockwise ( absolute difference ) or 
    //counterclockwise ( sum of the positions modulo 26 ). This difference
    //is calculated for every pair of letters in the string, in the end
    //we add the number of letters in the initial string to it!
    let mut seconds : u32 = 0 ;
    if ! trimmed.starts_with( "a" ) {
       let start : char = trimmed.chars( ).nth( 0 ).unwrap( ) ;
       let number : i32 = *letterpositions.get( &start ).unwrap( ) ;
       let onedir_diff : u32 = number.abs_diff( 1i32 ) ;
       let otherdir_diff : u32 = 26 - onedir_diff ;
       let diff : u32 = cmp::min( onedir_diff , otherdir_diff) ; 
       seconds += diff ;
    }
    let len = trimmed.chars( ).count( ) ;
    for i in 0..len - 1 {
       let firstchar : char = trimmed.chars( ).nth( i ).unwrap( ) ;
       let secondchar : char = trimmed.chars( ).nth( i + 1 ).unwrap( ) ;
       let firstnum : i32 = *letterpositions.get( &firstchar ).unwrap( ) ;
       let secondnum : i32 = *letterpositions.get( &secondchar ).unwrap( ) ;
       let onedir_diff : u32 = firstnum.abs_diff( secondnum ) ;
       let otherdir_diff : u32 = 26 - onedir_diff ;
       let diff : u32 = cmp::min( onedir_diff , otherdir_diff ) ;
       seconds += diff ;
    }
    seconds += len as u32 ;
    println!("{}" , seconds ) ;
}
