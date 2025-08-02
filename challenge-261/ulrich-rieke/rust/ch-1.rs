use std::io ;

fn digitsum( num : i32 ) -> i32 {
   let mut sum : i32 = 0 ;
   let mut n : i32 = num ;
   while n != 0 {
      sum = sum + n % 10 ;
      n = n / 10 ;
   }
   sum 
}

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    let element_sum : i32 = numbers.iter( ).sum( ) ;
    let mut digit_sum : i32 = 0 ;
    numbers.iter( ).map( | d | {
	  let ds : i32 = digitsum( *d ) ;
	  ds 
	  }).for_each( | n | digit_sum += n ) ;
    println!("{}" , (element_sum - digit_sum).abs( ) ) ;
}
