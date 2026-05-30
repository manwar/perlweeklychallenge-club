use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(singlecommonword(vec!["apple", "banana", "cherry"], vec!["banana", "cherry", "date"]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(singlecommonword(vec!["a", "ab", "abc"], vec!["a", "a", "ab", "abc"]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(singlecommonword(vec!["orange", "lemon"], vec!["grape", "melon"]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(singlecommonword(vec!["test", "test", "demo"], vec!["test", "demo", "demo"]), 0);
}

#[test]
fn test_ex5() {
    assert_eq!(singlecommonword(vec!["Hello", "world"], vec!["hello", "world"]), 1);
}

fn singlecommonword(a: Vec<&str>, b: Vec<&str>) -> usize {
    let ac = a.iter().collect::<Counter<_>>();
    let bc = b.iter().collect::<Counter<_>>();
    let mut total = 0;
    for (w, ca) in ac {
        if ca == 1 && bc.contains_key(&w) && bc[&w] == 1 {
            total += 1;
        }
    }
    total
}
