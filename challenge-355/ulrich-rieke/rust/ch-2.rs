use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim_end( ).split_whitespace( ).
        map( |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let result : bool ;
    if numbers.len( ) < 3 {
        result = false ;
    }
    else {
        let maxint : i32 = *numbers.iter( ).max( ).unwrap( ) ;
        let maxplace : usize = numbers.iter( ).position( |n| *n == maxint ).
            unwrap( ) ;
        if maxplace == numbers.len( ) - 1 || maxplace == 0_usize {
            result = false ;
        }
        else {
            let mut rising_differences : Vec<i32> = Vec::new( ) ;
            for i in 0..maxplace {
                rising_differences.push( numbers[i] - numbers[i + 1] ) ;
            }
            let mut falling_differences : Vec<i32> = Vec::new( ) ;
            for i in maxplace..numbers.len( ) - 1 {
                falling_differences.push( numbers[i] - numbers[i + 1] ) ;
            }
            result = rising_differences.into_iter( ).all( |n| n < 0 ) &&
                falling_differences.into_iter().all( |n| n > 0 ) ;
        }
    }
    println!("{}" , result ) ;
}
