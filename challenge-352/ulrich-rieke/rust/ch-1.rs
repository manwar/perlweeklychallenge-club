use std::io ;

fn main() {
    println!("Enter some strings separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin().read_line( &mut inline ).unwrap( ) ;
    let all_words : Vec<&str> = inline.trim( ).split_whitespace( ).
        collect( ) ;
    let mut result : Vec<&&str> = all_words.iter( ).filter( |&s| {
            all_words.iter( ).any( |w| *w != *s && w.find( &*s ).is_some() )
            } ).collect( ) ;
    result.dedup( ) ;
    println!("{:?}" , result ) ;
}
