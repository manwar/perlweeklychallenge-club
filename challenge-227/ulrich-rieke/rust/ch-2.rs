use std::io ;
use substring::Substring ;
use std::collections::HashMap ;

fn roman_to_arabic( numberstring : &str , numbertable : &HashMap<&str , 
      u32> ) -> u32 {
   let len : usize = numberstring.len( ) ;
   if let Some( n ) = numbertable.get( &numberstring ) {
      return *n ;
   }
   else {
      let mut start : usize = 0 ;
      let mut end : usize = start + 1 ;
      let mut sum : u32 = 0 ;
      while end < len + 1 {
	 let mut substr : &str = numberstring.substring( start , end ) ; 
	 if numbertable.get( &substr ).is_some( ) {
	    end += 1 ;
	 }
	 else {
	    end -= 1 ;
	    substr = numberstring.substring( start , end ) ;
	    sum += numbertable.get( &substr ).unwrap( ) ;
	    start = end ;
	    end = start + 1 ;
	 }
      }
      end -= 1 ;
      let substr : &str = numberstring.substring( start , end ) ;
      sum += numbertable.get( &substr ).unwrap( ) ;
      sum 
   }
}

fn arabic_to_roman( mut number : u32 , inversed_table : &HashMap<u32 , &str> )
   -> String {
      let mut roman : String = String::new( ) ;
      while number != 0 {
	 let num : u32 = match number {
	    size if size >= 1000 => size / 1000 * 1000 ,  
	    size if size < 1000 && (size >= 100) => size / 100 * 100 ,
	    size if size < 100 && size >= 10 => size / 10 * 10 ,
	    size if size < 10 => size ,
	    _ => 5 ,
	 } ;
	 let value : &str = inversed_table.get( &num).unwrap( ) ;
	 let valstr : String = value.to_string( ) ;
	 roman.push_str( &valstr ) ;
	 number -= num ;
      }
      roman 
}

fn main() {
   let mut roman_arab : HashMap<&str , u32> = HashMap::new( ) ;
   roman_arab.insert( "M" , 1000 ) ;
   roman_arab.insert( "MM" , 2000 ) ;
   roman_arab.insert( "MMM" , 3000 ) ;
   roman_arab.insert( "C" , 100 ) ;
   roman_arab.insert( "CC" , 200 ) ;
   roman_arab.insert( "CCC" , 300 ) ;
   roman_arab.insert( "CD" , 400 ) ;
   roman_arab.insert( "D" , 500 ) ;
   roman_arab.insert( "DC" , 600 ) ;
   roman_arab.insert( "DCC" , 700 ) ;
   roman_arab.insert( "DCCC" , 800 ) ;
   roman_arab.insert( "CM" , 900 ) ;
   roman_arab.insert( "X" , 10 ) ;
   roman_arab.insert( "XX" , 20 ) ;
   roman_arab.insert( "XXX" , 30 ) ;
   roman_arab.insert( "XL" , 40 ) ;
   roman_arab.insert( "L" , 50 ) ;
   roman_arab.insert( "LX" , 60 ) ;
   roman_arab.insert( "LXX" , 70 ) ;
   roman_arab.insert( "LXXX" , 80 ) ;
   roman_arab.insert( "XC" , 90 ) ;
   roman_arab.insert( "I" , 1 ) ;
   roman_arab.insert( "II" , 2 ) ;
   roman_arab.insert( "III" , 3 ) ;
   roman_arab.insert( "IV" , 4 ) ;
   roman_arab.insert( "V" , 5 ) ;
   roman_arab.insert( "VI" , 6 ) ;
   roman_arab.insert( "VII" , 7 ) ;
   roman_arab.insert( "VIII" , 8 ) ;
   roman_arab.insert( "IX" , 9 ) ;
   let mut arab_roman : HashMap<u32 , &str> = HashMap::new( ) ;
   for ( key , val ) in roman_arab.iter( ) {
      arab_roman.insert( *val , key.clone( ) ) ;
   }
   println!("Please enter a 2 -term string in Roman numerals!" ) ;
   let mut inline : String = String::new( ) ;
   io::stdin( ).read_line( &mut inline ).unwrap( ) ;
   let entered_line : &str = &*inline ;
   let terms : Vec<&str> = entered_line.split_whitespace( ).map( | s | 
	 s.trim( ) ).collect( ) ;
   let first_roman : &str = terms[ 0 ] ;
   let second_roman : &str = terms[ 2 ] ;
   let operator : &str = terms[ 1 ] ;
   let first_term : u32 = roman_to_arabic( &first_roman , &roman_arab ) ;
   let second_term : u32 = roman_to_arabic( &second_roman , &roman_arab ) ;
   let result : String = match operator {
      "+" => {
	 let res : u32 = first_term + second_term ;
	 if res > 3999 {
	    "non potest".to_string( ) 
	 }
	 else {
	    arabic_to_roman( res , &arab_roman ) 
	 }
      } ,
      "-" => {
	 if let Some( v ) = first_term.checked_sub( second_term ) {
	    if v == 0 {
	       "nulla".to_string( ) 
	    }
	    else {
	       arabic_to_roman( v , &arab_roman ) 
	    }
	 }
	 else {
	    "non potest".to_string( ) 
	 }
      } ,
      "*" => {
	 let res : u32 = first_term * second_term ;
	 if res > 3999 {
	    "non potest".to_string( ) 
	 }
	 else {
	    arabic_to_roman( res , &arab_roman ) 
	 }
      } ,
      "/" => {
	 if let Some( v ) = first_term.checked_div( second_term ) {
	    if  v * second_term == first_term { 
	       arabic_to_roman( v , &arab_roman ) 
	    }
	    else {
	       "non potest".to_string( )
	    }
	 }
	 else {
	    "non potest".to_string( ) 
	 }
      } ,
      "**" => {
	 let res : u32 = first_term.pow( second_term ) ;
	 if res > 3999 {
	    "non potest".to_string( ) 
	 }
	 else {
	    arabic_to_roman( res , &arab_roman ) 
	 }
      } ,
      _ => "".to_string( ) ,
   } ;
   let changed = entered_line.trim( ) ;
   let mut inline = changed.to_string( ) ;
   inline.push_str( &" = ".to_string( ) ) ;
   inline.push_str( &result ) ;
   println!("{}" , inline ) ;
}
