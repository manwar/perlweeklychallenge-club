use std::io ;

fn digitsum( some_chunk : &[char] ) -> u32 {
   let mut sum : u32 = 0 ;
   for pos in 0..some_chunk.len( ) {
      let current_char : char = some_chunk[pos] ;
      let current_digit : u32 = current_char.to_digit( 10 ).unwrap( ) ;
      sum += current_digit ;
   }
   sum 
}

fn main() {
    println!("Enter a string consisting of digits only!");
    let mut digitline : String = String::new( ) ;
    io::stdin( ).read_line( &mut digitline ).unwrap( ) ;
    println!("Enter a number that is shorter than the length of the string!") ;
    let mut numberline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numberline ).unwrap( ) ;
    let trimmed = digitline.trim( ) ;
    let mut letters : Vec<char> = Vec::new( ) ;
    for c in trimmed.chars( ) {
       letters.push( c ) ;
    }
    let bignumber = &letters[..] ;
    let chunksize : usize = numberline.trim( ).parse::<usize>( ).unwrap( ) ;
    let mut iter = bignumber.chunks( chunksize ) ;
    let mut sum_numberstring : String = String::new( ) ;
    while let Some( part ) = iter.next( ) {
       let sum_of_digits : u32 = digitsum( part ) ;
       let sum_part = sum_of_digits.to_string( ) ;
       sum_numberstring.push_str( &sum_part ) ;
    }
    while sum_numberstring.len( ) > chunksize {
       let sum_slice = &sum_numberstring[..] ;
       let mut new_letters : Vec<char> = Vec::new( ) ;
       for c in sum_slice.chars( ) {
	  new_letters.push( c ) ;
       }
       let num_slice = &new_letters[..] ;
       let mut slice_iter = num_slice.chunks( chunksize ) ;
       sum_numberstring.clear( ) ;
       while let Some( part ) = slice_iter.next( ) {
	  let sum_of_digits : u32 = digitsum( part ) ;
	  let sum_part = sum_of_digits.to_string( ) ;
	  sum_numberstring.push_str( &sum_part ) ;
       }
    }
    println!("{:?}" , sum_numberstring ) ;
}
