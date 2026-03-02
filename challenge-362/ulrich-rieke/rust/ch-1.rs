use std::io ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim_end( ) ;
    let mut result : String = String::new( ) ;
    let mut iter = word.char_indices( ) ;
    while let Some( (pos , letter) ) = iter.next( ) {
       for _ in 0..pos + 1 {
          result.push( letter ) ;
       }
    }
    println!("{:?}" , result ) ;
}
