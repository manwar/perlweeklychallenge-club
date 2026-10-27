use std::io ;
use std::cmp::Ordering ;

fn to_binary_reverse( mut number : i32 ) -> Vec<i32> {
   let mut binary : Vec<i32> = Vec::new( ) ;
   while number != 0 {
      binary.push( number % 2 ) ;
      number /= 2 ;
   }
   binary 
}

fn from_binary_reverse( binaries : &Vec<i32> ) -> i32 {
   let len : usize = binaries.len( ) ;
   let mut total : i32 = 0 ;
   for n in 0..len {
      total += binaries[n] * 2_i32.pow( (len - 1 - n) as u32) ;
   }
   total 
}

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<i32> = inline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>( ).unwrap( )).collect( ) ;
    numbers.sort_by( |a , b| {
          let rev1 : Vec<i32> = to_binary_reverse( *a ) ;
          let rev2 : Vec<i32> = to_binary_reverse( *b ) ;
          let first_num = from_binary_reverse( &rev1 ) ;
          let second_num = from_binary_reverse( &rev2 ) ;
          if first_num.cmp( &second_num ) != Ordering::Equal {
            first_num.cmp( &second_num ) 
          }
          else {
            a.cmp( &b ) 
          }
          } ) ;
    println!("{:?}" , numbers ) ;
}
