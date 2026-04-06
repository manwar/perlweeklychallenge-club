use std::io ;

fn find_factors( mut number : u32 , mode : u8 ) -> usize {
   let mut divisor : u32 = 2 ;
   let mut prime_factors : Vec<u32> = Vec::new( ) ;
   while number != 1 {
      if number % divisor == 0 {
         prime_factors.push( divisor ) ;
         number /= divisor ;
      }
      else {
         divisor += 1 ;
      }
   }
   if mode == 0 {
      use std::collections::HashSet ;
      let mut unique_factors : HashSet<u32> = HashSet::new( ) ;
      prime_factors.into_iter( ).for_each( |n| { 
            unique_factors.insert( n ) ;
            }) ;
      unique_factors.len( )
   }
   else {
      prime_factors.len( ) 
   }
}

fn main() {
    println!("Enter a positive number!");
    let mut numberline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numberline ).unwrap( ) ;
    let number : u32 = numberline.trim( ).parse::<u32>().unwrap( ) ;
    println!("Enter a mode( 0 or 1 )!") ;
    let mut modeline : String = String::new( ) ;
    io::stdin( ).read_line( &mut modeline ).unwrap( ) ;
    let mode : u8 = modeline.trim( ).parse::<u8>( ).unwrap( ) ;
    println!( "{}" , find_factors( number , mode )) ;
}
