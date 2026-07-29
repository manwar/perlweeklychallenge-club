use std::io ;

//does a string contain as many 0 as 1 grouped consecutively? We assume
//the string to be an even number of characters long
fn condition( word : &str ) -> bool {
   let l : usize = word.chars().count( ) ;
   let mut one_part : String = String::new( ) ;
   let mut other_part : String = String::new( ) ;
   for _ in 0..l / 2 {
      one_part.push( '0' ) ;
      other_part.push( '1' ) ;
   }
   let ( first , second ) : (&str , &str) = word.split_at( l / 2 ) ;
   (first == &one_part[..] && second == &other_part[..]) || (first == 
      &other_part[..] && second == &one_part[..] )
}

fn main() {
    println!("Enter a binary string consisting of 0 and 1 only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let binary : &str = inline.trim( ) ;
    if binary.chars( ).all( |c| c == '0' ) || binary.chars( ).all( |c| 
          c == '1' ) {
       println!("()") ;
    }
    else {
       //for every position in the binary string , go as far right until
       //there is a substring that fulfils the condition if there is
       //one . Enter that string in the solution vector!
       let mut selected : Vec<&str> = Vec::new( ) ;
       let l : usize = binary.chars( ).count( ) ;
       let binstring : String = binary.into( ) ;
       for pos in 0..l - 1 { //starting position
          for len in 2..l - pos + 1 {
             let substr : &str = &binstring[pos..pos + len] ;
             if condition( substr ) {
                selected.push( substr ) ;
                break ;
             }
          }
       }
       println!("{:?}" , selected ) ;
    }
}
