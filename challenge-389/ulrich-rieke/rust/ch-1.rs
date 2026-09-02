use std::io ;

//for the purpose of this task , I enter all different elements of 
//melody on separate lines and construct the output from that

fn to_upper( name : &str ) -> String {
   let mut changed : String = String::new( ) ;
   for c in name.chars( ) {
      changed.push( c.to_ascii_uppercase( ) ) ;
   }
   changed 
}

fn main() {
    println!("Enter the composer name!");
    let mut composerline : String = String::new( ) ;
    io::stdin( ).read_line( &mut composerline ).unwrap( ) ;
    println!("Enter the notes separated by whitespace!" ) ;
    let mut noteline : String = String::new( ) ;
    io::stdin( ).read_line( &mut noteline ).unwrap( ) ;
    println!("Enter a permutation!") ;
    let mut permuline : String = String::new( ) ;
    io::stdin().read_line( &mut permuline ).unwrap( ) ;
    let notes : Vec<&str> = noteline.trim( ).split_whitespace( ).collect( ) ;
    let permus : Vec<usize> = permuline.trim( ).split_whitespace( ).
       map( |s| s.parse::<usize>().unwrap( )).collect( );
    let mut solution : String = String::new( ) ;
    let composer : &str = composerline.trim( ) ;
    let capitalized : String = to_upper( composer ) ;
    solution.push_str( capitalized.as_str( ) ) ;
    solution.push_str( " => " ) ;
    let mut correlations : Vec<(usize, &str)> = permus.into_iter().zip(
          notes.into_iter( )).collect( ) ;
    correlations.iter_mut( ).for_each( |p| p.0 = p.0 - 1) ;
    correlations.sort_by_key( |p| p.0 ) ;
    for p in &correlations {
       solution.push_str( p.1 ) ;
       solution.push( ' ' ) ;
    }
    println!("{:?}" , solution ) ;
}
