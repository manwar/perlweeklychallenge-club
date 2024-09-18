use std::io ;
use fancy_regex::Regex ; //this crate only supports Perl's backreferences!

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let re1 = Regex::new(r"[a-z]").unwrap( ) ;
    let re2 = Regex::new(r"[A-Z]").unwrap( ) ;
    let re3 = Regex::new(r"\d").unwrap( ) ;
    let re4 = Regex::new(r"(.)\1\1").unwrap( ) ;
    let mut totalsteps : u16 = 0 ;
    let len : u16 = entered_line.len( ) as u16 ;
    if len < 6 {
       totalsteps += 6 - len ;
    }
    if  ! re1.is_match( entered_line ).unwrap( )  {
       if len >= 6 {
	  totalsteps += 1 ;
       }
    }
    if ! re2.is_match( entered_line ).unwrap( ) {
       if len >= 6 {
	  totalsteps += 1 ;
       }
    }
    if ! re3.is_match( entered_line ).unwrap( ) {
       if len >= 6 {
	  totalsteps += 1 ;
       }
    }
    if re4.is_match( entered_line ).unwrap( ) {
       totalsteps += 1 ;
    }
    println!("{}" , totalsteps ) ;
}
