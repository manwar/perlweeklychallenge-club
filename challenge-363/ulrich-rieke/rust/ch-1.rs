fn analyze_string( sentence : &str ) -> bool {
   use std::collections::HashMap ;
   let conversion_table : HashMap<usize , &str> = HashMap::from([
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
          (20 , "twenty" )]) ;
   let all_words : Vec<&str> = sentence.split_whitespace( ).collect( ) ;
   let vowels : &str = "AEIOUaeiou" ;
   let mut vowelcount : usize = 0 ;
   let mut consocount : usize = 0 ;
   all_words[0].chars( ).for_each( |c| {
         if vowels.contains( c ) {
            vowelcount += 1 ;
         }
         else {
            consocount += 1 ;
         }
         } ) ;
   *conversion_table.get( &vowelcount).unwrap( ) == all_words[2] && 
      *conversion_table.get( &consocount ).unwrap( ) == all_words[5]
}

fn main() {
    println!("{}" , analyze_string( "aa - two vowels and zero consonants"));
    println!("{}" , analyze_string( "iv - one vowel and one consonant")) ;
    println!("{}" , analyze_string( "hello - three vowels and two consonants")) ;
    println!("{}" , analyze_string( "aeiou - five vowels and zero consonants")) ;
    println!("{}" , analyze_string( "aei - three vowels and zero consonants")) ;
}
