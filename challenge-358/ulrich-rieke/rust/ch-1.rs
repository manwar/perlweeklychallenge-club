fn find_length( word : &str ) -> usize {
   if word.chars( ).all( |c| c.is_digit( 10 )) {
      word.parse::<usize>().unwrap( ) 
   }
   else {
      word.chars( ).count( ) 
   }
}

fn main() {
   use std::io ;
    println!("Enter some alphanumeric strings separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let strings : Vec<&str> = inline.trim_end( ).split_whitespace( ).collect( ) ;
    println!("{}" , strings.into_iter( ).map( |s| find_length( s )).max( ).unwrap( )) ;
}
