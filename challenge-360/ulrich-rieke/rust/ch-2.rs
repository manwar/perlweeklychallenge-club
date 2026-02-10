use std::io ;

fn main() {
    println!("Enter a sentence!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut all_words : Vec<&str> = inline.trim_end( ).split_whitespace( ).
       collect( ) ;
    all_words.sort_by_key( |w| w.to_ascii_lowercase( ) ) ;
    let mut output : String = String::new( ) ;
    all_words.into_iter( ).for_each( |w| {
          output.push_str( w ) ;
          output.push( ' ' ) ;
          } ) ;
    output.pop( ) ;
    println!("{:?}" , output ) ;
}
