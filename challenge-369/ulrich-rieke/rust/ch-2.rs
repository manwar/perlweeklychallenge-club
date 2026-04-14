use std::io ;

fn main() {
    println!("Enter a string , a length and a filler separated by blanks!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let parts : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let size : usize = parts[1].parse::<usize>( ).unwrap( ) ;
    let filler : char = parts[2].chars( ).nth(0).unwrap( ) ;
    let mut output : Vec<&str> = Vec::new( ) ;
    let len : usize = parts[0].chars( ).count( ) ;
    let first_word : String = parts[0].into( ) ;
    let mut start : usize = 0 ;
    while start < len {
       if start + size < len {
          output.push( &first_word[start..start + size] ) ;
       }
       else {
          output.push( &first_word[start..] ) ;
       }
       start += size ;
    }
    let mut last_word : String = output[output.len( ) - 1].into( ) ;
    let last_len : usize = output[output.len( ) - 1].chars( ).count( ) ;
    if last_len < size {
       let diff : usize = size - last_len ;
       for _ in 0..diff {
          last_word.push( filler ) ;
       }
       output.pop( ) ;
       output.push( last_word.as_str( ) ) ;
    }
    println!("{:?}" , output ) ;
}
