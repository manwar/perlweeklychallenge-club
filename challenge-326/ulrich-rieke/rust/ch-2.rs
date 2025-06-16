use std::io ;

fn main() {
    println!("Enter an even amount of positive integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<u32>( ).unwrap( )).collect( ) ;
    let mut solution : Vec<u32> = Vec::new( ) ;
    let len : usize = numbers.len( ) ;
    let mut pos : usize = 0 ;
    while pos < len - 1 {
       let howmany : usize = numbers[pos] as usize ;
       let num : u32 = numbers[pos + 1] ;
       for _ in 0..howmany {
	  solution.push( num ) ;
       }
       pos += 2 ;
    }
    println!("{:?}" , solution ) ;
}
