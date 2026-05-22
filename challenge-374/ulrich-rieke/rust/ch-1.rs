use std::io ;
use std::collections::HashSet ;

fn condition( word : &str ) -> bool {
   let vowels = HashSet::from( ['a' , 'e' , 'i' , 'o' , 'u'] ) ;
   let mut uniques : HashSet<char> = HashSet::new( ) ;
   for c in word.chars( ) {
      uniques.insert( c ) ;
   }
   uniques == vowels 
}

fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let len = inline.trim( ).chars( ).count( ) ;
    let trimmed : &str = inline.trim( ) ;
    let mut changed : String = String::new( ) ;
    for c in trimmed.chars( ) {
       changed.push( c ) ;
    }
    let mut solution : Vec<&str> = Vec::new( ) ;
    if len == 5 {
       if condition( trimmed ) {
          solution.push( trimmed ) ;
       }
    }
    if len > 5 {   
       for start in 0..len - 4 {
          for end in start + 5 .. len + 1 {
             let substring : &str = &changed[start..end] ;
             if condition( substring ) {
                solution.push( substring ) ;
             }
          }
       }
    }
    println!("{:?}" , solution ) ;
}
