use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Debug)]
struct Candidate
{
    s : String,
}

impl Eq for Candidate {}

impl PartialEq for Candidate {
    fn eq(&self, other: &Self) -> bool
    {
        self.s.len() == other.s.len()
    }
}

impl Ord for Candidate {
    fn cmp(&self, other: &Self) -> Ordering
    {
        if self.s.len() == other.s.len()
        {
            // if lengths are equal then I need to check the first char, otherwise they are just equal
            return self.s.chars().nth(0).unwrap_or('0').cmp(&other.s.chars().nth(0).unwrap_or('0'));
        }

        return self.s.len().cmp(&other.s.len());
    }
}

impl PartialOrd for Candidate {
 fn partial_cmp(&self, other: &Candidate) -> Option<Ordering>
    {
        Some(self.cmp(other))
    }   
}

fn largest_same_digits(s : &'static str) -> String
{
    let filtered : String = s.chars().filter(|&c| c != '0').collect();
    let mut start = 0;
    let mut candidates : BinaryHeap<Candidate> = BinaryHeap::new();
    while start < filtered.len()
    {
        let front = filtered.chars().nth(start).expect("empty string"); // this can be unchecked since start will always be < filtered.len()
        let run : String = filtered[start..].chars().take_while(|&c| c == front).collect();
        start += run.len();
        candidates.push(Candidate { s: run });
    }

     if candidates.len() == 0{
        return "".to_string();
    }

    return candidates.pop().expect("empty heap").s;
}


pub fn main()
{
    println!("E1");
    println!("{}", largest_same_digits("6777133339"));

    println!("E2");
    println!("{}", largest_same_digits("1200034"));

    println!("E3");
    println!("{}", largest_same_digits("44221155"));

    println!("E4");
    println!("{}", largest_same_digits("88888"));

    println!("E5");
    println!("{}", largest_same_digits("11122233"));


    println!("Extra6");
    println!("{}", largest_same_digits(""));

    println!("Extra7");
    println!("{}", largest_same_digits("00000000000000"));

    println!("Extra8");
    println!("{}", largest_same_digits("000000000000001"));

    println!("Extra9");
    println!("{}", largest_same_digits("900000000000000"));


    println!("Extra10 :-)");
    println!("{}", largest_same_digits("abc1"));
}
