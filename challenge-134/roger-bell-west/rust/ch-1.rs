use permutator::Permutation;

#[test]
fn test_ex1() {
    assert_eq!(pandigital(10),vec![1023456789, 1023456798, 1023456879, 1023456897, 1023456978, 1023456987, 1023457689, 1023457698, 1023457869, 1023457896]);
}

fn pandigital(count: u32) -> Vec<u32> {
    let mut digits=1;
    let mut cc=1;
    while cc < count {
        digits+=1;
        cc *= digits;
        if digits > 10 {
            println!("too large");
            return vec![];
        }
    }
    let mut template=(2..=9).collect::<Vec<u32>>();
    template.reverse();
    template.push(0);
    template.push(1);
    let mut lead=vec![0;10-digits as usize];
    lead.clone_from_slice(&template[(digits as usize)..]);
    lead.reverse();
    let l=lead.into_iter().map(|i| i.to_string()).collect::<Vec<String>>().join("");
    template.resize(digits as usize,0);
    let mut o=vec![];
    template.permutation().for_each(|p| {
        o.push((&p).into_iter().map(|i| i.to_string()).collect::<Vec<String>>().join(""));
    });
    o.sort();
    o.resize(count as usize,"".to_string());
    o.into_iter().map(|i| (l.clone()+&i).parse().unwrap()).collect::<Vec<u32>>()
}
