fn separate( number : u32 ) -> String {
    let mut numberstring : String = number.to_string( ) ;
    let len : usize = numberstring.len( ) ;
    if len <= 3 {
        numberstring
    }
    else {
        let leading_part : usize = len % 3 ;
        if leading_part != 0 {
            numberstring.insert( leading_part , ',' ) ;
            let mut nextpos : usize = leading_part + 3 ;
            while nextpos < len {
                numberstring.insert( nextpos + 1 , ',' ) ;
                nextpos += 3 ;
            }
        }
        else {
            let mut nextpos : usize = 3 ;
            while nextpos < len {
                numberstring.insert( nextpos , ',' ) ;
                nextpos += 3 ;
            }
        }
        numberstring
    }
}

fn main() {
    println!("{:?}" , separate( 123 ));
    println!("{:?}" , separate( 1234 ) ) ;
    println!("{:?}" , separate( 1000000 )) ;
    println!("{:?}" , separate( 1 ) ) ;
    println!("{:?}" , separate( 12345 ) ) ;
}
