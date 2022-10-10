#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        recomposemaskcode(vec!["ab-cde-123", "123.abc.420", "3abc-0010.xy"]),
        vec!["xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        recomposemaskcode(vec!["1234567.a", "a-1234-bc", "a.b.c.d.e.f"]),
        vec!["xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f"]
    );
}

fn recomposemaskcode(list: Vec<&str>) -> Vec<String> {
    let mut out = Vec::new();
    for ins in list {
        let mut count: u8 = 0;
        let mut os = String::new();
        for c in ins.chars() {
            os.push(match c {
                '0'..='9' | 'a'..='z' => {
                    if count < 4 {
                        count += 1;
                        'x'
                    } else {
                        c
                    }
                }
                _ => c,
            });
        }
        out.push(os);
    }
    out
}
