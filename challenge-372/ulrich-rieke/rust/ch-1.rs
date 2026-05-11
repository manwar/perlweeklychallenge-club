use std::io ;

fn main() {
    println!("Enter a text of words surrounded by spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let spacecount : usize = inline[..].chars( ).filter( |&c| c == ' ' ).
       count( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).
       collect( ) ;
    let wordnumber : usize = words.len( ) ;
    let mut output : String = String::new( ) ;
    if wordnumber == 1 {
       for c in words[0].chars( ) {
          output.push( c ) ;
       }
       for _ in 0..spacecount {
          output.push( ' ' ) ;
       }
    }
    else {
       let gapspaces : usize = spacecount / (wordnumber - 1) ;
       for i in 0..wordnumber - 1 {
          for c in words[i].chars( ) {
             output.push( c ) ;
          }
          for _ in 0..gapspaces {
             output.push( ' ' ) ;
          }
       }
       for c in words[wordnumber - 1].chars( ) {
          output.push( c ) ;
       }
       for _ in 0..spacecount - gapspaces * ( wordnumber - 1 ) {
          output.push( ' ' ) ;
       }
    }
    println!("{:?}" , output ) ;
}
