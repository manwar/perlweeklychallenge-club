use std::io ;

fn main() {
    println!("Enter some integers, separated by a blank!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<usize> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<usize>( ).expect("Could not parse number"))
      .collect( ) ;
    let mut possible_h : Vec<usize> = Vec::new( ) ;
    numbers.sort( ) ;
    let mut reverse_order : Vec<usize> = Vec::new( ) ;
    let mut rev_iter = numbers.iter( ).rev( ) ;
    while let Some( n ) = rev_iter.next( ) {
      reverse_order.push( *n ) ;
    }
    for i in 0..reverse_order.len( ) {
      if reverse_order[i] >= (i + 1 ) {
      possible_h.push( i + 1 ) ;
      }
    }
    println!("{}" , possible_h.iter( ).max( ).unwrap( ) ) ;
}
