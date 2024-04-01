use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>().unwrap( ) ).collect( ) ;
    let mut result : Vec<usize> = Vec::new( ) ;
    for i in &numbers {
       let num = numbers.iter( ).filter( |&x| *x < *i ).count( ) ;
       result.push( num ) ;
    }
    println!("{:?}" , result ) ;
}
