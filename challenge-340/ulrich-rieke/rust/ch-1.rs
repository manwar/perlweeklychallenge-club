use std::io ;
use fancy_regex::Regex ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut word : &str = inline.trim( ) ;
    let re = Regex::new(r"(.)\1").unwrap( ) ;
    let mut result = re.is_match( word ).unwrap( ) ;
    let mut value : String ;
    while result {
       let fields : Vec<&str> = re.split( word ).map( |x| x.unwrap( ) ).collect( ) ;
       value = fields.iter( ).fold( "".to_string( ) , |acc , w| acc.to_owned( ) +
	     w ) ;
       word = value.as_str( ) ;
       result = re.is_match( word ).unwrap( ) ;
    }
    println!("{}" , word ) ;
}
