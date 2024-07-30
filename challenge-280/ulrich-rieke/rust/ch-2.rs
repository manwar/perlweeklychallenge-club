use std::io ;

fn main() {
    println!("Enter a string with vertical bars!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    //anything with up to one bar can be directly evaluated
    if entered_line.chars( ).filter( | &c | c == '|' ).count( ) <= 1 {
       println!("{}" , entered_line.chars( ).filter( | &c | c == '*' ).
	     count( ) ) ;
    }
    //otherwise, we assume we have not seen a bar yet
    //if this is true, we keep adding new chars that are not '|'
    //if it is a bar then we would delete everything from the last bar
    //if we have already seen a bar, otherwise we add the bar
    else {
       let mut bar_seen : bool = false ;
       let mut for_analysis : String = String::new( ) ;
       for c in entered_line.chars( ) {
	  if c == '|' {
	     if bar_seen {
		let pos = for_analysis.find( '|' ).unwrap( ) ;
		let first_part = &for_analysis[..pos] ;
                for_analysis = first_part.into( ) ;
		bar_seen = false ;

	     }
	     else {
		bar_seen = true ;
		for_analysis.push( '|' ) ;
	     }
	  }
	  else {
	     for_analysis.push( c ) ;
	  }
       }
       let result = &for_analysis[..] ;
       println!("{}" , result.chars( ).filter( | &c | c == '*' ).
	     count( ) ) ;
    }
}
