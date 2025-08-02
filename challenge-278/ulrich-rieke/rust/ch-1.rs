use std::io ;

fn main() {
    println!("Enter some words with ending numbers , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let words : Vec<&str> = entered_line.split_whitespace( ).collect( ) ;
    let mut all_pairs : Vec<(&str, u16)> = Vec::new( ) ;
    words.into_iter( ).map( | w | {
	  let pos : usize = w.find( | c : char| c.is_ascii_digit( )).unwrap( ) ;
	  let first_part : &str = &w[0..pos] ;
	  let second_part : u16 = w[pos..].parse::<u16>( ).unwrap( ) ;
	  let p = (first_part , second_part ) ;
	  p } ).for_each( |pa| all_pairs.push( pa ) ) ;
    all_pairs.sort_by( |a , b| a.1.cmp( &b.1 ) );
    all_pairs.into_iter().for_each( |p| print!("{:?} " , p.0)) ;
    println!("") ;
}
