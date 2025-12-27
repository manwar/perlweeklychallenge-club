use std::io ;
use regex::Regex ;

fn main() {
    println!("Enter some code separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let codes : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    println!("Enter as many names from different categories!") ;
    let mut nameline : String = String::new( ) ;
    io::stdin( ).read_line( &mut nameline ).unwrap( ) ;
    let names : Vec<&str> = nameline.trim( ).split_whitespace( ).collect( ) ;
    println!( "Enter as many status codes true or false!" ) ;
    let mut statusline : String = String::new( ) ;
    io::stdin( ).read_line( &mut statusline ).unwrap( ) ;
    let status : Vec<&str> = statusline.trim( ).split_whitespace( )
        .collect( ) ;
    let re = Regex::new( r"^\w+$" ).unwrap( ) ;
    let categories : Vec<&str> = vec!["electronics" , "restaurant" , 
        "grocery" , "pharmacy"] ;
    let mut result : Vec<bool> = Vec::new( ) ;
    let len : usize = codes.len( ) ;
    for i in 0..len {
        result.push( re.is_match( codes[i] ) && categories.contains( 
                    &names[i] ) && status[i] == "true" ) ;
    }
    println!("{:?}" , result ) ;
}
