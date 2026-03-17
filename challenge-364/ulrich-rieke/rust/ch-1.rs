use std::collections::HashMap ;

fn solution( input : &str , conversions : &HashMap<String, String>)
   -> String {
      let mut decrypted : String = input.into( ) ;
      while decrypted.as_str( ).find( "#" ).is_some( ) {
         let current : &str = decrypted.as_str( ) ;
         let pos : usize = current.chars( ).position( |c| c == '#' ).unwrap( ) ;
         let to_be_replaced : &String = &decrypted[pos - 2..pos + 1].to_owned();
         let replacement : String = conversions.get( to_be_replaced ).unwrap( ).
            to_string( );
         for _ in 0..3 {
            decrypted.remove( pos - 2 ) ;
         }
         let repstr : &str = replacement.as_str( ) ;
         decrypted.insert_str( pos - 2 , repstr ) ;
      }
      while decrypted.as_str( ).find( |c : char| c.is_digit( 10 ) ).is_some( ) {
         let current : &str = decrypted.as_str( ) ;
         let pos : usize = current.chars().position( |c| c.is_digit( 10 ) ).unwrap( ) ;
         let to_be_replaced : String = decrypted[pos..pos + 1].to_owned( ) ;
         let replacement : String = conversions.get( &to_be_replaced).unwrap( ).
            to_string( );
         decrypted.remove( pos ) ;
         let repstr : &str = replacement.as_str( ) ;
         decrypted.insert_str( pos , repstr ) ;
      }
   decrypted
}

fn main() {
   let lower_letters : &str = "abcdefghi" ;
   let upper_letters : &str = "jklmnopqrstuvwxyz" ;
   let mut conversions : HashMap<String , String> = HashMap::new( ) ;
   for i in 1_usize..10 {
      let numstri : String = i.to_string( ) ;
      let letter : char = lower_letters.chars( ).nth( i - 1 ).unwrap( ) ;
      let mut st : String = String::new( ) ;
      st.push( letter ) ;
      conversions.insert( numstri.clone( ), st.clone( ) ) ;
   }
   for i in 10_usize..27 {
      let mut string : String = i.to_string( ) ;
      string.push( '#' ) ;
      let letter : char = upper_letters.chars( ).nth( i - 10 ).unwrap( ) ;
      let mut st : String = String::new( ) ;
      st.push( letter ) ;
      conversions.insert( string.clone( ) , st.clone( )) ;
   }
   println!("{}" , solution( "10#11#12" , &conversions)) ;
   println!("{}" , solution( "1326#" , &conversions )) ;
   println!("{}" , solution( "25#24#123" , &conversions )) ;
   println!("{}" , solution( "20#5" , &conversions ) ) ;
   println!("{}" , solution( "1910#26#" , &conversions )) ;
}
