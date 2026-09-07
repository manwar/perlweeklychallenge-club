use std::io ;
use std::collections::HashMap ;

fn conversion_map( ) -> HashMap<char , u32> {
   let mut conversions : HashMap<u32 , char> = HashMap::new( ) ;
   let mut numstring : String ;
   for i in 0u32..10 {
      numstring = i.to_string( ) ;
      let numstr : &str = &numstring[0..1] ;
      conversions.insert( i , numstr.chars( ).nth( 0 ).unwrap( ) ) ;
   }
   for i in 10u32..37 {
      conversions.insert( i , char::from_u32( i + 55 ).expect( "Could 
               not convert!")) ;
   }
   for i in 37..64 {
      conversions.insert( i , char::from_u32( i + 61 ).expect( "Could
               not convert!")) ;
   }
   conversions.insert( 64 , '+' ) ;
   conversions.insert( 65 , '/' ) ;
   let mut result : HashMap<char , u32> = HashMap::new( ) ;
   conversions.into_iter( ).map( |(k , v)| (v , k) ).for_each( |(k , v)| {
         result.insert( k, v ) ;
         }) ;
   result 
}

fn convert( numberstring : &str , base : u32 , conversions : &HashMap<char ,
      u32> ) -> u32 {
   let mut converted : u32 = 0 ;
   let mut multiplier : u32 = 1 ;
   for c in numberstring.chars( ).rev( ) {
      let factor : u32 = multiplier * conversions.get( &c ).unwrap( ) ;
      converted += factor ;
      multiplier *= base ;
   }
   converted 
}

fn main() {
    println!("Enter a number string in a given base!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    println!("Enter a base!" ) ;
    let mut baseline : String = String::new( ) ;
    io::stdin( ).read_line( &mut baseline ).unwrap( ) ;
    let numberstring : &str = inline.trim( ) ;
    let base : u32 = baseline.trim( ).parse::<u32>().unwrap( ) ;
    let conversions : HashMap<char , u32> = conversion_map( ) ;
    println!("{}" , convert( numberstring , base , &conversions )) ;
}
