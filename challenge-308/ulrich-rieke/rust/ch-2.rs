use std::io ;

fn main() {
    println!("Enter some integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    println!("Enter an initial integer!") ;
    let mut numline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numline ).unwrap( ) ;
    let encoded : Vec<u16> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u16>( ).unwrap( ) ).collect( ) ;
    let ini_value : u16 = numline.trim( ).parse::<u16>( ).unwrap( ) ;
    let mut decoded : Vec<u16> = Vec::new( ) ;
    //the basic idea behind the solution is that xor serves as its own 
    //inverse function! so if we know a xor b = c and we are given a and c
    // b is a xor c! We are given an initial value and so can construct the
    //other values
    decoded.push( ini_value ) ;
    for i in encoded {
       let last : u16 = decoded[ decoded.len( ) - 1] ;
       decoded.push( i ^ last ) ;
    }
    println!("{:?}" , decoded ) ;
}
