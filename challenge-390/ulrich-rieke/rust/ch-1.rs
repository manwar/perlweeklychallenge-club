use regex::{Captures , Regex} ;
use std::io ;

fn main() {
    println!("Enter a term!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let input : &str = inline.trim( ) ;
    let inner = Regex::new( r"(\d+)\[([a-z])\]").unwrap( ) ;
    let oldnew = inner.replace_all( input  , |caps : &Captures| { 
          let multiply : &str = &caps.get(1).map_or("" , |m| m.as_str( )) ;
          let multiplier : usize = multiply.parse::<usize>().unwrap( ) ;
           let letter : &str = &caps.get(2).map_or( "" , |m| m.as_str( )) ;
           let mut replacement : String = String::new( ) ;
           for _ in 0..multiplier {
                replacement.push_str( letter ) ;
               }
               replacement
        }) ;
    let outer = Regex::new( r"(\d+)\[([a-z]{2,})\]" ).unwrap( ) ;
    let new = outer.replace_all( &oldnew , |caps: &Captures| { 
           let multiply : &str = &caps.get(1).map_or( "" , |m| m.as_str( )) ;
           let multiplier : usize = multiply.parse::<usize>( ).unwrap( ) ;
           let inword : &str = &caps.get(2).map_or( "" , |m| m.as_str( )) ;
           let mut replacement : String = String::new( ) ;
           for _ in 0..multiplier {
             replacement.push_str( inword ) ;
           }
           replacement 
      }) ;
    println!("{:?}" , new ) ;
}
