use std::io ;

fn main() {
    println!("Enter a byte string consisting of 1 and 0 only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut valid_fields : Vec<&[u32]> = Vec::new( ) ;
    valid_fields.push( &[0] ) ;
    valid_fields.push( &[1 , 0] ) ;
    valid_fields.push( &[1 , 1] ) ;
    let the_fields = &valid_fields[..] ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let mut numbers : Vec<u32> = Vec::new( ) ;
    for c in entered_line.chars( ) {
      numbers.push( c.to_digit( 10 ).unwrap( ) ) ;
    }
    let int_slice = &numbers[..] ;
    let mut iter = int_slice.chunks( 2 ) ;
    let mut numberblocks : Vec<&[u32]> = Vec::new( ) ;
    while let Some( block ) = iter.next( ) {
      numberblocks.push( block ) ;
    }
    if numberblocks.iter( ).all( | n | the_fields.contains( &n ) ) {
      let last_element = numberblocks.iter( ).last( ) ;
      if last_element.unwrap( ) == &[0] || last_element.unwrap( ) == &[00] {
      println!("1") ;
      }
      else {
      println!("0") ;
      }
    }
    else {
      println!("0") ;
    }
}
