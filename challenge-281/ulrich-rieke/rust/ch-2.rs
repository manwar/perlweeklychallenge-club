use std::io ;

//find the target fields for a given start field
fn find_target_fields( from : String , fields : &Vec<(char , char)> )
   -> Vec<String> {
   let field : &str = &from[..] ;
   let chess_cols : &str = "abcdefgh" ;
   let chess_rows : &str = "12345678" ;
   let col : char = field.chars( ).nth( 0  ).unwrap( ) ;
   let row : char = field.chars( ).nth( 1 ).unwrap( ) ;
   let colpos = chess_cols.find( col ).unwrap( ) ;
   let rowpos = chess_rows.find( row ).unwrap( ) ;
   let mut target_fields : Vec<String> = Vec::new( ) ;
   fields.into_iter( ).filter( | p | {
	 let pos1 = chess_cols.find( p.0 ).unwrap( ) ;
	 let pos2 = chess_rows.find( p.1).unwrap( ) ;
	 let coldiff : i8 = pos1 as i8 - colpos as i8 ;
	 let rowdiff : i8 = pos2 as i8 - rowpos as i8 ;
	 coldiff.abs( ) == 1 && rowdiff.abs( ) == 2 ||
	 (coldiff.abs( ) == 2 && rowdiff.abs( ) == 1 ) 
	 } ).map( | p | {
	    let mut a_field : String = String::new( ) ;
	    a_field.push(  p.0 ) ;
	    a_field.push( p.1 ) ;
	    a_field 
	    }).for_each( | f | target_fields.push( f ) ) ;
   target_fields 
}
	
//it's a brute force approach... find the target fields for the start field,
// and after that , keep creating the target fields for every found field
//until the field given at the start is in it!
fn main() {
    println!("Enter a source and a target chess field!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let entered_fields : Vec<&str> = entered_line.split_whitespace( ).collect( ) ;
    let start_field : String = entered_fields[0].into( ) ;
    let target : String = entered_fields[1].into( ) ;
    let chess_cols : &str = "abcdefgh" ;
    let chess_rows : &str = "12345678" ;
    let mut all_fields : Vec<(char , char)> = Vec::new( ) ;
    for c in chess_cols.chars( ) {
       for r in chess_rows.chars( ) {
	  all_fields.push( (c , r ) ) ;
       }
    }
    let mut count : usize = 1 ;
    let mut target_fields : Vec<String> = find_target_fields( start_field , 
	  & all_fields ) ;
    let mut targets = &target_fields[..] ;
    while ! targets.contains( &target )  {
       count += 1 ;
       let new_targets : Vec<String> = target_fields.iter( ).map( | s |
	find_target_fields( s.to_string( ) , &all_fields )).flatten( ).collect( ) ;
       target_fields = new_targets.clone( ) ;
       targets = &target_fields[..] ;
    }
    println!("{}" , count ) ;
}
