use std::io ;

fn main() {
    println!("Please enter a number of integers , separated by a blank!") ;
    println!("As last number, enter a divisor, another positive integer!" ) ;
    let mut input : String = String::new( ) ;
    io::stdin( ).read_line( &mut input ).unwrap( ) ;
    let mut numbers : Vec<i32> = Vec::new( ) ;
    let entered_line : &str = &*input ;
    let mut iter = entered_line.split_whitespace( ) ;
    while let Some( num ) = iter.next( ) {
      numbers.push( num.trim( ).parse::<i32>().unwrap( )) ;
    }
    let len = numbers.len( ) ;
    let divisor = numbers[ len - 1 ] ;
    let mut count = 0 ;
    for i in 0..=len - 3 {
      for j in i + 1..=len - 2 {
      if ( numbers[i] + numbers[j] ) % divisor == 0 {
        count += 1 ;
      }
      }
    }
    println!("{}" , count) ;
}
