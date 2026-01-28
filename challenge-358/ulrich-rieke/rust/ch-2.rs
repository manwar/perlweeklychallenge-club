/*function convert simply imitates what elsewhere , as in Perl or Haskell , would
  be ord ; it creates pairings of alphabetic characters to the ASCII table and
  thus allows mappings*/

fn convert( input : &str , shift : u8 ) -> String {
   use std::collections::HashMap ;
   let mut lettercodes : HashMap<char , u8> = HashMap::new( ) ;
   let mut numbercodes : HashMap<u8 , char> = HashMap::new( ) ; //antipairs in Raku!!
   let mut numbercode = 65 ;
   for c in 'A'..='Z' {
      lettercodes.entry(c).insert_entry( numbercode ) ;
      numbercode += 1 ;
   }
   numbercode = 97 ;
   for c in 'a'..='z' {
      lettercodes.entry( c ).insert_entry( numbercode ) ;
      numbercode += 1 ;
   }
   lettercodes.iter( ).map( |(k , v)| (v , k ) ).for_each( |p|{
         numbercodes.entry( *p.0 ).insert_entry( *p.1) ;
         }) ;
   let mut converted : String = String::new( ) ;
   for c in input.chars( ) {
      let mut replaced : char = c ;
      let char_num : u8 = *lettercodes.get( &c ).unwrap( ) ;
      let new_num : u8 = char_num + shift ;
      if (new_num > 64 && new_num < 91) || ( new_num > 96 && new_num < 123 ) {
         replaced = *numbercodes.get( & new_num ).unwrap( ) ;
      }
      else {
         if new_num > 90 && new_num < 97 {
            replaced = *numbercodes.get( & ((new_num % 91 ) + 65 )).unwrap( ) ;
         }
         if new_num > 122 {
            replaced = *numbercodes.get( & ((new_num % 123 ) + 97 )).unwrap( ) ;
         }
      }
      converted.push( replaced ) ;
   }
   converted 
}

fn main() {
   use std::io ;
   println!("Enter a word consisting of ASCII letters only!") ;
   let mut inline : String = String::new( ) ;
   io::stdin( ).read_line( &mut inline ).unwrap( ) ;
   let word : &str = inline.trim_end( ) ;
   println!("Enter a positive integer!") ;
   let mut numberline : String = String::new( ) ;
   io::stdin( ).read_line( &mut numberline ).unwrap( ) ;
   let number : u8 = numberline.trim_end( ).parse::<u8>( ).unwrap( ) ;
   let converted : String = convert( word , number ) ;
   println!("{:?}" , converted ) ;
}
