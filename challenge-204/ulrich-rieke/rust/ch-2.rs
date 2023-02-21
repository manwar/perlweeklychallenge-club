use std::io ;
use std::io::{BufRead} ;

fn main() -> io::Result<( )> {
    println!("Enter some integers, separated by blanks!") ;
    println!("Lines should have equal numbers of integers!") ;
    println!("Then enter rows r and columns c , separated by blanks!" ) ;
    println!("Then enter end") ;
    let mut array : Vec<i32> = Vec::new( ) ;
    let mut lines = io::stdin().lock( ).lines( ) ;
    while let Some( line ) = lines.next( ) {
      let last_input = line.unwrap( ) ;
      if last_input != "end".to_string( ) {
      let entered_line : &str = &*last_input ;
      let numbers : Vec<i32> = entered_line.split_whitespace( ).
        map( | s | s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
      numbers.iter( ).for_each( | i | array.push( *i )) ;
      }
      else {
      break ;
      }
    }
    let mut len = array.len( ) ;
    let rows = array[len - 2 ] as usize ;
    let columns = array[ len - 1 ] as usize ;
    array.pop( ) ;
    array.pop( ) ;
    len = array.len( ) ;
    if len % ( rows * columns ) != 0  {
      println!("0") ;
    }
    else {
      print!("(" ) ;
      for i in 0..rows {
      print!("(") ;
      for j in i * columns..i * columns + columns {
        print!("{} " , array[j] ) ;
      }
      print!(")") ;
      }
      println!(")" ) ;
    }
    Ok(())
}
