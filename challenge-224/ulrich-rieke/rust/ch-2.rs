use std::io ;
use itertools::Itertools ;
use std::collections::HashSet ;

fn is_additive( numbers : &Vec<u32> ) -> bool {
  let len : usize = numbers.len( ) ;
  if len > 2 {
      for pos in 2..len {
    if numbers[pos - 2] + numbers[ pos - 1 ] != numbers[ pos ] {
        return false ;
    }
      }
      true
  }
  else {
      false
  }
}

fn extract_from_string( numberstring : &String , places : &Vec<usize> )
  -> Vec<u32> {
      let mut extracted : Vec<u32> = Vec::new( ) ;
      let mut pos : usize = 0 ;
      for i in places {
    let substr = &numberstring[pos..pos + *i] ;
    extracted.push( substr.parse::<u32>().unwrap( ) ) ;
    pos += i ;
      }
      extracted
}

fn find_int_partitions( len : usize ) -> Vec<Vec<usize>> {
  let mut all_partitions : Vec<Vec<usize>> = Vec::new( ) ;
  let mut numberarray : Vec<usize> = Vec::new( ) ;
  for i in 1..=len {
      let howmany = len / i ;
      for _ in 0..howmany {
    numberarray.push( i ) ;
      }
  }
  let numlen = numberarray.len( ) ;
  let mut vec_set : HashSet<Vec<usize>> = HashSet::new( ) ;
  for i in 1..numlen + 1 {
      let it = numberarray.iter( ).combinations( i ) ;
      for vec in it {
    let mut some_vec : Vec<usize> = Vec::new( ) ;
    for n in vec {
        some_vec.push( *n ) ;
    }
    if some_vec.iter( ).sum::<usize>( ) == len {
        vec_set.insert( some_vec ) ;
    }
      }
  }
  for v in vec_set {
      all_partitions.push( v ) ;
  }
  all_partitions
}

fn main() {
    println!("Enter a string, containing only digits from 0 to 9!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let changed = entered_line.trim( ) ;
    let numberstring : String = changed.to_string( ) ;
    let len = numberstring.len( ) ;
    let partition_pos : Vec<Vec<usize>> = find_int_partitions( len ) ;
    let mut number_partitions : Vec<Vec<u32>> = Vec::new( ) ;
    for v in &partition_pos {
      let a_partition : Vec<u32> = extract_from_string( &numberstring , &v ) ;
      number_partitions.push( a_partition ) ;
    }
    if number_partitions.iter( ).any( | ve | is_additive( &ve ) ) {
      println!("true") ;
    }
    else {
      println!("false") ;
    }
}
