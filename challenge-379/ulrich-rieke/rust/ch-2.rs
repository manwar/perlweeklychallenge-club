use std::io ;

//the given numbers are numbers in radix 10. Convert them to a number in
//the given base and see whether all digits in that base , to the power
//of the number of digits , equal the original number in base 10

fn is_armstrong( mut number : u32 , base : u32 ) -> bool {
   let mut digits : Vec<u32> = Vec::new( ) ;
   let comparison : u32 = number ;
   while number != 0 {
      digits.push( number % base ) ;
      number /= base ;
   }
   if digits.iter( ).any( |n| *n > 9 ) {
      false
   }
   else {
      let len = digits.len( ) ;
      digits.into_iter( ).map( |n| n.pow( len as u32 ) ).sum::<u32>( ) ==
         comparison 
   }
}


fn main() {
    println!("Enter 2 numbers , marking a base and a limit!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( |st|
          st.parse::<u32>( ).unwrap( )).collect( ) ;
    let mut solution : Vec<u32> = Vec::new( ) ;
    //all numbers from 0 to base - 1 are , by definition, Armstrong numbers!
    let base : u32 = numbers[0] ;
    let limit : u32 = numbers[1] ;
    for i in 0..base {
       solution.push( i ) ;
    }
    for i in base..limit {
       if is_armstrong( i , base ) {
          solution.push( i ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
