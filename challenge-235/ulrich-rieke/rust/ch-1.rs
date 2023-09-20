use std::io ;

fn main() {
    println!("Enter some integers, separated by spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut neighbours : Vec<(i32 , i32)> = Vec::new( ) ;
    for i in 0..=numbers.len( ) - 2 {
       let mut pair : (i32 , i32) = (0 , 0);
       pair.0 = numbers[i] ;
       let j : usize = i + 1 ;
       pair.1 = numbers[ j ] ;
       neighbours.push( pair ) ;
    }
    let len : usize = neighbours.len( ) ;
    if neighbours.iter( ).filter( | &p | p.1 > p.0 ).count( ) == len - 1 {
       println!("true") ;
    }
    else {
       println!("false") ;
    }
}
