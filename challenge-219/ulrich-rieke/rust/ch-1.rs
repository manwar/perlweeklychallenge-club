use std::io ;

fn main() {
    println!("Enter some numbers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut squares : Vec<i32> = numbers.iter( ).map( | i | i.pow( 2 )).
      collect( ) ;
    squares.sort( ) ;
    println!("{:?}" , squares) ;
}
