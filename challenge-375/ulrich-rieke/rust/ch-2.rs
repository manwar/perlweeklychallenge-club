use std::io ;

fn k_beauty( number : &str , k : usize ) -> usize {
   let len : usize = number.chars( ).count( ) ;
   let startnum : usize = number.parse::<usize>().unwrap( ) ;
   let result : usize ;
   if len == k {
      result = 1 ;
   }
   else {
      if k > len {
         result = 0 
      }
      else {
         let mut numbers : Vec<usize> = Vec::new( ) ;
         let numberstring : String= number.into( ) ;
         for pos in 0..len - k + 1 {
            numbers.push( numberstring[pos..pos + k ].
                  parse::<usize>( ).unwrap( ) ) ;
            }
            result = numbers.into_iter( ).filter( |&n| startnum % n == 0 ).
               count( ) ;
         }
      }
   result 
}

fn main() {
    println!("Enter a number and a k value!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numberstrings : Vec<&str> = inline.trim( ).split_whitespace( ).
       collect( ) ;
    println!( "{}" , k_beauty( numberstrings[0] , numberstrings[1].
             parse::<usize>().unwrap( ) ) ) ;
}
