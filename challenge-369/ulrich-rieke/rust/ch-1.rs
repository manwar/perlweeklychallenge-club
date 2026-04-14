use std::io ;

fn tag_string( line : &str ) -> String {
   let mut output : String = String::new( ) ;
   let words : Vec<&str> = line.split_whitespace( ).collect( ) ;
   output.push('#' ) ;
   words.iter( ).enumerate( ).map( |(p , w)| {
         let mut changed : String = String::new( ) ;
         let first : char = w.chars( ).nth( 0 ).unwrap( ) ;
         if p == 0 {
           if first.is_ascii_uppercase( ) {
             changed.insert( 0 , first.to_ascii_lowercase( ) ) ;
           }
           else {
             if first.is_ascii_lowercase( ) {
               changed.insert( 0 , first ) ;
            }
          }
        }
        else {
          if first.is_ascii_lowercase( ) {
             changed.insert( 0 , first.to_ascii_uppercase( )) ;
         }
         else {
            if first.is_ascii_uppercase( ) {
              changed.insert( 0 , first ) ;
            }
         }
       }
       for c in w.chars( ).skip( 1 ) {
         if c.is_ascii_alphabetic( ) {
            if c.is_ascii_uppercase( ) {
               changed.push( c.to_ascii_lowercase( ) ) ;
            }
            if c.is_ascii_lowercase( ) {
               changed.push( c ) ;
            }
         }
       }
       changed 
       }).for_each( |st| {
          let the_word = st.as_str( ) ;
          output.push_str( the_word ) ;
          }) ;
   let len : usize = output.len( ) ;
   if len > 100 {
      for _ in 100..len {
         output.remove( 100 ) ;
      }
   }
   output 
}
            
fn main() {
    println!("Enter a sentence!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let sentence : &str = inline.trim( ) ;
    println!( "{:?}" , tag_string( sentence ) ) ;
}
