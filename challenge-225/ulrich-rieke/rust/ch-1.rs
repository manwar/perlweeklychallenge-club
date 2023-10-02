use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<( )> {
    println!("Enter some sentences, <return> to end!");
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    let mut all_input : String = String::new( ) ;
    while let Some( line ) = lines.next( ) {
      let last_input = line.unwrap( ) ;
      if last_input.len( ) == 0 {
      break ;
      }
      else {
      all_input.push_str("\n" ) ;
      }
      all_input.push_str( &last_input ) ;
    }
    let all_lines : Vec<&str> = all_input.split("\n").collect( ) ;
    let mut lengths : Vec<usize> = Vec::new( ) ;
    for sentence in all_lines {
      let words = sentence.split_whitespace( ).count( ) ;
      lengths.push( words ) ;
    }
    println!("{}" , lengths.iter( ).max( ).unwrap( ) ) ;
    Ok(())
}
