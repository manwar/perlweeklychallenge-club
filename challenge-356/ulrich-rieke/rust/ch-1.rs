use std::io ;

fn main() {
    println!("Enter an integer greater than 3!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let wanted_len : usize = inline.trim_end( ).parse::<usize>( ).unwrap( ) ;
    let mut kolakoski : Vec<u8> = vec![] ;
    let mut i : usize = 1 ;
    while kolakoski.len( ) < wanted_len {
        if kolakoski.is_empty( ) {
            kolakoski.push( 1 ) ;
        }
        else {
            let mut pushed : bool = false ;
            if kolakoski.len( ) < i {
                kolakoski.push( i as u8 ) ;
                pushed = true ;
            }
            if i % 2 == 1 {
                if ! pushed {
                    for _ in 0..kolakoski[i - 1] {
                        kolakoski.push( 1 ) ;
                    }
                }
                else {
                    kolakoski.push( 1 ) ;
                }
            }
            else {
                if ! pushed {
                    for _ in 0..kolakoski[i - 1] {
                        kolakoski.push( 2 ) ;
                    }
                }
                else {
                    kolakoski.push( 2 ) ;
                }
            }
        }
        i += 1 ;
    }
    println!("{}" , kolakoski.into_iter( ).take( wanted_len ).filter( |&n| n ==
                1 ).count( ) ) ;
}
