use std::io ;

fn fibonacci(number : u16 ) -> u16 {
   let result : u16 = match number {
      0 => 0 , 
      1 => 1 ,
      _ => fibonacci( number - 2 ) + fibonacci( number - 1 ) 
   } ;
   result
}

fn main() {
    println!("Enter an integer smaller than or equal 100!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut number : u16 = inline.trim_end( ).parse::<u16>().unwrap( ) ;
    //we have to go up to fibonacci( 12 ) to account for all numbers up to 100!
    let mut fibonaccis : Vec<u16> = Vec::new( ) ;
    for n in 0u16..=12 {
       fibonaccis.push( fibonacci( n ) ) ;
    }
    let mut solution : Vec<u16> = Vec::new( ) ;
    let mut pos : usize = fibonaccis.iter( ).rposition( |n| *n <= number ).unwrap( ) ;
    solution.push( fibonaccis[pos] ) ;
    number -= solution[ solution.len( ) - 1] ;
    while number != 0 {
       pos = fibonaccis.iter().rposition( |n| *n <= number ).unwrap( ) ;
       solution.push( fibonaccis[pos] ) ;
       number -= solution[ solution.len( ) - 1] ;
    }
    println!("{:?}" , solution ) ;
}
