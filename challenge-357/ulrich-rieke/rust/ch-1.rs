/*the following function creates a pair of 2 four-digit numbers , one with
  ascending and the other with descending digits */
fn create_pair( mut number : i32 ) -> (i32 , i32) {
   let mut digits : Vec<i32> = Vec::new( ) ;
   let rising : Vec<i32> ;
   let mut falling : Vec<i32> = Vec::new( ) ;
   while number != 0 {
      digits.push( number % 10 ) ;
      number /= 10 ;
   }
   let first_digit : i32 = digits[0] ;
   if digits.iter( ).all( |n| *n == first_digit ) {
      (-1 , -1)
   }
   else {
      while digits.len( ) < 4 {
         digits.push( 0 ) ;
      }
      digits.sort( ) ;
      rising = digits ;
      let mut iter = rising.iter( ).rev( ) ;
      while let Some( n ) = iter.next( ) {
         falling.push( *n ) ;
      }
      let rise_number = rising[0] * 1000 + rising[1] * 100 + rising[2] * 10
         + rising[3] ;
      let fall_number = falling[0] * 1000 + falling[1] * 100 + falling[2] * 10 
         + falling[3] ;
      (fall_number , rise_number)
   }
}

fn main() {
    use std::io ;
    println!("Enter a 4-digit-integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut number : i32 = inline.trim_end( ).parse::<i32>( ).unwrap( ) ;
    let pair : (i32 , i32 ) = create_pair( number ) ;
    if pair.0 == -1 {
       println!("-1" ) ;
    }
    else {
       let mut count : usize = 0 ;
       while number != 6174 {
          let pair : (i32 , i32) = create_pair( number ) ;
          count += 1 ;
          number = pair.0 - pair.1 ;
       }
       println!("{}" , count ) ;
    }
}
