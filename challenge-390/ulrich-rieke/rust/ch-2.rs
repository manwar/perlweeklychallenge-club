use std::io ;

fn move_letter( word : &str , position : usize ) -> String {
   let mut result : String = String::new( ) ;
   let to_be_moved : char = word.chars( ).nth( position ).unwrap( ) ;
   for i in 0..word.chars( ).count( ) {
      if i != position {
         result.push( word.chars( ).nth( i ).unwrap( ) ) ;
      }
   }
   result.push( to_be_moved ) ;
   result 
}

fn main() {
    println!("Enter a word of alphabetic characters only and a number!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let elements : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let startword : &str = elements[0] ;
    let k : usize = elements[1].parse::<usize>( ).unwrap( ) ;
    //the assumption is , that if k is greater than 1 we go through
    //all permutations of the letters of the word entered.
    //so, in that case , we choose the lexicographically smallest string.
    //In any case , we can create as many combinations per word as k allows.
    //This also holds true for all the other words that are results of 
    //movements
    let mut permus_so_far : Vec<String> = Vec::new( ) ;
    let result : String ;
    if k == 1 {
       permus_so_far.push( move_letter( startword , 0 ) ) ;
       while ! permus_so_far.contains( &startword.into( ) ) {
          let len : usize = permus_so_far.len( ) ;
          let last_word : &str = &permus_so_far[len - 1][..] ;
          permus_so_far.push( move_letter( last_word , 0 ) ) ;
       }
       permus_so_far.sort( ) ;
       result = permus_so_far[0].clone( ) ;
    }
    else {
       let mut letters : Vec<char> = Vec::new( ) ;
       for c in startword.chars( ) {
          letters.push( c ) ;
       }
       letters.sort( ) ;
       let mut lexi_smallest : String = String::new( ) ;
       for c in letters {
          lexi_smallest.push( c ) ;
       }
       result = lexi_smallest ;
    }
    println!("{:?}" , result ) ;
}
