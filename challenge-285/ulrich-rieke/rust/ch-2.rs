use std::io ;

fn main() {
    println!("Enter an amount of money in cents!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str().trim( ) ;
    let amount : u32 = entered_line.parse::<u32>( ).unwrap( ) ;
    let mut combis : u64 = 0 ;
    for pennies in 0..=amount {
       for nickels in 0..=amount/5 {
	  for dimes in 0..=amount / 10 {
	     for quarters in 0..=amount / 25 {
		for half_dollars in 0..=amount / 50 {
		   if pennies + nickels * 5 + dimes * 10 + quarters * 25 + 
		      half_dollars * 50 == amount {
			 combis += 1 ;
		      }
		}
	     }
	  }
       }
    }
    println!("{}" , combis ) ;
}
