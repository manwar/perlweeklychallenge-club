use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.trim( ).split_whitespace( ).
       map( | s | s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    //the bitwise or of 2 numbers ends in a 0 in its binary representation
    //if they are both even. So the question amounts to checking whether
    //there are at least 2 even numbers in the array
    let result : bool = numbers.into_iter( ).filter( | n | n % 2 == 0 )
       .count( ) >= 2 ;
    println!("{}" , result ) ;
}
