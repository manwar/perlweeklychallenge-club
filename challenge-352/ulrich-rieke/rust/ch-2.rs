fn convert( numbers : &Vec<u8> ) -> Vec<bool> {
    let mut numberstring : String = String::new( ) ;
    let mut result : Vec<bool> = Vec::new( ) ;
    let len : usize = numbers.len( ) ;
    let mut pos : usize = 0 ;
    while numbers[pos] == 0 {
        result.push( true ) ;
        pos += 1 ;
    }
    for n in pos..len {
        let numstring : String = numbers[n].to_string( ) ;
        numberstring.push_str( &numstring ) ;
        let currentstr : &str = numberstring.as_str( ) ;
        let converted : u32 = u32::from_str_radix( currentstr , 2 ).unwrap( ) ;
        result.push( converted % 5 == 0 ) ;
    }
    result 
}

fn main() {
    println!("{:?}" , convert( &vec![0 , 1 , 1 , 0 , 0 , 1 , 0 , 1 , 1 , 1]));
    println!("{:?}" , convert( &vec![ 1 , 0 , 1 , 0 , 1 , 0])) ;
    println!("{:?}" , convert( &vec![0 , 0 , 1 , 0 , 1])) ;
    println!("{:?}" , convert( &vec![1 , 1 , 1 , 1 , 1])) ;
    println!("{:?}" , convert( &vec![ 1 , 0 , 1 , 1 , 0 , 1 , 0 , 0 , 1 , 1])) ;
}
