#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(fractionaladditionsubstraction("1/2+3/2"), "2/1");
}

#[test]
fn test_ex2() {
    assert_eq!(fractionaladditionsubstraction("-5/2-3/2"), "-4/1");
}

#[test]
fn test_ex3() {
    assert_eq!(fractionaladditionsubstraction("5/3-5/3"), "0/1");
}

#[test]
fn test_ex4() {
    assert_eq!(fractionaladditionsubstraction("10/10-1/10+2/5"), "13/10");
}

#[test]
fn test_ex5() {
    assert_eq!(fractionaladditionsubstraction("1/6+1/6+1/6"), "1/2");
}

#[derive(Clone, Copy, Debug)]
struct Rational {
    pub n: i32,
    pub d: i32,
}

impl Rational {
    pub fn new(n: i32, d: i32) -> Rational {
        Rational { n: n, d: d }
    }

    pub fn stringify(&mut self) -> String {
        let xf = Self::gcd(self.n, self.d);
        if xf > 1 {
            self.n /= xf;
            self.d /= xf;
        }
        return format!("{}/{}", self.n, self.d);
    }

    pub fn add(&self, other: &Rational) -> Rational {
        let xd = Self::lcm(self.d, other.d);
        let xn = self.n * xd / self.d + other.n * xd / other.d;
        Rational { n: xn, d: xd }
    }

    pub fn gcd(m0: i32, n0: i32) -> i32 {
        let mut m = m0;
        let mut n = n0;
        while n != 0 {
            let t = n;
            n = m % n;
            m = t;
        }
        m
    }

    pub fn lcm(m: i32, n: i32) -> i32 {
        m / Self::gcd(m, n) * n
    }
}

fn fractionaladditionsubstraction(a: &str) -> String {
    let mut terms = Vec::new();
    let mut state = 0;
    let mut n = 0i32;
    let mut num = 0i32;
    let mut sign = 0i32;
    let cv = a.chars().collect::<Vec<_>>();
    let mut i = 0;
    while i < cv.len() {
        match state {
            0 => {
                match cv[i] {
                    '+' => {
                        state = 0;
                        i += 1;
                    },
                    '0' .. '9' => {
                        sign = 1;
                        state = 1;
                        n = cv[i].to_digit(10).unwrap() as i32;
                        i += 1;
                    },
                    '-' => {
                        sign = -1;
                        state = 1;
                        n = 0;
                        i += 1;
                    },
                    _ => {
                        panic!["Unknown state-0 character"];
                    },
                };
            },
            1 => {
                match cv[i] {
                    '0' .. '9' => {
                        n *= 10;
                        n += cv[i].to_digit(10).unwrap() as i32;
                        i += 1;
                    },
                    '/' => {
                        num = n * sign;
                        n = 0;
                        state = 2;
                        i += 1;
                    },
                    _ => {
                        panic!["Unknown state-1 character"];
                    },
                };
            },
            2 => {
                match cv[i] {
                    '0' .. '9' => {
                        n *= 10;
                        n += cv[i].to_digit(10).unwrap() as i32;
                        i += 1;
                    },
                    _ => {
                        terms.push(Rational::new(num, n));
                        state = 0;
                    },
                };
            },
            _ => {},
        };
    }
    if state == 2 {
                   terms.push(Rational::new(num, n));
    }
    let mut out = terms[0].clone();
    for nt in terms.iter().skip(1) {
        out = out.add(nt);
    }
    out.stringify()
}
