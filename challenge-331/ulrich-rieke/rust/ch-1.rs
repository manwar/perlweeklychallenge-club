use std::io ;

fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let input : &str = inline.trim( ) ;
    let words : Vec<&str> = input.split(char::is_whitespace).collect( ) ;
    let non_empty : Vec<&str> = words.into_iter( ).filter( |&w|
	  w.chars( ).count( ) > 0 && w.chars( ).all( |c| c.is_alphanumeric( )))
	  .collect( ) ;
    println!("{:?}" , non_empty ) ;
    let len : usize = non_empty.len( ) ;
    println!("{}" , non_empty[len - 1].chars( ).count( ) ) ;
}
