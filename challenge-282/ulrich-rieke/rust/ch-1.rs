use std::io ;

fn main() {
    println!("Enter a long integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let my_chars : Vec<char> = entered_line.chars( ).collect( ) ;
    let my_slice = &my_chars[..] ;
    let triplets : Vec<_> = my_slice.windows( 3 ).collect( ) ;
    let selected : Vec<_> = triplets.into_iter( ).filter( | &vec |
	  vec[0] == vec[1] && vec[1] == vec[2] ).collect( ) ;
    if selected.len( ) == 0 {
       println!("-1" ) ;
    }
    else {
       println!("{}" , selected[0].get( 0 ).unwrap( ) ) ;
    }
}
