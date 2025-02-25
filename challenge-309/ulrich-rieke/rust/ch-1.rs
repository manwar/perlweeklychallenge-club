use std::io ;

fn main() {
    println!("Enter some integers in ascending order separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut min_diff : i32 = numbers[1] - numbers[0] ;
    let mut gap_end : i32 = numbers[1] ;
    for n in 2..numbers.len( ) {
       let current_diff = numbers[n] - numbers[n - 1] ;
       if current_diff < min_diff {
	  min_diff = current_diff ;
	  gap_end = numbers[n] ;
       }
    }
    println!("{}" , gap_end) ;
}
