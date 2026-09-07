use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter some words!");
    let mut inline : String = String::new( ) ;
    io::stdin().read_line( &mut inline ).unwrap( ) ;
    let firstwords : Vec<&str> = inline.trim( ).split_whitespace( ).
       collect( ) ;
    println!("Enter some more words!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let secondwords : Vec<&str> = secondline.trim( ).split_whitespace().
       collect( ) ;
    let mut frequencies : HashMap<&str , usize> = HashMap::new( ) ;
    for w in firstwords {
       frequencies.entry( w ).and_modify( |counter| *counter += 1 ).
          or_insert( 1 ) ;
    }
    for w in secondwords {
       frequencies.entry( w ).and_modify( |counter| *counter += 1 ).
          or_insert( 1 ) ;
    }
    println!("{:?}" , frequencies.keys().filter( |&s| *frequencies.get( &*s).
             unwrap( ) == 1 ).collect::<Vec<&&str>>() ) ;
}
