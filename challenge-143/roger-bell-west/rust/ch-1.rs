use regex::Regex;
use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(exval("10 + 20 - 5"), 25);
}

#[test]
fn test_ex2() {
    assert_eq!(exval("(10 + 20 - 5) * 2"), 50);
}

#[test]
fn test_ex3() {
    assert_eq!(exval("10 + 20 - 5 * 2"), 20);
}

fn operate(op: char, a: i32, b: i32) -> i32 {
    if op == '+' {
        return b + a;
    } else if op == '-' {
        return b - a;
    } else if op == '*' {
        return b * a;
    }
    println!("Invalid operator {}", op);
    0
}

fn exval(expr: &str) -> i32 {
    let op = ['(', ')', '+', '-', '*'];
    let mut opp: HashMap<char, usize> = HashMap::new();
    let mut rec = vec!["-?[0-9]+".to_string()];
    for (i, o) in op.iter().enumerate() {
        opp.insert(*o, i);
        let ss = "\\".to_string() + &o.to_string();
        rec.push(ss);
    }
    let ret =
        Regex::new(&("(".to_string() + &rec.join("|") + &")".to_string()))
            .unwrap();
    let ren =
        Regex::new(&("^".to_string() + &rec[0] + &"$".to_string())).unwrap();
    let mut opstack: Vec<char> = vec![];
    let mut valstack: Vec<i32> = vec![];
    for tm in ret.find_iter(expr) {
        let token = tm.as_str();
        let tokchar = token.chars().nth(0).unwrap();
        if ren.is_match(token) {
            valstack.push(token.parse::<i32>().unwrap());
            println!("{:?}", valstack);
        } else if token == "(" {
            opstack.push('(');
        } else if token == ")" {
            while opstack[opstack.len() - 1] != '(' {
                let a=valstack.pop().unwrap();
                let b=valstack.pop().unwrap();
                valstack.push(operate(opstack.pop().unwrap(),a,b));
            }
            opstack.pop().unwrap();
        } else if opp.contains_key(&tokchar) {
            while opstack.len() > 0
                && opp.get(&opstack[opstack.len() - 1]).unwrap()
                    >= opp.get(&tokchar).unwrap()
            {
                let a=valstack.pop().unwrap();
                let b=valstack.pop().unwrap();
                valstack.push(operate(opstack.pop().unwrap(),a,b));
            }
            opstack.push(tokchar);
        } else {
            println!("Bad token");
        }
    }
    while opstack.len() > 0 {
                let a=valstack.pop().unwrap();
                let b=valstack.pop().unwrap();
                valstack.push(operate(opstack.pop().unwrap(),a,b));
    }
    valstack[0]
}
