use std::io ;

fn is_palindrome( number : i32 ) -> bool {
   let target : String = number.to_string( ) ;
   let mut reversed : String = String::new( ) ;
   let characters : &str = target.as_str( ) ;
   let mut iter = characters.chars( ).rev( ) ;
   while let Some( c ) = iter.next( ) {
      reversed.push( c ) ;
   }
   target == reversed 
}

fn main() {
    println!("Enter a number!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let number : i32 = entered_line.parse::<i32>( ).unwrap( ) ;
    let mut current : i32 = number ;
    current -= 1 ;
    while ! is_palindrome( current ) {
       current -= 1 ;
    }
    let minus_diff : i32 = (current - number).abs( ) ;
    let minusnum = current ;
    current = number + 1 ;
    while ! is_palindrome( current ) {
       current += 1 ;
    }
    let plus_diff : i32 = (current - number).abs( ) ;
    let plusnum = current ;
    if minus_diff ==  plus_diff {
       println!("{:?}" , minusnum.to_string( ) ) ;
    }
    else {
       if minus_diff < plus_diff {
	  println!("{:?}" , minusnum.to_string( ) ) ;
       }
       else {
	  println!("{:?}" , plusnum.to_string( ) ) ;
       }
    }
}
