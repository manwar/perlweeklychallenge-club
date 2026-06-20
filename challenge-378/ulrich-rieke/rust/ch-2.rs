use std::io ;

fn to_number( word : &str ) -> u32 {
   let mut numberstring : String = String::new( ) ;
   for c in word.chars( ) {
      let n : u32 = c as u32 - 97 ;
      numberstring.push( char::from_digit( n , 10 ).unwrap( ) ) ;
   }
   numberstring.parse::<u32>().unwrap( ) 
}

fn main() {
    println!("Enter 3 strings with letters from a to i!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let numbers : Vec<u32> = words.iter( ).map( |w| to_number( w )).
       collect( ) ;
    println!("{}" , numbers[0] + numbers[1] == numbers[2] ) ;
}
