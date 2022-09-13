#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        commonpath(vec![
            "/a/b/c/1/x.pl",
            "/a/b/c/d/e/2/x.pl",
            "/a/b/c/d/3/x.pl",
            "/a/b/c/4/x.pl",
            "/a/b/c/d/5/x.pl"
        ]),
        "/a/b/c"
    );
}

fn commonpath(p: Vec<&str>) -> String {
    let mut pa: Vec<Vec<String>> = Vec::new();
    let mut pl: Vec<usize> = Vec::new();
    for sp in p {
        let q = sp.split('/').map(|x| x.to_string()).collect::<Vec<String>>();
        pl.push(q.len());
        pa.push(q);
    }
    let mut out: Vec<String> = Vec::new();
    for cl in 0..*pl.iter().min().unwrap() {
        let mut ex = false;
        let tx = &pa[0][cl];
        for pe in &pa {
            if &pe[cl] != tx {
                ex = true;
                break;
            }
        }
        if ex {
            break;
        }
        out.push(tx.to_string());
    }
    out.join("/")
}
