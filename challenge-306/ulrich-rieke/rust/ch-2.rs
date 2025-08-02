use std::io ;

fn main() {
    println!("Enter some positive integers separated by whitespace!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    while numbers.len( ) > 1 {
       numbers.sort( ) ;
       let len = numbers.len( ) ;
       if numbers[len - 2] == numbers[ len - 1] {
	  numbers.pop( ) ;
	  numbers.pop( ) ;
       }
       else {
	  numbers[len - 1] = numbers[len - 1] - numbers[len - 2] ;
	  numbers.remove( len - 2 ) ;
       }
    }
    if numbers.len( ) == 1 {
       println!("{}" , numbers[0] ) ;
    }
    else {
       println!("0") ;
    }
}
