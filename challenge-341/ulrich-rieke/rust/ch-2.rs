use std::io ;

fn main() {
    println!("Enter a string and a letter from that string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let search_in : &str = words[0] ;
    let search_for : &str = words[1] ;
    let pos : usize = search_in.find( search_for).unwrap( ) ;
    let mut final_string : String = String::new( ) ; 
    let mut p : usize = pos ;
    while p != 0 {
       final_string.push( search_in.chars( ).nth( p ).unwrap( ) ) ;
       p -= 1 ;
    }
    final_string.push( search_in.chars( ).nth( 0 ).unwrap( )) ;
    for c in search_in.chars( ).skip( pos + 1 ) {
       final_string.push( c ) ;
    }
    println!("{:?}" , final_string) ;
}
