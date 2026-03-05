use std::io ;

fn is_valid_address( addressparts : &Vec<&str> ) -> bool {
   addressparts.len( ) == 4 && addressparts.iter( ).all( |p|
         p.parse::<u8>( ).is_ok( ) ) 
}

fn to_binary_string( mut number : u8 ) -> String {
   let mut binary : String = String::new( ) ;
   while number != 0 {
      let remainder : u8 = number % 2 ;
      if remainder == 1 {
         binary.insert( 0 , '1' ) ;
      }
      else {
         binary.insert( 0 , '0' ) ;
      }
      number /= 2 ;
   }
   //left pad the binary string to a length of 8 , it's an octet!
   while binary.len( ) != 8 {
      binary.insert( 0 , '0' ) ;
   }
   binary 
}

fn main() {
    println!("Enter an IPv4 address!");
    let mut address_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut address_line ).unwrap( ) ;
    let addr : &str = address_line.trim_end( ) ;
    let addr_parts : Vec<&str> = addr.split( ".").collect( ) ;
    println!("Enter an IPv4 network in ClDR format!") ;
    let mut network_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut network_line).unwrap( ) ;
    let network : &str = network_line.trim_end( ) ;
    let network_parts : Vec<&str> = network.split( "/").collect( ) ;
    let first_part_cidr : Vec<&str> = network_parts[0].split( ".").
       collect( ) ;
    //assume result to be false unless the address parts of IPv4 and CIDR are 
    //correct , the networt part of the CIDR address is in the correct range
    //and the network parts of both addresses coincide
    let mut result : bool = false ;
    if is_valid_address( &addr_parts ) && is_valid_address( &first_part_cidr ) {
       if network_parts[1].parse::<u8>( ).is_ok( ) {
          let netp : u8 = network_parts[1].parse::<u8>( ).unwrap( ) ;
          if netp <= 32 {//build up the four octets of the IPv4 address
             let mut total_net_binary : String = String::new( ) ;
             for p in &addr_parts {
                let num = p.parse::<u8>( ).unwrap( ) ;
                let binstr = to_binary_string( num ) ;
                let binstring : &str = binstr.as_str( ) ;
                total_net_binary.push_str( binstring ) ;
             }
             let mut total_cidr_binary : String = String::new( ) ;
             //build up the four octets of the first part of the CIDR address
             for p in &first_part_cidr {
                let num = p.parse::<u8>( ).unwrap( ) ;
                let binstr = to_binary_string( num ) ;
                let binstring : &str = binstr.as_str( ) ;
                total_cidr_binary.push_str( binstring ) ;
             }
             //do the leftmost netp bytes coincide ?
             result = &total_net_binary[0..netp as usize] ==
                &total_cidr_binary[0..netp as usize] ;
          }
       }
    }
    println!("{}" , result ) ;
}
