use std::io ;

fn main() {
    println!("Enter some numbers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<f32> = inline.trim( ).split_whitespace( ).
        map( |s| s.parse::<f32>().unwrap( )).collect( ) ;
    numbers.sort_by( |a , b| a.partial_cmp( &b ).unwrap( ) ) ;
    let len : usize = numbers.len( ) ;
    let mut differences : Vec<f32> = Vec::new( ) ;
    for i in 1..len {
        differences.push( numbers[i] - numbers[i - 1]) ;
    }
    println!("{}" , differences.clone().into_iter( ).all( |n|
                n.eq( &differences[0] ))) ;
}
