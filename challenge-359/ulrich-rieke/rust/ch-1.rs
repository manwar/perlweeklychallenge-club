fn create_pair( number : u32 ) -> (usize, u32 ) {
   if number < 10 {
      (0 , number ) 
   }
   else {
      let mut root : u32 = number ;
      let mut persistence : usize = 0 ;
      while root > 9 {
         let mut digits : Vec<u32> = Vec::new( ) ;
         while root != 0 {
            digits.push( root % 10 ) ;
            root /= 10 ;
         }
         persistence += 1 ;
         root = digits.into_iter( ).sum( ) ;
      }
      (persistence , root )
   }
}

fn main() {
   use std::io ;
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let number : u32 = inline.trim_end( ).parse::<u32>( ).unwrap( ) ;
    let (persistence , root ) : ( usize , u32 ) = create_pair( number ) ;
    println!("Persistence  = {}" , persistence) ;
    println!("Digital root = {}" , root) ;
}
