#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(goatlatin("I love Perl"), "Imaa ovelmaaa erlPmaaaa");
}

#[test]
fn test_ex2() {
    assert_eq!(
        goatlatin("Perl and Raku are friends"),
        "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        goatlatin("The Weekly Challenge"),
        "heTmaa eeklyWmaaa hallengeCmaaaa"
    );
}

fn goatlatin(a: &str) -> String {
    let mut out = Vec::new();
    for (ix, word) in a.split(' ').enumerate() {
        let mut c = word.chars().collect::<Vec<_>>();
        let cc = c[0].to_ascii_lowercase();
        match cc {
            'a' | 'e' | 'i' | 'o' | 'u' => {}
            _ => {
                let co = c[0];
                let k = c.split_off(1);
                c = k;
                c.push(co);
            }
        };
        let mut nw = c.iter().collect::<String>();
        nw.push_str("ma");
        for _ in 0..=ix {
            nw.push('a');
        }
        out.push(nw);
    }
    out.join(" ")
}
