use std::io ;

fn main() {
    println!("Please input some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut differences : Vec<i32> = Vec::new( ) ;
    let len = numbers.len( ) ;
    for i in 0..len - 1 {
      differences.push( numbers[i + 1 ] - numbers[ i ] ) ;
    }
    if differences.iter( ).all( | d | d <= &0 ) || differences.iter( ).
      all( | d | d >= &0 ) {
      println!("1") ;
    }
    else {
      println!("0") ;
    }
}
