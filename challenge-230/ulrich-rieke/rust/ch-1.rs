use std::io ;

fn decompose( mut number : u32 ) -> Vec<u32> {
   let mut digits : Vec<u32> = Vec::new( ) ;
   while number != 0 {
      digits.push( number % 10 ) ;
      number /= 10 ;
   }
   digits.reverse( ) ;
   digits 
}

fn main() {
    println!("Enter some positive integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<u32> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ).parse::<u32>( ).unwrap( ) ).collect( ) ;
    let mut digits : Vec<u32> = Vec::new( ) ;
    for i in numbers {
       let current_digits : Vec<u32> = decompose( i ) ;
       for n in current_digits {
	  digits.push( n ) ;
       }
    }
    println!("{:?}" , digits ) ;
}
