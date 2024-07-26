use std::io ;

fn is_vowel( c : char ) -> bool {
   let vowels : &str = "aeiouAEIOU" ;
   vowels.find( c ).is_some( ) 
}

//the task amounts to verifying whether the number of vowels in the string
//is even or odd
fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let result : bool = entered_line.chars( ).filter( | &c | is_vowel( c ))
       .count( ) % 2 == 0  ;
    println!("{}" , result ) ;
}
