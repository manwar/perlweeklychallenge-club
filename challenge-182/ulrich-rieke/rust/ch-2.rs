use std::io ;
use std::io::prelude::* ;
use std::io::BufReader ;
use std::fs::File ;

fn main() -> io::Result<()> {
  let mut strings : Vec<String> = Vec::new( ) ;
  let f = File::open( "inputfiles.txt" )? ;
  let reader = BufReader::new( f ) ;
  for line in reader.lines( ) {
      strings.push( line.unwrap( ) ) ;
  }
  let compare_to = strings[ 0 ].clone( ) ;
  let mut characters : Vec<char> = Vec::new( ) ;
  let mut common_path : String = String::from( "" ) ;
  for i in 0..= compare_to.len( ) - 1 {
      characters.clear( ) ;
      let comp = compare_to.chars( ).nth( i ).unwrap( ) ;
      for s in &strings[1 .. strings.len()] {
    let c = s.chars( ).nth( i ).unwrap( ) ;
    characters.push( c ) ;
      }
      let concordant = characters.iter( ).filter( |x| **x == comp ).count( ) ;
      if concordant == strings.len( ) - 1 {
    common_path.push( comp ) ;
      }
      else {
    break ;
      }
  }
  println!("{}" , common_path ) ;
  Ok(())
}
