use std::io ;

fn find_length( input : &str , mut current : usize ) -> usize {
   let mut balances : Vec<i32> = Vec::new( ) ;
   let mut balance : i32 = 1 ;
   balances.push( balance ) ;
   let len : usize = input.chars( ).count( ) ;
   current += 1 ;
   while current < len {
      let letter : char = input.chars( ).nth( current ).unwrap( ) ;
      if letter == '(' {
	 balance += 1 ;
      }
      else {
	 balance -= 1 ;
      }
      if balance < 0 {
	 break ;
      }
      balances.push( balance ) ;
      current += 1 ;
   }
   let howmany : usize = balances.iter( ).filter( |&n| *n == 0 ).count( ) ;
   let result : usize ;
   if howmany == 0 {
      result = 0 ;
   }
   else {
      if howmany == 1 {
	 let pos : usize = balances.iter( ).position( |n| *n == 0 ).unwrap( ) ;
         result = pos + 1 ;
      }
      else {
	 let mut cur = balances.len( ) - 1 ;
	 while balances[cur] != 0 {
	    cur -= 1 ;
	 }
	 result = cur + 1 ;
      }
   }
   result 
}

fn main() {
    println!("Enter a string consisting of parentheses only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let parens : &str = inline.trim( ) ;
    let mut lengths : Vec<usize> = Vec::new( ) ;
    let len : usize = parens.chars().count( ) ;
    for pos in 0..len - 1 {
       let letter : char = parens.chars( ).nth( pos ).unwrap( ) ;
       if letter == '(' {
	  let result = find_length( parens , pos ) ;
	  lengths.push( result ) ;
       }
    }
    println!("{}" , lengths.into_iter().max( ).unwrap( ) ) ;
}
