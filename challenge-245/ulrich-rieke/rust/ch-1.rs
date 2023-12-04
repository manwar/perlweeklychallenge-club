use std::io ;

fn main() {
    println!("Enter some computer languages, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let languages : Vec<&str> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ) ).collect( ) ;
    println!("Enter as many popularity indices, separated by blanks!") ;
    let mut snd_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut snd_line ).unwrap( ) ;
    let second_line : &str = &*snd_line ;
    let popularity : Vec<u8> = second_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<u8>( ).unwrap( ) ).collect( ) ;
    let mut contest : Vec<(u8 , &str)> = Vec::new( ) ;
    let mut iter = popularity.iter( ).zip(languages.iter( ) ) ;
    while let Some( ( &i , &lang ) ) = iter.next( ) {
       contest.push( (i , lang ) ) ;
    }
    contest.sort_by( | a , b | a.0.cmp( &b.0 ) ) ;
    print!("(" ) ;
    contest.iter( ).for_each( | p | print!("{:?} " , p.1 ) ) ;
    println!(")" ) ;
}
