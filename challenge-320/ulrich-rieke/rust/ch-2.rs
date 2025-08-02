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
    println!("Enter some positive integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let numbersum : u32 = numbers.iter( ).sum( ) ;
    let all_digit_sum : u32 = numbers.iter_mut( ).map( |s| digit_sum( *s ) )
       .sum( ) ;
    println!("{}" , (numbersum as i32).abs_diff( all_digit_sum as i32 ) ) ;
}
