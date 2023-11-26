use std::io ;

//for theoretical reasons, the smallest divisor of a number must be 
//prime! It either is the smallest divisor, then it can't be subdivided
//further and therefore is prime, or it isn't the smallest

fn smallest_divisor( number : u32 ) -> u32 {
   let mut divisor : u32 = 2 ;
   while number % divisor != 0 {
      divisor += 1 ;
   }
   divisor
}

fn prime_decompose( mut number : u32 ) -> Vec<u32> {
   let mut prime_factors : Vec<u32> = Vec::new( ) ;
   while number != 1 {
      let divisor : u32 = smallest_divisor( number ) ;
      prime_factors.push( divisor ) ;
      number /= divisor ;
   }
   prime_factors 
}

fn main() {
    println!("Enter some unique positive integers greater than 2!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<u32> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ).parse::<u32>( ).unwrap( ) ).collect( ) ;
    let nums = numbers.as_mut_slice( ) ;
    nums.sort_unstable_by( |a , b| {
	  let factors_a : Vec<u32> = prime_decompose( *a ) ;
	  let factors_b : Vec<u32> = prime_decompose( *b ) ;
	  let len_a = factors_a.len( ) ;
	  let len_b = factors_b.len( ) ;
	  if len_a != len_b {
	    len_a.cmp( &len_b ) 
	  }
	  else {
	    a.cmp( &b )
	  }
    }) ;
    println!("{:?}" , nums ) ;
}
