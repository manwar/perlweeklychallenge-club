use std::io ;

fn digit_sum( mut number : u32 ) -> u32 {
   let mut sum : u32 = 0 ;
   while number != 0 {
      sum += number % 10 ;
      number /= 10 ;
   }
   sum 
}

fn main() {
    println!("Enter a string consisting of digits!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let mut count : u16 = 0 ;
    let mut all_sums : Vec<u32> = Vec::new( ) ;
    let mut payload : u32 = 0 ;
    let mut iter = entered_line.chars( ).rev( ) ;
    while let Some( c ) = iter.next( ) {
       if c.is_ascii_digit( ) {
	  let num : u32 = match c.to_digit( 10 ) {
	     Some( n ) => n ,
		None   => 0 
	  } ;
	  if count == 0 {
	     payload = num ;
	  }
	  else {
	     if count % 2 == 1 {
		let product : u32 = 2 * num ;
		if product < 10 {
		   all_sums.push( product ) ;
		}
		else {
		   let the_sum : u32 = digit_sum( product ) ;
		   all_sums.push( the_sum ) ;
		}
	     }
	     else {
		all_sums.push( num ) ;
	     }
	  }
	  count += 1 ;
       }
    }
    let total_sum : u32 = all_sums.into_iter( ).sum( ) ;
    println!("{}" , (total_sum + payload) % 10 == 0 ) ;
}
