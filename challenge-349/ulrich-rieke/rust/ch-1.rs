use std::io ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim( ) ;
    let mut neighbouring : Vec<(char , usize)> = Vec::new( ) ;
    let mut last_char : char = word.chars( ).nth(0).unwrap( ) ;
    let mut num : usize = 1 ;
    let mut iter = word.chars( ).skip( 1 ) ;
    while let Some (c) = iter.next( ) {
        if c == last_char {
            num += 1 ;
        }
        else {
            neighbouring.push( (last_char , num ) ) ;
            num = 1 ;
            last_char = c ;
        }
    }
    neighbouring.push( (last_char , num) ) ;
    neighbouring.sort_by( |a , b| a.1.cmp( &b.1) ) ;
    println!("{}" , neighbouring[neighbouring.len( ) - 1].1 ) ;
}
