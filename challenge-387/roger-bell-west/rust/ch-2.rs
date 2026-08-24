use counter::Counter;
use regex::Regex;

#[test]
fn test_ex1() {
    assert_eq!(atomscount("((N2O)3(H2O)2)2"), "H8N12O10");
}

#[test]
fn test_ex2() {
    assert_eq!(atomscount("Mg3(PO4)2"), "Mg3O8P2");
}

#[test]
fn test_ex3() {
    assert_eq!(atomscount("(((H)2)3)4"), "H24");
}

#[test]
fn test_ex4() {
    assert_eq!(atomscount("NaCl3(O2(S10)2)2Mg"), "Cl3MgNaO4S40");
}

#[test]
fn test_ex5() {
    assert_eq!(atomscount("Z2Y3(X2W)2"), "W2X4Y3Z2");
}

fn atomscount(a: &str) -> String {
    let reac = Regex::new(r"^([A-Z][a-z]?)([0-9]+)").unwrap();
    let rea1 = Regex::new(r"^([A-Z][a-z]?)").unwrap();
    let reop = Regex::new(r"^\(").unwrap();
    let recpc = Regex::new(r"^\)([0-9]+)").unwrap();
    let mut i = 0;
    let mut stack: Vec<Counter<&str>> = Vec::new();
    stack.push(Counter::new());
    while i < a.len() {
        let sa = &a[i..];
        if let Some(caps) = reac.captures(sa) {
            let element = caps.get(1).unwrap().as_str();
            let ct = caps.get(2).unwrap().as_str().parse::<usize>().unwrap();
            let mut c = stack.pop().unwrap();
            c[&element] += ct;
            stack.push(c);
            i += caps.get(0).unwrap().as_str().len();
        } else if let Some(caps) = rea1.captures(sa) {
            let element = caps.get(1).unwrap().as_str();
            let mut c = stack.pop().unwrap();
            c[&element] += 1;
            stack.push(c);
            i += caps.get(0).unwrap().as_str().len();
        } else if reop.is_match(sa) {
            stack.push(Counter::new());
            i += 1;
        } else if let Some(caps) = recpc.captures(sa) {
            let ct = caps.get(1).unwrap().as_str().parse::<usize>().unwrap();
            let oc = stack.pop().unwrap();
            let mut c = stack.pop().unwrap();
            for (k, v) in oc.iter() {
                c[k] += v * ct;
            }
            stack.push(c);
            i += caps.get(0).unwrap().as_str().len();
        } else {
            panic!("Invalid token");
        }
    }
    let mut outstr = String::new();
    let mut kl = stack[0].keys().collect::<Vec<_>>();
    kl.sort();
    for k in kl {
        outstr.push_str(k);
        let n = stack[0][k];
        if n > 1 {
            outstr.push_str(&n.to_string());
        }
    }
    outstr
}
