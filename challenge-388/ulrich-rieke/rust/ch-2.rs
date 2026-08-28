use std::io ;
use itertools::Itertools ;
use std::collections::HashSet ;

fn main() {
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let number : usize = inline.trim( ).parse::<usize>( ).unwrap( ) ;
    if number == 1 {
       println!("{}" , 0) ;
    }
    if number == 2 {
       println!("{}" , 1) ;
    }
    if number > 2 {
       //the task amounts to the following : take all the numbers from 1 
       //to number , pair them up with all the permutations of these numbers
       //and count the number of different pair collections where the first 
       //element of the pair is different from the second one
       let mut constellations : HashSet<Vec<(usize , usize)>> = HashSet::new( ) ;
       let mut givers : Vec<usize> = Vec::new( ) ;
       for i in 1usize..number + 1 {
          givers.push( i ) ;
       }
       let mut iter = (1..number + 1 ).permutations( number ) ;
       while let Some( perm ) = iter.next() {
          let mut pairs : Vec<(usize , usize)> = Vec::new( ) ;
          givers.iter( ).zip( perm.iter( ) ).for_each( |(f , s)|
                pairs.push( (*f , *s) ) ) ;
          if pairs.iter( ).all( |p| p.0 != p.1 ) {
             constellations.insert( pairs.clone( ) ) ;
          }
       }
       println!("{}" , constellations.len( ) ) ;
   }
}
