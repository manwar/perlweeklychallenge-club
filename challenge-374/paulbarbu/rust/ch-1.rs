use std::collections::HashSet;

//we assume only ASCII
fn ranges_vowels(s: &'static str) {
    for i in 5..1+s.len()
    {
        for r in s.as_bytes().windows(i)
        {
            let vowels = HashSet::from(['a', 'e', 'i', 'o', 'u']);

            // let mut set = HashSet::<char>::with_capacity(5);
            // for c in r
            // {
            //     set.insert(char::from(*c));
            // }

            let set : HashSet::<char> = r.iter().map(|&x| { char::from(x)}).collect();

            if vowels == set
            {
                println!("{:?}", str::from_utf8(r));
            }
        }
    }
}

pub fn main()
{
    println!("1");
    ranges_vowels("aeiou");
    println!("2");
    ranges_vowels("aaeeeiioouu");
    println!("3");
    ranges_vowels("aeiouuaxaeiou");
    println!("4");
    ranges_vowels("uaeiou");
    println!("5");
    ranges_vowels("aeioaeioa");
}


