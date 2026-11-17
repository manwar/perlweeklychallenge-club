use std::io ;
use std::collections::HashSet ;

fn is_repeating( mut number : u32 ) -> bool {
   let result : bool = number > 9 && {
      let mut digits : Vec<u32> = Vec::new( ) ;
      let mut uniques : HashSet<u32> = HashSet::new( ) ;
      while number != 0 {
         digits.push( number % 10 ) ;
         uniques.insert( number % 10 ) ;
         number /= 10 ;
      }
      uniques.len( ) != digits.len( )
   } ;
   result 
}

fn main() {
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let number : u32 = inline.trim( ).parse::<u32>().unwrap( ) ;
    let mut all_numbers : Vec<u32> = Vec::new( ) ;
    for i in 1..=number {
       all_numbers.push( i ) ;
    }
    let selected : Vec<u32> = all_numbers.into_iter( ).filter( |&n|
          ! is_repeating( n ) ).collect( ) ;
    let mut maxi : u32 = 0 ;
    for i in 1..selected.len( ) {
       let diff : u32 = selected[i ] - selected[ i - 1] ;
       if diff > maxi {
          maxi = diff ;
       }
    }
    println!("{}" , maxi ) ;
}
