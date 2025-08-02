use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    println!("Enter a start number!") ;
    let mut numline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numline ).unwrap( ) ;
    let nline : &str = &*numline ;
    let start : i32 = nline.trim( ).parse::<i32>( ).unwrap( ) ;
    let mut found : i32 = start ;
    let mut f = numbers.iter( ).find( | &d | *d == found ) ;
    while f.is_some( )  {
       found = found * 2 ;
       f = numbers.iter( ).find( | &d | *d == found ) ;
    }
    println!("{}" , found ) ;
}
