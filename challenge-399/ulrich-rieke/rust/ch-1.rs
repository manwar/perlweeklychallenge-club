use std::io ;
use std::collections::HashMap ;

//create all contiguous substrings of a given minimal length
fn create_substrings( word : &String , l : usize ) -> Vec<String> {
   let len : usize = word.len( ) ;
   let mut substrings : Vec<String> = Vec::new( ) ;
   for start in 0..len - l {
      for end in start + l .. len {
         let substring = word[start..end].to_string( ) ;
         substrings.push( substring.clone( ) ) ;
      }
   }
   substrings
}

//for every substring , calculate the frequencies of the letters
fn calculate_letter_freq( word : &str ) -> HashMap<char , usize> {
   let mut frequencies : HashMap<char , usize> = HashMap::new( ) ;
   for c in word.chars( ) {
      *frequencies.entry( c ).or_insert( 0 ) += 1 ;
   }
   frequencies 
}

fn most_and_less_frequent( frequencies : &HashMap<char , usize> ) -> (usize , usize ) {
   let greatest_freq : usize = *frequencies.values( ).max( ).unwrap( ) ;
   let mut rest_total : usize = 0 ;
   for (_ , v) in frequencies {
      if *v != greatest_freq {
         rest_total += *v ;
      }
   }
   (greatest_freq , rest_total )
}

fn main() {
    println!("Enter a word with capital letters and a positive number!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let elements : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let word : &str = elements[0] ;
    let k : usize = elements[1].parse::<usize>().unwrap( ) ;
    //if the frequencies are all 1 , then the longest run is equal to k + 1 
    let mut letterfrequencies : HashMap<char , usize> = HashMap::new( ) ;
    for c in word.chars( ) {
       *letterfrequencies.entry( c ).or_insert( 0 ) += 1 ;
    }
    if letterfrequencies.values( ).all( |n| *n == 1 ) {
       println!("{}" , k + 1 ) ;
    }
    else {
       if letterfrequencies.len( ) == 1 { //all letters are the same!
          println!("{}" , word.chars( ).count( ) ) ;
       }
       else {
          //create all possible substrings of the word and count the letter 
          //frequencies in them . the sum of the frequencies of the less 
          //frequent letters should equal k , and the winner is the word with
          //the greatest sum of greatest frequency and k
          let reduced : String = inline.trim( ).to_string( ) ;
          let all_substrings : Vec<String> = create_substrings( &reduced , 
                k ) ;
          let mut all_freqs : Vec<HashMap<char , usize>> = Vec::new( ) ;
          for s in all_substrings {
             let freq = calculate_letter_freq( &s[..] ) ;
             all_freqs.push( freq.clone( ) ) ;
          }
          let frequency_pairs : Vec<(usize , usize)> = all_freqs.into_iter( ).
             map( |f| most_and_less_frequent( &f ) ).collect( ) ;
          let mut selected : Vec<(usize , usize )> = frequency_pairs.into_iter().
             filter( |&p| p.1 == k ).collect( ) ;
          selected.sort_by( |a , b| (b.0 + b.1).cmp( &(a.0 + a.1))) ;
          println!("{}" , selected[0].0 + selected[0].1 ) ;
       }
    }
}
