use std::io ;
use std::collections::HashMap ;

#[derive(Clone)]
enum Dir {U , D , L , R}

fn up( point : (i32 , i32) ) -> (i32 , i32) {
    (point.0 , point.1 + 1)
}

fn down( point : (i32 , i32) ) -> (i32 , i32) {
    (point.0 , point.1 - 1)
}

fn left( point : (i32 , i32) ) -> (i32 , i32) {
    (point.0 - 1 , point.1)
}

fn right( point : (i32 , i32 ) ) -> (i32 , i32) {
    (point.0 + 1 , point.1)
}

fn chooser ( point : (i32 , i32) , direction : &Dir ) -> (i32 , i32) {
    let target : (i32 , i32 ) = match direction {
        Dir::U => up( point ) ,
        Dir::D => down( point ) ,
        Dir::L => left( point ) , 
        Dir::R => right( point )
    } ;
    target 
}

fn main() {
    let the_dirs : HashMap<char , Dir> = HashMap::from([('U' ,
      Dir::U) , ('D' , Dir::D) , ('L' , Dir::L) ,
            ('R' , Dir::R)]) ;          
    println!("Enter a sequence of directions U , D , L or R!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let all_dirs : &str = inline.trim( ) ;
    let start : (i32 , i32) = (0 , 0) ;
    let mut current : (i32 , i32) = (0 , 0) ;
    for c in all_dirs.chars( ) {
        current = chooser( current , &the_dirs.get( &c ).unwrap( ).
                clone( ) ) ;
    }
    println!("{}" , current == start) ;
}
