use std::io ;

fn main() {
    println!("Enter some strings separated by whitespace!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    println!("Enter some more strings separated by whitespace!" ) ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let firstwords : Vec<&str> = firstline.trim( ).split_whitespace( ).
       collect( ) ;
    let secondwords : Vec<&str> = secondline.trim( ).split_whitespace( ).
       collect( ) ;
    let mut common : usize = 0 ;
    for w in firstwords {
       if secondwords.contains( &w ) {
	  common += 1 ;
       }
    }
    println!("{}" , common) ;
}
