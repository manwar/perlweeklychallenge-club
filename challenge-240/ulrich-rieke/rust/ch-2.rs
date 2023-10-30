use std::io ;

fn main() {
    println!("Enter some positive integers, separated by blanks!");
    println!("No integer should be greater than the length of array -1!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<u32>( ).unwrap( )).collect( ) ;
    let mut new_numbers : Vec<u32> = Vec::new( ) ;
    let len = numbers.len( ) ;
    for i in 0..len {
       let current : usize = numbers[ i ] as usize ;
       new_numbers.push( numbers[ current ] ) ;
    }
    println!("{:?}" , new_numbers ) ;
}
