use std::io ;
use std::collections::HashSet ;

fn find_index( strings : &Vec<&str> , needle : &str ) -> usize {
  let mut pos : usize = 0 ;
  while strings[ pos ] != needle {
      pos += 1 ;
  }
  pos
}

fn main() {
    println!("Enter some strings, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let first_line : &str = &*inline ;
    let first_words : Vec<&str> = first_line.split_whitespace( ).map( | s |
      s.trim( ) ).collect( ) ;
    let mut second : String = String::new( ) ;
    println!("Enter some other strings, separated by blanks!" ) ;
    io::stdin( ).read_line( &mut second ).unwrap( ) ;
    let second_line : &str = &*second ;
    let second_words : Vec<&str> = second_line.split_whitespace( ).map( | s |
      s.trim( ) ).collect( ) ;
    let first_set : HashSet<&&str> = first_words.iter( ).collect( ) ;
    let second_set : HashSet<&&str> = second_words.iter( ).collect( ) ;
    let common : HashSet<&&&str> = first_set.intersection( &second_set).collect( ) ;
    if common.len( ) > 0 {
      let mut word_indices : Vec<(&str , usize)> = Vec::new( ) ;
      let mut set_iter = common.iter( ) ;
      while let Some( w ) = set_iter.next( ) {
      word_indices.push((**w , find_index( &first_words , **w ) +
          find_index( &second_words, **w )) ) ;
      }
      let indices : &mut[(&str, usize)] = word_indices.as_mut_slice( ) ;
      indices.sort_by( | a , b | a.1.cmp(&b.1) ) ;
      let minimum : usize = indices[0].1 ;
      let mut selected : Vec<&str> = Vec::new( ) ;
      indices.iter( ).filter( | p | p.1 == minimum ).for_each( | p | selected.push(
        p.0.clone( ) )) ;
      println!("{:?}" , selected ) ;
    }
    else {
      println!("()" ) ;
    }
}
