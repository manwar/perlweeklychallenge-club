use std::io ;
use itertools::Itertools ;

fn concatenate_permu( numberstrings : Vec<String> ) -> i64 {
  let concatenated = numberstrings.into_iter( ).reduce( | akk , s |
    akk.to_owned( ) + &s ).unwrap( ) ;
  concatenated.as_str( ).parse::<i64>( ).unwrap( )
}

fn main() {
    println!("Please enter some numbers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numberstrings : Vec<String> = entered_line.split_whitespace( ).
      map ( | s | s.to_string( ) ).collect( ) ;
    let len = numberstrings.len( ) ;
    let mut all_numbers : Vec<i64> = Vec::new( ) ;
    for a_vec in numberstrings.into_iter().permutations( len ) {
      all_numbers.push( concatenate_permu( a_vec ) ) ;
    }
    println!("{}" , all_numbers.iter( ).max( ).unwrap( ) ) ;
}
