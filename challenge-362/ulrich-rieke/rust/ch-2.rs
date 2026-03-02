use std::collections::HashMap ;
use std::io ;

fn convert_number( number : i32 , conversions : &HashMap<i32 , &str>) 
   -> String {
      let numberstring : String = number.to_string( ) ;
      let len : usize = numberstring.len( ) ;
      let mut result : String = String::new( ) ;
      if len == 1 { //we have a value in the conversion table
         result += conversions.get( &number ).unwrap( ) ;
      }
      if len == 2 {
         if number % 10 == 0 { //value in the conversion table
            result += conversions.get( &number ).unwrap( ) ;
         }
         else {
            let num : i32 = (number / 10 ) * 10 ;
            result += conversions.get( &num ).unwrap( ) ;
            result += &("-".to_owned() + conversions.get( &(number % 10 )).unwrap( )) ;
         }
      }
      if len == 3 {
         if number % 100 == 0 { //value in the conversion table
            result.push_str( conversions.get( &(number / 100 )).unwrap( )) ;
            result.push_str( " hundred" ) ;      
         }
         else {
            result.push_str( conversions.get( &(number / 100 )).unwrap( )) ;
            result.push_str( " hundred and " ) ;
            let remainder : i32 = number % 100 ;
            let res : String = convert_number( remainder , &conversions ) ;
            let part : &str = res.as_str( ) ;
            result += part ;
         }
      }
      if len > 3 && len < 7 {
         let res : String = convert_number( number / 1000 , &conversions ) ;
         let part : &str = res.as_str( ) ;
         result += part ;
         if number % 1000 == 0 {
            result += " thousand" ;
         }
         else {
            result += " thousand " ;
            let res = convert_number( number % 1000 , &conversions ) ;
            let part : &str = res.as_str( ) ;
            result += part ;
         }
      }
      if len > 6 && len < 10 {
         let res : String = convert_number( number / 1000000 , &conversions ) ;
         let part : &str = res.as_str( ) ;
         result += part ;
         if number % 1000000 == 0 {
            result += " million" ;
         }
         else {
            result += " million " ;
            let res : String = convert_number( number % 1000000 , &conversions ) ;
            let part : &str = res.as_str( ) ;
            result += part ;
         }
      }
      result 
}

fn compose( number : i32 , conversions : &HashMap<i32 , &str>) -> String {
   let mut converted_number : String = String::new( ) ;
   if number < 0 {
      converted_number += "minus " ;
   }
   let res : String = convert_number( number.abs( ) , &conversions ) ;
   let part : &str = res.as_str( ) ;
   converted_number += part ;
   converted_number
}

fn main() {
    println!("Enter some integer values separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<i32> = inline.trim_end( ).split_whitespace( ).map( |s|
          s.parse::<i32>( ).unwrap( )).collect( ) ;
    let conversion_table : HashMap<i32 , &str> = HashMap::from([
          (0 , "zero") , 
          (1 , "one") , 
          (2 , "two") , 
          (3 , "three") , 
          (4 , "four") , 
          (5 , "five") , 
          (6 , "six" ) ,
          (7 , "seven" ) , 
          (8 , "eight" ) , 
          (9 , "nine" ) ,
          (10 , "ten" ) , 
          (11 , "eleven" ) ,
          (12 , "twelve" ) , 
          (13 , "thirteen" ) , 
          (14 , "fourteen" ) ,  
          (15 , "fifteen" ) , 
          (16 , "sixteen" ) , 
          (17 , "seventeen" ) , 
          (18 , "eighteen" ) , 
          (19 , "nineteen" ) , 
          (20 , "twenty" ) , 
          (30 , "thirty" ) , 
          (40 , "forty" ) , 
          (50 , "fifty" ) , 
          (60 , "sixty" ) , 
          (70 , "seventy" ) , 
          (80 , "eighty") , 
          (90 , "ninety")]) ;
    numbers.sort_by_key( |n| compose( *n , &conversion_table) ) ;
    println!("{:?}" , numbers ) ;
}
