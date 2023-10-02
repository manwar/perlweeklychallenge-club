use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Please enter a source string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let source : &str = &*inline ;
    println!("Enter a target string!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let target : &str = &*secondline ;
    let mut target_map = HashMap::new( ) ;
    let mut source_map = HashMap::new( ) ;
    for c in source.chars( ) {
      let value : &mut u32 = source_map.entry( c ).or_default( ) ;
      *value += 1 ;
    }
    for c in target.chars( ) {
      let value : &mut u32 = target_map.entry( c ).or_default( ) ;
      *value += 1 ;
    }
    if target.chars( ).all( | c | source_map.get( & c ).is_some( ) &&
      source_map.get( &c ).unwrap( ) >= target_map.get( &c ).unwrap( ) ) {
      println!("true") ;
    }
    else {
      println!("false") ;
    }
}
