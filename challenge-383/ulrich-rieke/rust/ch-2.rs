use std::io ;
use std::collections::HashMap ;

fn round_rgb( color : &str , websafes : &HashMap<&str , u32> ) -> String { 
   let mut converted : String = String::new( ) ;
   converted.push( '#' ) ;
   let mut all_lower : String = String::new( ) ;
   for c in color.chars( ).skip( 1 ) {
      all_lower.push( c.to_ascii_lowercase( ) ) ;
   }
   let mut vals : Vec<&u32> = websafes.values( ).collect( ) ;
   let values_to_hex : HashMap<u32 , &str> = HashMap::from([(0 , "00") , 
         (51 , "33" ) , (102 , "66") , (153 , "99") , (204 , "CC") , 
         (255 , "FF")]) ;
   //we convert all_lower to decimal numbers in groups of two, 
   //that is one group for each color
   let mut letters : Vec<char> = Vec::new( ) ;
   for c in all_lower.chars( ) {
      letters.push( c ) ;
   }
   let letterslice = &letters[..] ;
   let colorparts : Vec<&[char]> = letterslice.chunks( 2 ).collect( ) ;
   for s in colorparts {
      let first_char : char = s[0] ;
      let second_char : char = s[1] ;
      let number : u32 = first_char.to_digit( 16 ).unwrap() * 16 +
         second_char.to_digit( 16 ).unwrap( ) ;
      //find the smallest absolute difference to the web safe values
      vals.sort_by_key( |k| k.abs_diff( number ) ) ;
      let smallest_diff : u32 = *vals[0] ;
      let hexstr : &str = values_to_hex.get( &smallest_diff).unwrap( ) ;
      converted.push_str( hexstr ) ;
   }
   let conv_s : String = converted.clone( ) ;
   converted.clear( ) ;
   let convi : &str = conv_s.as_str( ) ;
   for c in convi.chars( ) {
      converted.push( c.to_ascii_uppercase( ) ) ;
   }
   converted 
}

fn main() {
   println!("Enter a RGB color value!");
   let mut inline : String = String::new( ) ;
   io::stdin( ).read_line( &mut inline ).unwrap( ) ;
   let colorval : &str = inline.trim( ) ;
   let websafes : HashMap<&str , u32> = HashMap::from( [("00" , 0) , 
         ("33" , 51) , ("66" , 102) , ("99" , 153) , ("CC" , 204) ,
         ("FF" , 255)] ) ;
   let converted : String = round_rgb( colorval , &websafes ) ;
   println!("{:?}" , converted ) ;
}
