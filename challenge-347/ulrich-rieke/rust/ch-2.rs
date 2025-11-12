use std::io ;
use regex::Regex ;

fn handle_rest( term : &str ) -> String {
    let len : usize = term.chars( ).count( ) ;
    let mut result : String = String::new( ) ;
    if len == 2 || len == 3 {
        result = term.into( ) ;
    }
    else {
        for c in term.chars( ).take( 2 ) {
            result.push( c ) ;
        }
        result.push( '-') ;
        for c in term.chars( ).skip( 2 ) {
            result.push( c ) ;
        }
    }
    result 
}

fn main() {
    println!("Enter a phone number consisting of digits , dashes and spaces!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let before : &str = inline.trim( ) ;
    let re = Regex::new(r"\s|\-").unwrap( ) ;
    let after = re.replace_all( before , "" ) ;
    let mut result : String = String::new( ) ;
    let len : usize = after.chars( ).count( ) ;
    if len <= 4 {
        println!("{:?}" , handle_rest( &after )) ;
    }
    else {
        let mut partnumber : usize = len / 3 ;
        let restlen : usize = len % 3 ;
        if restlen != 0 && restlen < 2 {
            partnumber -= 1 ;
        }
        let mut i : usize = 0 ;
        let mut passed : usize = 0 ;
        while i < partnumber {
            for c in after.chars( ).skip( passed ).take( 3 ) {
                result.push( c ) ;
            }
            result.push( '-' ) ;
            passed += 3 ;
            i += 1 ;
        }
        let restlen : usize = len - partnumber * 3 ;
        if restlen == 0 {
            result.pop( ) ;
            println!("{:?}" , result ) ;
        }
        else {
            let mut last_part : String = String::new( ) ;
            for c in after.chars( ).skip(partnumber * 3 ) {
                last_part.push( c ) ;
            }
            let end_term : &str = last_part.as_str( ) ;
            let processed_rest : String = handle_rest( end_term ) ;
            let rest : &str = processed_rest.as_str( ) ;
            result.push_str( rest ) ;
            println!("{:?}" , result ) ;
        }
    }
}
