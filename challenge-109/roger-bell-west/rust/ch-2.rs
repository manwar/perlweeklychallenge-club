use permutohedron::LexicalPermutation;

#[test]
fn test_ex1() {
    let q=foursquare((1..=7).collect::<Vec<i32>>());
    assert_eq!(q[0],q[2]+q[3]);
    assert_eq!(q[1]+q[2],q[4]+q[5]);
    assert_eq!(q[3]+q[4],q[6]);
}

fn foursquare(src: Vec<i32>) -> Vec<i32> {
    let mut t=src;
    let mut sol: Vec<i32>=vec![];
    t.sort();
    loop {
        let b=t[1]+t[2]+t[3];
        if t[0]+t[1]==b {
            let c=t[3]+t[4]+t[5];
            if b==c && c == t[5]+t[6] {
                sol=t;
                break;
            }
        }
        if !t.next_permutation() {
            break;
        }
    }
    return sol;
}
