use std::io ;

fn change( numberstring : &str , letter : char ) -> String {
   let first_letter : char = numberstring.chars( ).nth( 0 ).unwrap( ) ;
   let second_letter : char = numberstring.chars( ).nth( 1 ).unwrap( ) ;
   let mut result : String = numberstring.into( ) ;
   if first_letter == letter && second_letter > first_letter {
      result.remove( 0 ) ;
   }
   else {
      match numberstring.rfind( |c| c == letter ) {
         Some( pos ) => {
            result.remove( pos ) ;
            result.clone( ) } ,
         None        => result.clone( ) 
      } ;
   }
   result 
}

fn main() {
    println!("Enter a numberstring!");
    let mut numberline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numberline ).unwrap( ) ;
    println!("Enter a character!" ) ;
    let mut charline : String = String::new( ) ;
    io::stdin( ).read_line( &mut charline ).unwrap( ) ;
    let letter : char = charline.trim( ).chars( ).nth( 0 ).unwrap( ) ;
    println!( "{:?}" , change( numberline.trim( ) , letter )) ;
}
