use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    numbers.sort( ) ;
    let len = numbers.len( ) ;
    let mut lengths : Vec<usize> = Vec::new( ) ;
    let mut i : usize = 1 ;
    let mut run : usize = 1 ;
    while i < len {
       if numbers[i] - numbers[i - 1] == 1 {
	  run += 1 ;
       }
       else {
	  lengths.push( run ) ;
	  run = 1 ;
       }
       i += 1 ;
    }
    lengths.push( run ) ;
    let maxlen : usize = lengths.into_iter( ).max( ).unwrap( ) ;
    if maxlen == 1 {
       println!("-1") ;
    }
    else {
       println!("{maxlen}") ;
    }
}

