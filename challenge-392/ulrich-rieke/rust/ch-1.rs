use std::io ;

fn is_palindrome( word : &str ) -> bool {
   let mut reversed : String = String::new( ) ;
   for c in word.chars( ).rev( ) {
      reversed.push( c ) ;
   }
   reversed[..] == *word
}

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let my_word : &str = inline.trim( ) ;
    if is_palindrome( my_word ) {
       println!("{}" , my_word ) ;
    }
    else {
       //up to which letter is a part of the word a palindrome ?
       //the first letter certainly is one
       let mut max_up_to : usize = 1 ;
       let len : usize = my_word.chars( ).count( ) ;
       for i in 2..len {
          let current : String = my_word.chars( ).take( i ).collect() ;
          if is_palindrome( &current[..] ) {
             if i - 1 > max_up_to {
                max_up_to = i - 1 ;
             }
          }
       }
       println!("{}" , max_up_to ) ;
       let mut to_prepend : String = String::new( ) ;
       let entered : String = my_word.to_owned( ) ;
       let end_of_string : &str ;
       if max_up_to == 1 {
          end_of_string = &entered[1..] ;
       }
       else {
          end_of_string = &entered[max_up_to + 1 ..] ;
       }
       for c in end_of_string.chars( ).rev( ) {
          to_prepend.push( c ) ;
       }
       println!("{}" , to_prepend.as_str( ).to_owned( ) + my_word ) ;
    }
}
