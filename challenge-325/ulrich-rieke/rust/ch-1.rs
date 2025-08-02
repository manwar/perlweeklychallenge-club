use std::io ;

fn main() {
    println!("Enter some 0 or 1 separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u8> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u8>( ).unwrap( ) ).collect( ) ;
    let mut groups : Vec<usize> = Vec::new( ) ;
    let mut ones : usize = 0 ;
    for n in numbers {
       if n == 1 {
	  ones += 1 ;
       }
       else {
	  if ones > 0 {
	     groups.push( ones ) ;
	  }
	  ones = 0 ;
       }
       //don't forget the last element
       if ones > 0 {
	  groups.push( ones ) ;
       }
    }
    if groups.len( ) > 0 {
       println!("{}" , groups.into_iter( ).max( ).unwrap( ) ) ;
    }
    else {
       println!("0" ) ;
    }
}
