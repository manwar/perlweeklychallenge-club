use std::io ;

fn to_binary_string( date : &str ) -> String {
   let mut binary : String = String::new( ) ;
   let mut date_num : usize = date.parse::<usize>( ).unwrap( ) ;
   while date_num != 0 {
      if date_num % 2 == 1 {
	 binary.insert_str( 0 , "1" ) ;
      }
      else {
	 binary.insert_str( 0 , "0" ) ;
      }
      date_num /= 2 ;
   }
   binary
}

fn main() {
    println!("Enter a date as year-month-day!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let parts : Vec<&str> = inline.trim( ).split( "-" ).collect( ) ;
    let mut result : String = String::new( ) ;
    parts.into_iter( ).map( |s| to_binary_string( s ) ).for_each( |date| {
	  result += &date[..] ;
	  result.push( '-' ) ;
	  } ) ;
    result.pop( ) ;
    println!("{:?}" , result ) ;
}
