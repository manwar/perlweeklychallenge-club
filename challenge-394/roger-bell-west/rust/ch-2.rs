#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        alternatingvowelsconsonants(vec!["relocate", "delocate", "allocate"]),
        vec!["locate"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        alternatingvowelsconsonants(vec!["apple", "banana", "cherry"]),
        Vec::<String>::new()
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        alternatingvowelsconsonants(vec!["navigate", "cavity", "gravity"]),
        vec!["avi"]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        alternatingvowelsconsonants(vec!["pedalgia", "pedalboard", "pedantic"]),
        vec!["peda"]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        alternatingvowelsconsonants(vec![
            "schoolmaster",
            "schoolhouse",
            "schooling"
        ]),
        vec!["ho", "ol"]
    );
}

fn common_substring(a0: Vec<&str>) -> Vec<String> {
    let mut a = a0.clone();
    a.sort_unstable_by_key(|x| x.len());
    let mut results = Vec::new();
    for l in (1..a[0].len()).rev() {
        for offset in 0..=a[0].len() - l {
            let mut m = true;
            let sample = &a[0][offset..offset + l];
            for ax in a.iter().skip(1) {
                match ax.find(sample) {
                    None => {
                        m = false;
                        break;
                    }
                    _ => (),
                };
            }
            if m {
                results.push(sample.to_string());
            }
        }
        /*
        use this for _longest_ common substring
        if results.len() > 0 { break; }
         */
    }
    results
}

fn is_avc(a: &str) -> bool {
    let mut valid = true;
    let mut laststate = false;
    for (i, c) in a.chars().enumerate() {
        let thisstate = match c {
            'a' | 'e' | 'i' | 'o' | 'u' => true,
            _ => false,
        };
        if i > 0 && thisstate == laststate {
            valid = false;
            break;
        }
        laststate = thisstate;
    }
    valid
}

fn alternatingvowelsconsonants(a: Vec<&str>) -> Vec<String> {
    let candidates = common_substring(a).clone();
    let c2 = candidates.iter().filter(|x| is_avc(x)).collect::<Vec<_>>();
    if c2.len() > 0 {
        let l = c2[0].len();
        let c3 = c2
            .into_iter()
            .map(|x| x.clone())
            .filter(|x| x.len() == l)
            .collect::<Vec<_>>();
        c3.into_iter().map(|x| x.clone()).collect::<Vec<String>>()
    } else {
        Vec::<String>::new()
    }
}
