use std::io ;

//find all time periods with the corresponding distance, that is
//for months it's 29 , for weeks 6 , starting from a given index
fn find_subarrays( days : &Vec<u32> , index : usize , distance : u32)
  -> Vec<Vec<u32>> {
  let mut all_subarrays : Vec<Vec<u32>> = Vec::new( ) ;
  if days[ days.len( ) - 1 ] - days[0] <= distance {
      all_subarrays.push( days.clone( ) ) ;
  }
  else {
      if index > 0 {
    let mut an_array : Vec<u32> = Vec::new( ) ;
    for i in 0..index {
        an_array.push( days[ i ] ) ;
    }
    all_subarrays.push( an_array ) ;
      }
      let len : usize = days.len( ) ;
      let mut pos : usize = index ;
      let mut subarray : Vec<u32> = Vec::new( ) ;
      let mut startpos : usize = pos ;
      while pos < len {
    if days[ pos ] - days[startpos] <= distance {
        subarray.push( days[ pos ] ) ;
    }
    else {
        all_subarrays.push( subarray.clone( ) ) ;
        subarray.clear( ) ;
        startpos = pos ;
        pos -= 1 ;
    }
    pos += 1 ;
      }
      if subarray.len( ) > 0 {
    all_subarrays.push( subarray.clone( ) ) ;
      }
  }
  all_subarrays
}

//for all the subperiods, see whether the sub period qualifies for a
//month card( distance > 6 and < 30 , there are more days in the subarray
//than the monthlimit, that is the number of days when it is cheaper to
//buy a month ticket than week or day tickets
//when the difference between the first and last value in a subarray
//would also qualify for a week ticket, see if there are more days in
//the subarray then the week limit
fn find_value( the_array : &Vec<Vec<u32>> , costs : &(u32 , u32 , u32) ,
      distance : u32) -> u32 {
  let mut all_prices : Vec<u32> = Vec::new( ) ;
  let len : usize = the_array.len( ) ;
  //consider all subarrays as either months or weeks, depending on the
  //distance
  match distance {
      29 => all_prices.push( (len as u32 ) * costs.2 ) ,//all are months
      6  => all_prices.push( (len as u32 ) * costs.1 ),//all are weeks
      _  => { },
  }
  let month_limit : u32 = costs.2.checked_div( costs.0 ).unwrap( ) ;//a subarray
  //should contain more days than this limit so that pays off to buy
  //a month ticket
  let week_limit : u32 = costs.1.checked_div( costs.0 ).unwrap( ) ;
  //same for weeks
  let mut price : u32 = 0 ;//holds the total price for all subperiods
  for i in 0..len {
      let sublen : usize = the_array[i].len( ) ;
      let subdiff : u32 = the_array[ i ][sublen - 1] - the_array[ i ][0] ;
      match distance {
    29 => {
        if subdiff > 6 {//possible month
          if (sublen as u32 ) > month_limit {//pays off as month
          price += costs.2 ;//add month price
          }
          else {
          price += ( sublen as u32 ) * costs.0 ;//take day tick.
          }
        }
        else { //we are looking at possible weeks
          if ( sublen as u32 ) > week_limit {//week ticket pays off
          price += costs.1 ;
          }
          else {
          price += ( sublen as u32 ) * costs.0 ;//day tickets
          }
        }
    } ,
    6 => {
        if ( sublen as u32) > week_limit {
          price += costs.1 ;
        }
        else {
          price += ( sublen as u32 ) * costs.0 ;
        }
    } ,
    _ => { }
      }
  }
  all_prices.push( price ) ;
  *all_prices.iter( ).min( ).unwrap( )
}

fn main( ) {
  println!("Enter the prices for a day, week and month card, separated by blanks!") ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let costline : &str = &*inline ;
  let the_costs : Vec<u32> = costline.split_whitespace( ).map( | s |
    s.trim( ).parse::<u32>( ).unwrap( ) ).collect( ) ;
  let costs : (u32 , u32 , u32) = (the_costs[ 0 ] , the_costs[1] , the_costs[ 2 ] ) ;
  println!("Enter the days you want to travel!" ) ;
  let mut dayline : String = String::new( ) ;
  io::stdin( ).read_line( &mut dayline ).unwrap( ) ;
  let the_days : &str = &*dayline ;
  let days : Vec<u32> = the_days.split_whitespace( ).map( | s | s.trim( ).
    parse::<u32>( ).unwrap( ) ).collect( ) ;
  let mut total_ticket_prices : Vec<u32> = Vec::new( ) ;
  let len : usize = days.len( ) ;
  total_ticket_prices.push( (len as u32) * costs.0 ) ; //we only buy day tickets!
  //we look for valid month periods
  let month_arrays : Vec<Vec<u32>> = find_subarrays( &days , 0 , 29 ) ;
  total_ticket_prices.push( find_value( &month_arrays, &costs , 29 )) ;
  //find end of first array
  let first_len : usize = month_arrays[0].len( ) ;
  let first_end : u32 = month_arrays[0][first_len - 1] ;
  let upto : usize = days.iter( ).position( | &d | d == first_end ).unwrap( ) + 1 ;
  if upto < days.len( ) - 1 {
      for pos in 0..upto {
    let arrays_month : Vec<Vec<u32>> =  find_subarrays( &days, pos , 29 ) ;
    total_ticket_prices.push( find_value( &arrays_month, &costs , 29 ) ) ;
      }
  }
  let week_arrays : Vec<Vec<u32>> = find_subarrays( &days, 0 , 6 ) ;
  let price : u32 = find_value( &week_arrays, &costs, 6 ) ;
  total_ticket_prices.push( price ) ;
  let first_len : usize = week_arrays[0].len( ) ;
  let first_end : u32 = week_arrays[0][first_len - 1] ;
  let upto : usize = days.iter( ).position( | &d | d == first_end ).unwrap( ) + 1 ;
  if upto < days.len( ) - 1 {
      for pos in 0..upto {
    let arrays_week : Vec<Vec<u32>> = find_subarrays( &days, pos, 6 ) ;
    let current_price : u32 = find_value( &arrays_week , &costs, 6 ) ;
    total_ticket_prices.push( current_price ) ;
      }
  }
  println!("{:?}" , total_ticket_prices.iter( ).min( ).unwrap( ) ) ;
}
