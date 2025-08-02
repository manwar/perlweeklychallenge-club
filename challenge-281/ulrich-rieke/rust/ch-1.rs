use std::io ;

fn main() {
    println!("Enter a chess field!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let cols : &str = "abcdefgh" ;
    let col : char = entered_line.chars( ).nth( 0 ).unwrap( ) ;
    let row : u32 = entered_line.chars( ).nth( 1 ).unwrap( ).to_digit( 10 ).unwrap( ) ;
    let first_pair : Vec<&str> = vec!["light" , "dark"] ;
    let second_pair : Vec<&str> = vec!["dark" , "light"] ;
    let colnum = cols.find( col ).unwrap( ) ;
    let mut baseline_colors : Vec<&str> = Vec::new( ) ;
    let it = second_pair.iter( ).cycle( ).take( 8 ) ;
    it.for_each( | f | baseline_colors.push( f ) ) ;
    let result : bool ;
    if row == 1 {
       result = baseline_colors.iter( ).nth( colnum ).unwrap( ) == &"light" ;
    }
    else {
       let base_color : &str = baseline_colors[colnum] ;
       let mut col_sequence : Vec<&str> = Vec::new( ) ;
       if base_color == "light" {
	  let sec_it = first_pair.iter( ).cycle( ).take( 8 ) ;
	  sec_it.for_each( | f | col_sequence.push( f ) ) ;
       }
       else {
	  let it = second_pair.iter( ).cycle( ).take( 8 ) ;
	  it.for_each( | f | col_sequence.push( f ) ) ;
       }
       result = col_sequence[ (row - 1) as usize] == "light" ;
    }
    println!("{}" , result) ;
}
