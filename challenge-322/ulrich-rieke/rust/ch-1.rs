use std::io ;

fn main() {
    println!("Enter a word and a positive integer separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let number : usize = words[1].parse::<usize>( ).unwrap( ) ;
    let word : String = words[0].replace("-" , "") ;
    let wordlen : usize = word.len( ) ;
    let firstlen : usize = wordlen % number ;
    let mut solution : String = String::new( ) ;
    let mut pos : usize = 0 ;
    if firstlen != 0 {
       let firstpart : &str = &word[..firstlen] ;
       solution = firstpart.into( ) ;
       solution.push('-') ;
       pos = firstlen ;
    }
    while pos + number < wordlen {
       solution += &word[pos..pos + number] ;
       solution.push( '-' ) ;
       pos += number ;
    }
    solution += &word[pos..] ;
    println!("{:?}" , solution ) ;
}
