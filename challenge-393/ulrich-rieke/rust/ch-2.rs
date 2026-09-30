use std::{io , cmp} ;

fn is_prime( number : u32 ) -> bool {
   let is_prime : bool = match number {
      0 => false , 
      1 => false ,
      2 => true , 
      _ => {
         let root : u32 = (number as f32).sqrt( ).floor( ) as u32 ;
         (2..=root).all( |n| number % n != 0 )
      }
   } ;
   is_prime 
}

fn main() {
    println!("Enter a word consisting of English alphabetic characters!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered : &str = inline.trim( ) ;
    let mut sum : u32 = 0 ;
    for c in entered.chars( ) {
       sum += c as u32 ;
    }
    if is_prime( sum ) {
       println!("0") ;
    }
    else {
       let upper_prime : u32 = {
          let mut current : u32 = sum + 1 ;
          while ! is_prime( current ) {
             current += 1 ;
          }
          current
       } ;
       let lower_prime : u32 = {
          let mut current : u32 = sum - 1 ;
          while ! is_prime( current ) {
             current -= 1 ;
          }
          current 
       } ;
       println!("{}" , cmp::min( upper_prime - sum , sum - lower_prime)) ;
    }
}
