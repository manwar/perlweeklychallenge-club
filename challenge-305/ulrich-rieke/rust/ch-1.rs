use std::io ;

fn to_decimals( binaries : &Vec<u8> ) -> Vec<u32> {
   let mut decimals : Vec<u32> = vec![] ;
   let len : usize = binaries.len( ) ;
   let mut numberstring : String = String::new( ) ;
   for i in 0..len {
      let numstr : String = binaries[i].to_string( ) ;
      numberstring.push_str( &numstr ) ;
      let numberstr : &str = numberstring.as_str( ) ;
      let number : u32 = u32::from_str_radix( numberstr , 2 ).unwrap( ) ;
      decimals.push( number ) ;
   }
   decimals 
}

fn is_prime( number : u32 ) -> bool {
   let result : bool = match number {
      0 => false ,
      1 => false ,
      2 => true ,
      _ => {
	 let limit : u32 = (number as f32).sqrt( ).floor( ) as u32 ;
	 (2..=limit).all( |d| number % d != 0 ) 
      }
   } ;
   result 
}

fn main() {
    println!("Enter some 0 and 1 separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let binaries : Vec<u8> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u8>( ).unwrap( ) ).collect( ) ;
    let decimals : Vec<u32> = to_decimals( &binaries ) ;
    let mut truth_values : Vec<bool> = Vec::new( ) ;
    decimals.into_iter( ).map( |d| is_prime( d ) ).for_each( |v| 
	  truth_values.push( v ) ) ;
    println!("{:?}" , truth_values ) ;
}
