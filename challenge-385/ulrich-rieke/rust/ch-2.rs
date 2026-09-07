fn after_outermost_removal( input : &str ) -> String {
//input is assumed to be a valid string in the sense of setting the
//parentheses. The first opening parenthesis is counted as 1 , all
//following openers are counted up, all closing ones count down. Remove
//all parentheses with count 1 and 0
   let mut after_removal : String = String::new( ) ;
   let mut current_num : usize = 0 ;
   let mut letter_numbers : Vec<(usize, char)> = Vec::new( ) ;
   for c in input.chars( ) {
      if c == '(' {
         current_num += 1 ;
      }
      else {
         current_num -= 1 ;
      }
      letter_numbers.push( (current_num , c) ) ;
   }
   for pair in letter_numbers {
      if pair.1 == '(' && pair.0 != 1 {
         after_removal.push( '(' ) ;
      }
      if  pair.1 == ')' && pair.0 != 0 {
         after_removal.push( ')' ) ;
      }
   }
   after_removal 
}

fn main() {
    println!("{:?}" , after_outermost_removal( "()()()"));
    println!("{:?}" , after_outermost_removal( "(((())))")) ;
    println!("{:?}" , after_outermost_removal( "(()())(())")) ;
    println!("{:?}" , after_outermost_removal( "()((()))()")) ;
    println!("{:?}" , after_outermost_removal( "(()(()))(()())")) ;
}
