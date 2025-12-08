use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
            s.parse::<i32>( ).unwrap( )).collect( ) ;
    if numbers.iter( ).all( |n| *n == numbers[0] ) {
        println!("0") ;
    }
    else {
        let maxi : i32 = *numbers.iter( ).max( ).unwrap( ) ;
        let mini : i32 = *numbers.iter( ).min( ).unwrap( ) ;
        let maxiplace : usize = numbers.iter( ).position( |n| *n == maxi ).unwrap( ) ;
        numbers.remove( maxiplace ) ;
        let miniplace : usize = numbers.iter( ).position( |n| *n == mini ).unwrap( ) ;
        numbers.remove( miniplace ) ;
        let average : f32 = numbers.iter( ).map( |i| *i as f32).sum::<f32>( ) / 
            (numbers.len( ) as f32 ) ;
        println!("{}" , average ) ;
    }
}
