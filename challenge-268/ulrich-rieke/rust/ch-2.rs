use std::io ;

fn main() {
    println!("Enter an even number of integers , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.trim( ).
       split_whitespace( ). map( | s | s.parse::<i32>( ).unwrap( ) )
       .collect( ) ;
    let mut target : Vec<i32> = Vec::new( ) ;
    while numbers.len( ) > 0 {
       numbers.sort( ) ;
       let smallest : i32 = numbers.remove(0) ;
       let sec_smallest : i32 = numbers.remove( 0 ) ;
       target.push( sec_smallest ) ;
       target.push( smallest ) ;
    }
    println!("{:?}" , target ) ;
}
