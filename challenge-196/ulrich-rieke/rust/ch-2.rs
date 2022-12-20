use std::io ;

fn find_end( start : usize , subvec : &Vec<i32> ) -> usize {
  let mut current_index : usize = start ;
  current_index += 1 ;
  if  current_index > subvec.len( ) - 1  {
      start
  }
  else {
      let  mut current_val : i32 = subvec[ current_index ] ;
      while current_val - subvec[ current_index - 1] == 1 {
    current_index += 1 ;
    if current_index < subvec.len( ) {
        current_val = subvec[ current_index ] ;
    }
    else {
        break ;
    }
      }
      current_index -= 1 ;
      current_index
  }
}

fn main() {
  println!("Please enter a sorted array of unique integers!") ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let array : Vec<i32> = entered_line.split_whitespace( ).map( | s |
    s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
  let mut subsequences : Vec<Vec<i32>> = Vec::new( ) ;
  let mut pos : usize = 0 ;
  while pos < array.len( ) - 1 {
      let end = find_end( pos , &array ) ;
      if end - pos > 0 {
    let subarray = vec![array[pos] , array[end]] ;
    subsequences.push( subarray ) ;
      }
      pos = end + 1 ;
  }
  println!("{:?}" , subsequences ) ;
}
