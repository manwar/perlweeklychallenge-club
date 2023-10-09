use std::io ;
use std::cmp::Ordering ;

fn decompose( number : u32 ) -> Vec<u32> {
   let mut digits : Vec<u32> = Vec::new( ) ;
   let mut num : u32 = number ;
   while num != 0 {
      let remainder = num % 10 ;
      digits.push( remainder ) ;
      num /= 10 ;
   }
   digits 
}

fn find_steps( number : u32 ) -> usize {
   if number < 10 {
      0
   }
   else {
      let mut digits : Vec<u32> = decompose( number ) ;
      let mut steps : usize = 1 ;
      let mut prod : u32 = digits.iter( ).product::<u32>( ) ;
      while prod > 9 {
	 steps += 1 ;
	 digits = decompose( prod ) ;
	 prod = digits.iter( ).product::<u32>() ;
      }
      steps 
   }
}

fn main() {
    println!("Enter some positive integers , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<u32>().unwrap( )).collect( ) ;
    let nums = numbers.as_mut_slice( ) ;
    nums.sort_by( |a , b| {
	  let s1 : usize = find_steps( *a ) ;
	  let s2 : usize = find_steps( *b ) ;
	  let my_ord : Ordering = s1.cmp(&s2) ;
	  if my_ord != Ordering::Equal {
	    my_ord 
	  }
	  else {
	    a.cmp( b ) 
	  }
    }) ;
    println!("{:?}" , nums ) ;
}
