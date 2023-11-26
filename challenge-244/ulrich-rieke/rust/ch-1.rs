use std::io ;

fn my_condition( numbers : &Vec<i32> , index : usize ) -> usize {
   numbers.iter( ).filter( | &n | *n < numbers[ index ] ).count( ) 
}

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut counts : Vec<usize> = Vec::new( ) ;
    let len = numbers.len( ) ;
    for i in 0..len {
       let num : usize = my_condition( &numbers , i ) ;
       counts.push( num ) ;
    }
    println!("{:?}" , counts ) ;
}
