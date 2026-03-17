use std::io ;

fn convert( word : &str ) -> u32 {
   let mut correlations : Vec<u32> = Vec::new( ) ;
   for c in word.chars( ) {
      let numberval : u32 = (c as u32) - 96 ;
      correlations.push( numberval) ;
   }
   let mut numberstring : String = String::new( ) ;
   correlations.into_iter( ).map( |n: u32| {
         let numstri : String = n.to_string( ) ;
         numstri 
         }).for_each( |s| numberstring.push_str( s.as_str( ) ) ) ;
   let mut total : u32 = 0 ;
   for c in numberstring.chars( ) {
      total += c.to_digit( 10 ).unwrap( ) ;
   }
   total 
}

fn find_digit_sum( mut number : u32 ) -> u32 {
   let mut digits : Vec<u32> = Vec::new( ) ;
   while number != 0 {
      digits.push( number % 10 ) ;
      number /= 10 ;
   }
   digits.into_iter( ).sum( )
}

fn main() {
    println!("Enter a word consisting of lowercase English letters!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim( ) ;
    println!("Enter a positive integer!") ;
    let mut numline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numline ).unwrap( ) ;
    let mut number : u32 = numline.trim( ).parse::<u32>( ).unwrap( ) ;
    let mut result : u32 = convert( word ) ;
    result = find_digit_sum( result ) ;
    number -= 1 ;
    while number != 0 {
       result = find_digit_sum( result ) ;
       number -= 1 ;
    }
    println!("{}" , result ) ;
}
