use std::io ;
use std::collections::HashMap ;

fn is_ascending( list : &Vec<usize> ) -> bool {
   let mut result : bool = true ;
   let len : usize = list.len( ) ;
   for pos in 0..len - 1 {
      if list[ pos + 1 ] - list[pos] != 1 {
	 result = false ;
	 break ;
      }
   }
   result 
}

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    println!("Enter another array which contains the same numbers!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let firstnums : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let secondnums : Vec<i32> = secondline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<i32>( ).unwrap( ) ). collect( ) ;
    if firstnums.len( ) == 1 && secondnums.len( ) == 1 {
       println!("true") ;
    }
    else {
    //we add up the positions of the numbers in the 2 arrays. If parts
    //of the lists are reversed the sum of their positions is identical.
    //We hash every sum with a list of their occurrences and see 
    //whether these lists are ascending
    let positions_found : Vec<(usize , usize)> = firstnums.into_iter( ).
       enumerate( ).map( |p| {
	     let found = secondnums.iter( ).position( |n| *n == p.1 )
	     .unwrap() ;
	     (p.0 , p.0 + found) 
	     }).collect( ) ;
    let mut sum_positions : HashMap<usize , Vec<usize>> = HashMap::new( ) ;
    for ( a , b ) in positions_found {
       sum_positions.entry( b ).and_modify( |v| v.push( a )).or_insert( 
	     vec![a] ) ;
    }
    println!("{}" , sum_positions.values( ).into_iter().filter( |v| {
	     v.len( ) > 1 && is_ascending( &v ) 
	     }).count( ) == 1 ) ;
    }
}
