use std::io ;
use std::cmp::Ordering ;

fn no_more_collisions_needed( a_vec : &Vec<i32> ) -> bool {
  let len : usize = a_vec.len( ) ;
  let truth_value : bool = match len {
      0 | 1 => true ,
    2  => ! (a_vec[ 0 ] > 0 && a_vec[ 1 ] < 0 ) ,
    _  => {
      let mut positions : Vec<usize> = Vec::new( ) ;
      for pos in 0..=len - 2 {
          positions.push( pos ) ;
      }
      positions.iter( ).all( | i | ! ( a_vec[ *i ] > 0 && a_vec[ *i + 1 ] < 0 ))
    } ,
  } ;
  truth_value
}



fn walk_through( a_vec : &Vec<i32> ) -> Vec<i32>  {
  let mut vec_after_collision : Vec<i32> = Vec::new( ) ;
  let len : usize = a_vec.len( ) ;
  let mut pos : usize = 0 ;
  while ! (a_vec[pos] > 0 && a_vec[ pos + 1 ] < 0 )  {
      vec_after_collision.push( a_vec[ pos ] ) ;
      pos += 1 ;
  }
  match a_vec[pos].abs( ).cmp( &a_vec[pos + 1 ].abs( ) ) {
      Ordering::Less => vec_after_collision.push( a_vec[ pos + 1 ] ) ,
      Ordering::Equal => {} ,
      Ordering::Greater => vec_after_collision.push( a_vec[ pos ] ) ,
  } ;
  pos += 2 ;
  if pos < len {
      while pos < len {
    vec_after_collision.push( a_vec[ pos ] ) ;
    pos += 1 ;
      }
  }
  vec_after_collision
}

fn main() {
    println!("Please enter some positive and negative integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map ( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut vec_after_collision : Vec<i32> = walk_through( &numbers ) ;
    while  ! no_more_collisions_needed( &vec_after_collision ) {
      let new_vec = walk_through( &vec_after_collision ) ;
      vec_after_collision = new_vec ;
    }
    println!("{:?}" , vec_after_collision ) ;
}
