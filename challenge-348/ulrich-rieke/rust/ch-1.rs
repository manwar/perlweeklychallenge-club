fn find_solution( word : &str ) -> bool {
    let vowels : Vec<char> = vec!['A' , 'a' , 'E' , 'e' , 'I' , 'i' , 'O' , 'o' , 
        'U' , 'u'] ;
    let mut first_vowels : usize = 0 ;
    let mut second_vowels : usize = 0 ;
    let len : usize = word.chars( ).count( ) ;
    for c in word.chars( ).take( len / 2 ) {
        if vowels.contains( &c ) {
            first_vowels += 1 ;
        }
    }
    for c in word.chars( ).skip( len / 2 ).take( len / 2) {
        if vowels.contains( &c ) {
            second_vowels += 1 ;
        }
    }
    first_vowels == second_vowels
}

fn main() {
    println!("{}" , find_solution( "textbook"));
    println!("{}" , find_solution( "book" ) ) ;
    println!("{}" , find_solution( "AbCdEfGh" )) ;
    println!("{}" , find_solution( "rhythmmyth" )) ;
    println!("{}" , find_solution( "UmpireeAudio" ) ) ;
}
