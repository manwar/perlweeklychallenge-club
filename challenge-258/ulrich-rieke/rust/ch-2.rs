use std::io ;

fn main() {
    println!("Enter a number of integers, separated by spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Enter another integer!") ;
    let mut line : String = String::new( ) ;
    io::stdin( ).read_line( &mut line ).unwrap( ) ;
    let second_line : &str = &*line ;
    let number : u32 = second_line.trim( ).parse::<u32>( ).unwrap( ) ;
    let mut sum : i32 = 0 ;
    for i in 0..numbers.len( ) {
       if i.count_ones( ) == number {
	  sum += numbers[ i ] ;
       }
    }
    println!("{}" , sum ) ;
}
