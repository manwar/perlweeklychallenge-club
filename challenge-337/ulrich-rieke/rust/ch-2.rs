use std::io ;
use regex::Regex ;

fn parse_pair( bracket : &str ) -> (usize , usize) {
   let re = Regex::new( r"([0-9]+)").unwrap( ) ;
   let numbers : Vec<usize> = re.find_iter( bracket ).map( |m| {
         let found = m.as_str( ) ;
         let num : usize = found.parse::<usize>( ).unwrap( ) ;
         num
         }).collect( ) ;
   (numbers[0] , numbers[1])
}

fn change_matrix( matrix : &mut Vec<Vec<u32>> , pair : (usize , usize ) ) ->
  Vec<Vec<u32>> {
     let rows : usize = matrix.len( ) ;
     let cols : usize = matrix[0].len( ) ;
     for c in 0..cols {
	matrix[pair.0][c] += 1 ;
     }
     for r in 0..rows {
	matrix[r][pair.1] += 1 ;
     }
     matrix.to_vec( ) 
}


fn main() {
    println!("Enter two integers denoting rows and columns!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<usize> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<usize>( ).unwrap( )).collect( ) ;
    println!("Enter some positions, in brackets( [ , ] ) separated by ,!" ) ;
    let mut posline : String = String::new( ) ;
    io::stdin( ).read_line( &mut posline ).unwrap( ) ;
    let rows : usize = numbers[0] ;
    let cols : usize = numbers[1] ;
    let mut matrix : Vec<Vec<u32>> = Vec::new( ) ;
    for _ in 0..rows {
       let mut row : Vec<u32> = Vec::new( ) ;
       for _ in 0..cols {
	  row.push( 0 ) ;
       }
       matrix.push( row ) ;
    }
    let re = Regex::new( r"\[\s*([0-9]+)\s*\,\s*([0-9]+)\]").unwrap( ) ;
    let trimmed = posline.trim( ) ;
    let parts : Vec<&str> = re.find_iter(trimmed).map( |m| m.as_str( )).
    collect( ) ;
    let coordinates : Vec<(usize , usize)> = parts.into_iter( ).map( |s|
          parse_pair( s ) ).collect( ) ;
    for p in coordinates {
       matrix = change_matrix( &mut matrix , p ) ;
    }
    let mut sum : u32 = 0 ;
    for c in 0..cols {
       for r in 0..rows {
	  if matrix[r][c] % 2 == 1 {
	     sum += 1 ;
	  }
       }
    }
    println!("{}" , sum ) ;
}
