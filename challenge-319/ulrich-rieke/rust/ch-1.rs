use std::io ;

fn main() {
    println!("Enter some words separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let vowels : Vec<char> = vec!['a' , 'e' , 'i' , 'o' , 'u' , 'A' , 'E' , 
	'I' , 'O' , 'U' ] ;
    println!("{}" , words.into_iter( ).filter( |w| {
	     let len = w.chars( ).count( ) ;
	     let firstchar = w.chars( ).nth( 0 ).unwrap( ) ;
	     let lastchar = w.chars( ).nth( len - 1 ).unwrap( ) ;
	     vowels.contains( &firstchar ) || vowels.contains( &lastchar )
	     }).count( ) ) ;
}
