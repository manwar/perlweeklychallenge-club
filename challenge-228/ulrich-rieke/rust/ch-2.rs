use std::io ;

fn main() {
    println!("Enter some unique integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut rounds : usize = 0 ;
    while numbers.len( ) > 0 {
       let mini : i32 = *numbers.iter( ).min( ).unwrap( ) ;
       let pos : usize = numbers.iter( ).position( | d | *d == mini ).unwrap( ) ;
       let i : i32 = numbers.remove( 0 ) ;
       if pos == 0 {
       }
       else {
	  numbers.push( i ) ;
       }
       rounds += 1 ;
    }
    println!("{}" , rounds ) ;
}
