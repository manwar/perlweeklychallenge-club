use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
            s.parse::<i32>().unwrap( )).collect( ) ;
    numbers.sort( ) ;
    let len : usize = numbers.len( ) ;
    let mut pairs : Vec<(i32 , i32)> = Vec::new( ) ;
    for i in 0..len - 1 {
        for j in i + 1 .. len {
            pairs.push( (numbers[i] , numbers[j] ) ) ;
        }
    }
    let min_diff : i32 = pairs.iter( ).map( |p| p.1 - p.0 ).min( ).unwrap( ) ;
    let result : Vec<&(i32 , i32)> = pairs.iter( ).filter( |p| p.1 - p.0 == 
            min_diff).collect( ) ;
    println!("{:?}" , result ) ;
}
