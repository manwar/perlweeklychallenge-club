use std::io ;

fn main() {
    println!("Enter some strings separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let len : usize = words.len( ) ;
    let mut result : usize = 0 ;
    for i in 0..len - 1 {
       for j in i + 1 .. len {
          let fl : usize = words[i].chars( ).count( ) ;
          let sl : usize = words[j].chars( ).count( ) ;
          if fl <= sl && {
             let _first : String = words[i].into( ) ;
             let second : String = words[j].into( ) ;
             second[0..fl] == *words[i] && second[sl - fl ..] == 
                *words[i] 
          } {
             result += 1 ;
          }
       }
    }
    println!("{}" , result ) ;
}
