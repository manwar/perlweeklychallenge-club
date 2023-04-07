use std::io;
use itertools::Itertools ;
use std::collections::HashMap ;

fn find_difference( first_vec : &Vec<i32> , second_vec : &Vec<&i32> ) ->
Vec<i32> {
    let mut first_map : HashMap<i32 , usize> = HashMap::new( ) ;
    let mut second_map : HashMap<i32, usize> = HashMap::new( ) ;
    let mut difference : Vec<i32> = Vec::new( ) ;
    for num in first_vec {
      first_map.entry( *num ).and_modify( | counter | *counter += 1).
      or_insert( 1 ) ;
    }
    for num in second_vec {
      second_map.entry( **num ).and_modify( | counter | *counter += 1).
      or_insert( 1 ) ;
    }
    for key in second_map.keys( ) {
      first_map.entry( *key ).and_modify( | counter | *counter -=
        second_map.get( &key ).unwrap( ) ) ;
    }
    for key in first_map.keys( ) {
      match first_map.get( &key ) {
      Some( val ) => {
        for _ in 0..*val {
        difference.push( *key ) ;
        }
      } ,
      None        => { } ,
      } ;
    }
    difference
}

fn average( vector : &Vec<i32> ) -> f32 {
  let len : f32 = vector.len( ) as f32 ;
  let mut copy : Vec<f32> = Vec::new( ) ;
  vector.iter( ).for_each( | i | copy.push( *i as f32 )) ;
  let sum = copy.iter( ).sum::<f32>( ) ;
  sum / len
}

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut result : bool = false ;
    let len = numbers.len( ) ;
    if len == 1 {
      result = true ;
    }
    else {
      if numbers.iter( ).all( | i | *i == numbers[ 0 ] ) {
      if len % 2 == 0 {
        result = true ;
      }
      else {
        result = false ;
      }
      }
      else {
      let mut combinum = len - 1 ;
      'myloop: while combinum > len / 2 {
        for v in numbers.iter( ).combinations( combinum ) {
        let difference = find_difference( &numbers , &v ) ;
        let mut combi : Vec<i32> = Vec::new( ) ;
        v.iter( ).for_each( | i | combi.push( **i ) )  ;
        if average( &difference ) == average( &combi ) {
          result = true ;
          break 'myloop ;
        }
        else {
        }
        }
        combinum -= 1 ;
      }
    }
  }
  println!("{}" , result ) ;
}
