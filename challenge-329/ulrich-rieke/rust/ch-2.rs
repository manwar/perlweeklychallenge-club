use std::io ;

fn is_nice( substring : &str ) -> bool {
   if substring.chars().count( ) == 1 {
      return false ;
   }
   substring.chars( ).all( |c| {
	 if c.is_ascii_lowercase( ) {
	    substring.contains( c.to_ascii_uppercase( ) ) 
	 }
	 else {
	    substring.contains( c.to_ascii_lowercase( ) ) 
	 } } ) 
}

fn main() {
    println!("Enter a word consisting of uppercase and lowercase letters!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut substrings : Vec<&str> = Vec::new( ) ;
    let len : usize = inline.len( ) ;
    for i in 0..len - 1 {
       for j in i + 1..len {
	  let substr : &str = &inline[i..j] ;
	  substrings.push( substr ) ;
       }
    }
    let mut selected : Vec<&str> = substrings.into_iter( ).filter( |&s|
	  is_nice( s ) ).collect( ) ;
    let sel_len : usize = selected.len( ) ;
    if sel_len > 0 {
       let str_cmp = |a: &str , b: &str| a.chars( ).count( ).cmp( &b.chars( ).
	     count( ) ) ;
       selected.sort_by( |arg0: &&str , arg1: &&str| str_cmp(arg0 , arg1 )) ;
       println!("{:?}" , selected[sel_len - 1] ) ;
    }
    else {
       println!("\"\"") ;
    }
}
