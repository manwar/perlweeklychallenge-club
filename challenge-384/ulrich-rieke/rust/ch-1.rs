use std::io ;
use std::collections::HashMap ;

fn convert( mut number : u32 , base : u32 ) -> String {
   let mut converted : String = String::new( ) ;
   let mut table : HashMap<u32 , char> = HashMap::new( ) ;
   let mut numstring : String  ;
   for i in 0u32..10 {
       numstring = i.to_string( ) ;
       let numst : &str = &numstring[0..1] ;
       table.insert( i , numst.chars( ).nth(0).unwrap( ) ) ;
   }
   for i in 10u32..37 {
      table.insert( i , char::from_u32(i + 55).expect("Could not convert!")) ;
   }
   for i in 37..64 {
      table.insert( i , char::from_u32(i + 61).expect("Could not convert!") ) ;
   }
   table.insert( 64 , '+' ) ;
   table.insert( 65 , '/' ) ;
   while number != 0 {
      let found : char = *table.get(&(number % base)).unwrap( ) ;
      converted.push( found ) ;
      number /= base ;
   }
   let mut result : String = String::new( ) ;
   for c in converted.as_str( ).chars().rev( ) {
      result.push( c ) ;
   }
   result 
}

fn main() {
    println!("Enter a number and a base!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( |s|
          s.parse::<u32>().unwrap( )).collect( ) ;
    let number : u32 = numbers[0] ;
    let base : u32 = numbers[1] ;
    println!("{}" , convert( number , base )) ;
}
