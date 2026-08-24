use std::io ;

fn parse_number( number : &str ) -> Vec<String> {
   let mut parseparts : Vec<String> = Vec::new( ) ;
   let pointpos : usize = number.chars().position( |c| c == '.').unwrap();
   let numberstring : String = number.into( ) ;
   let s : String = numberstring[0..pointpos].to_string( ) ;
   parseparts.push( s ) ;
   match number.chars( ).position( |c| c == '(' ) {
      Some( pos ) => { let s1 : String = numberstring[pointpos + 1..pos].to_string() ;
                       parseparts.push( s1);
                       let s2 : String = numberstring[pos + 1 .. numberstring.
                          len( ) - 1].to_string( ) ;
                      parseparts.push( s2 ) ;
                     },
      None        => { parseparts.push( "".into( ) ) ;
                       parseparts.push( "".into( ) ) ;
                     }
   } ;
   parseparts
}

fn are_same( first : &str , second : &str ) -> bool {
   let mut first_after_expand : String = String::new( ) ;
   let mut second_after_expand : String = String::new( ) ;
   let firstparts : Vec<String> = parse_number( first ) ;
   let secondparts : Vec<String> = parse_number( second ) ;
   let result : bool = {
      first_after_expand += firstparts[0].as_str() ;
      first_after_expand.push( '.' ) ;
      second_after_expand += secondparts[0].as_str( ) ;
      second_after_expand.push( '.' ) ;
      if (firstparts[1].chars( ).all( |c| c == '9' ) || firstparts[1].
         chars( ).count( ) == 0 ) && firstparts[2].chars().all( |c| 
         c == '9' ) {
            let firsttotal : usize = firstparts[0].parse::<usize>( ).unwrap();
            let secondtotal : usize = secondparts[0].parse::<usize>().
               unwrap( ) ;
            secondtotal == firsttotal + 1 && secondparts[1] == "" && 
               secondparts[2] == ""
     }
     else {
        first_after_expand += &firstparts[1].clone( ) ;
        second_after_expand += &secondparts[1].clone() ;
        if firstparts[2].chars( ).count( ) == 2 {
           for _ in 0..4 {
              first_after_expand += &firstparts[2].clone( ) ;
           }
        }
        if firstparts[2].chars( ).count( ) == 3 {
           for _ in 0..3 {
              second_after_expand += &firstparts[2].clone( ) ;
           }
        }
        if secondparts[2].chars( ).count( ) == 2 {
           for _ in 0..4 {
              second_after_expand += &secondparts[2].clone( ) ;
           }
        }
        if secondparts[2].chars( ).count( ) == 3 {
           for _ in 0..3 {
              second_after_expand += &secondparts[2].clone( ) ;
           }
        }
        let shorter : String ;
        let longer : String ;
        if first_after_expand.len( ) <= second_after_expand.len( ) {
           shorter = first_after_expand ;
           longer = second_after_expand ;
        }
        else {
           shorter = second_after_expand ;
           longer = first_after_expand ;
        }
        &longer[0..shorter.len( )] == &shorter[..]
     }
   } ;
   result
}

fn main() {
    println!("Enter a first rational number!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    println!("Enter a second rational number!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let first : &str = inline.trim( ) ;
    let second : &str = secondline.trim( ) ;
    println!("{}" , are_same( first , second ) ) ;
}
