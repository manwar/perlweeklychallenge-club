use regex::Regex ; 
use std::io ;

fn parse_complex( number : &str ) -> (i32 , i32) {
    let re = Regex::new( r"(\-?\d+)\+\(?(\-?\d+)\)?i").unwrap( ) ;
    let caps = re.captures( number ).unwrap( ) ;
    let real_part = caps.get( 1 ).map_or( "" , |m| m.as_str( ) ) ;
    let imaginary_part = caps.get( 2 ).map_or( "" , |m| m.as_str( ) ) ;
    (real_part.parse::<i32>().unwrap( ) , imaginary_part.parse::<i32>( ).
     unwrap( ) )
}

fn main() {
    println!("Enter 2 complex numbers , each one as a string!");
    let mut inline : String = String::new( ) ;
    io::stdin().read_line( &mut inline ).unwrap( ) ;
    let complex_numbers : Vec<&str> = inline.trim( ).split_whitespace( ).
       collect( ) ;
    let ( a , b ) : (i32 , i32) = parse_complex( complex_numbers[0] ) ;
    let ( c , d ) : (i32 , i32) = parse_complex( complex_numbers[1] ) ;
    let real : i32 = a * c - b * d ;
    let imaginary : i32 = b * c + a * d ;
    let mut output : String = String::new( ) ;
    let real_part : String = real.to_string( ) ;
    let imago : String = imaginary.to_string( ) ;
    output.push_str(&real_part[..]) ;
    output.push( '+' ) ;
    if imaginary < 0 {
       output.push( '(' ) ;
    }
    output.push_str(&imago[..]) ;
    if imaginary < 0 {
       output.push( ')' ) ;
    }
    output.push( 'i' ) ;
    println!("{:?}" , output ) ;
}
