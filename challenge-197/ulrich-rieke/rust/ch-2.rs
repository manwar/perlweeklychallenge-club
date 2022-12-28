use std::io ;
use itertools::Itertools ;
use std::collections::{HashSet , HashMap} ;

fn my_condition( a_permu : &Vec<i32> ) -> bool {
  let len = a_permu.len( ) ;
  let is_wiggled = match len {
      l if l < 3 => false ,
    3        => a_permu[0] < a_permu[1] && a_permu[1] > a_permu[2] ,
      _l @ 4..=usize::MAX => {
    let mut even_indices : Vec<usize> = Vec::new( ) ;
    let mut odd_indices : Vec<usize> = Vec::new( ) ;
    for i in 0..len - 1 {
        if i % 2 == 0 {
          even_indices.push( i ) ;
        }
        else {
          odd_indices.push( i ) ;
        }
    }
    return even_indices.iter( ).all( | ind | a_permu[*ind]
          < a_permu[ *ind + 1 ] )
          && odd_indices.iter( ).all( | ind | a_permu[ *ind ] >
          a_permu[ *ind + 1 ] ) ;
      }
      _ => false ,
  } ;
  is_wiggled
}

fn main() {
    println!("Please enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).
      map( | s | s.trim( ).parse::<i32>().unwrap( ) ).collect( ) ;
    let mut frequencies : HashMap<i32 , i32> = HashMap::new( ) ;
    for n in &numbers {
      let counter = frequencies.entry( *n ).or_insert( 0 ) ;
      *counter += 1 ;
    }
    let mut values : Vec<i32> = Vec::new( ) ;
    for ( _ , val ) in frequencies.iter( ) {
      values.push( *val ) ;
    }
    let maxval = values.iter( ).max( ).unwrap( ) ;
    if  numbers.len( ) > 3 && maxval >= &((numbers.len( ) - 1) as i32 ) {
      println!("Wiggle condition can't be fulfilled!" ) ;
    }
    else {
      let l = numbers.len( ) ;
      let mut combis : HashSet<Vec<i32>> = HashSet::new( ) ;
      for perm in numbers.into_iter( ).permutations( l ) {
      if my_condition( &perm ) {
        combis.insert( perm ) ;
      }
      }
      println!("{:?}" , combis) ;
    }
}
