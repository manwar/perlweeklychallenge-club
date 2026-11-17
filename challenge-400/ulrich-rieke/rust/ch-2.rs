use std::io ;

fn string_difference( first : &str , second : &str ) -> usize {
   //both strings are known to be of equal length
   let mut differences : usize = 0 ;
   let len : usize = first.chars( ).count( ) ;
   for i in 0..len {
      if first.chars( ).nth( i ).unwrap( ) != second.chars( ).nth( i ).
         unwrap( ) {
            differences += 1 ;
         }
   }
   differences 
}

fn main() {
    println!("Enter a start genome!");
    let mut startline : String = String::new( ) ;
    io::stdin( ).read_line( &mut startline ).unwrap( ) ;
    let start : &str = startline.trim( ) ;
    println!("Enter an end genome of equal length!") ;
    let mut endline : String = String::new( ) ;
    io::stdin( ).read_line( &mut endline ).unwrap( ) ;
    let end : &str = endline.trim( ) ;
    println!("Enter a gene bank of genomes with equal length!" ) ;
    let mut bankline : String = String::new( ) ;
    io::stdin( ).read_line( &mut bankline ).unwrap( ) ;
    let genebank : Vec<&str> = bankline.trim( ).split_whitespace( ).
       collect( ) ;
    if start == end {
       println!("0" ) ;
    }
    else {
       if ! genebank.contains( &end ) {
          println!("-1") ;
       }
       else {
          let mutations : usize = string_difference( start , end ) ;
          let mutation_steps : Vec<usize> = genebank.into_iter( ).map( 
                |s| string_difference( s , start )).collect( ) ;
          if (1..=mutations).all( |n| mutation_steps.contains( &n )) {
             println!("{}" , mutations ) ;
          }
          else {
             println!("-1" ) ;
          }
       }
    }
}
