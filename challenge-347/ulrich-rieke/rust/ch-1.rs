use regex::Regex ;

fn convert( term : &str ) -> String {
    let mut converted : String = String::new( ) ;
    converted.push('0' ) ;
    converted.push_str( term ) ;
    converted 
}

fn parse_date( date : &str ) -> String {
    let months : Vec<&str> = vec!["Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , 
        "Jul" , "Aug" , "Sep" , "Oct" , "Nov" , "Dec"] ;
    let re = Regex::new(r"(?<d>\d{1,2})[strdnh]{2}\s(?<m>\w{3})\s(?<y>[12]\d{3})").
        unwrap( ) ;
    let caps = re.captures( date ).unwrap( ) ;
    let day : &str = &caps["d"] ;
    let month : &str = &caps["m"] ;
    let year : &str = &caps["y"] ;
    let mut rearranged : String = String::new( ) ;
    rearranged.push_str( year ) ;
    rearranged.push( '-' ) ;
    let mut revised : String ;
    let monthindex : usize = months.iter( ).position( |mo| *mo == month).unwrap( ) + 1;
    let monthval : String = monthindex.to_string( ) ;
    let monthrev : &str = monthval.as_str( ) ;
    if monthrev.chars( ).count( ) == 1 {
        revised = convert( monthrev ) ;
        let monthpart : &str = revised.as_str( ) ;
        rearranged.push_str( monthpart ) ;
    }
    else {
        rearranged.push_str( monthrev ) ;
    }
    rearranged.push( '-' ) ;
    if day.chars( ).count( ) == 1 {
        revised = convert( day ) ;
        let dayrev = revised.as_str( ) ;
        rearranged.push_str( dayrev ) ;
    }
    else {
        rearranged.push_str( day ) ;
    }
    rearranged 
}

fn main() {
    println!("{:?}" , parse_date( "1st Jan 2025" )) ;
    println!("{:?}" , parse_date( "22nd Feb 2025" )) ;
    println!("{:?}" , parse_date( "15th Apr 2025" )) ;
    println!("{:?}" , parse_date( "23rd Oct 2025" )) ;
    println!("{:?}" , parse_date( "31st Dec 2025" )) ;
}
