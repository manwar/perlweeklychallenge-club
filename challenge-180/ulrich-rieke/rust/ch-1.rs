use std::collections::HashMap ;
use std::collections::hash_map::Entry ;
use std::io ;

fn main() {
    let mut input = String::new( ) ;
    let mut frequencies: HashMap<char , i32> = HashMap::new( ) ;
    println!("Please enter a sentence!");
    io::stdin( ).read_line( &mut input).unwrap( ) ;
    let entered_line: &mut str = &mut input[..] ;
    for ch in entered_line.trim( ).chars( ) {
      //we count the characters
      *frequencies.entry( ch ).or_insert( 0 ) += 1 ;
    }
    //in find_pos we collect the positions where we find unique
    //characters. We initialize the vector with the length
    let mut find_pos: Vec<usize> = vec![entered_line.len( )] ;
    for ch in entered_line.trim( ).chars( ) {
      if let Entry::Occupied(o) = frequencies.entry( ch ) {
      let num = o.get( ) ;
      if *num == 1 {
        find_pos.push( entered_line.find( ch ).unwrap( ) ) ;
      }
      }
    }
    let minimum = find_pos.iter( ).reduce( |accum , item|
      if accum >= item { item } else { accum } ) ;
    match minimum {
      Some( a ) => println!("{}" , a ) ,
      None  => {}
    } ;
}
