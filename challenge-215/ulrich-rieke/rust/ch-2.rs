use std::io ;

fn main() {
    println!("Enter 1 and 0 only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<usize> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<usize>( ).unwrap( )).collect( ) ;
    println!("How many 0's should be replaced ?") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    //the basic idea is : to replace n zeroes you have to have 3 zeroes in
    //a row if n is 1, 3 + ( number to replace ) otherwise
    let zerocount : usize = secondline.trim( ).parse::<usize>( ).unwrap( ) ;
    let necessary_row = match zerocount {
      0 => 0 ,
      1 => 3 ,
      _ => 3 + zerocount
    } ;
    let len = numbers.len( ) ;
    if len < necessary_row || len == necessary_row {
      println!("0") ;
    }
    else {
      let mut conditions : Vec<bool> = Vec::new( ) ;
      for i in 0..=(len - necessary_row) {
      let sub_slice = &numbers[i..i + necessary_row] ;
      let mut slice_iter = sub_slice.iter( ) ;
      conditions.push( slice_iter.all( | n | *n == 0 )) ;
      }
      if conditions.iter( ).any( | c | *c == true ) {
      println!("1") ;
      }
      else {
      println!("0") ;
      }
    }
}
