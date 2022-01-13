#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(p_gp("3/5"), vec!["3/2", "1/2"]);
}

#[test]
fn test_ex2() {
    assert_eq!(p_gp("4/3"), vec!["1/3", "1/2"]);
}

#[derive(Clone, Copy)]
struct Fraction {
    pub n: u32,
    pub d: u32,
}

impl Fraction {
    pub fn new() -> Fraction {
        Fraction { n: 1, d: 1 }
    }

    pub fn get_parent(&mut self) -> Fraction {
        let mut n = self.n;
        let mut d = self.d;
        if n < d {
            d -= n;
        } else {
            n -= d;
        }
        Fraction { n, d }
    }

    pub fn stringify(&mut self) -> String {
        return format!("{}/{}", self.n, self.d);
    }

    pub fn set_from_string(&mut self, s: &str) -> Fraction {
        let q = s.split("/").collect::<Vec<&str>>();
        self.n = q[0].parse::<u32>().unwrap();
        self.d = q[1].parse::<u32>().unwrap();
        *self
    }
}

fn p_gp(s: &str) -> Vec<String> {
    let mut f = Fraction::new().set_from_string(s);
    let mut out: Vec<String> = vec![];
    for _ in 1..=2 {
        f = f.get_parent();
        out.push(f.stringify());
    }
    out
}
