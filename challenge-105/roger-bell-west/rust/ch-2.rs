use regex::Regex;

// Cargo.toml needs:
// [dependencies]
// regex = "1"

#[test]
fn test_ex1() {
    assert_eq!(ng("Katie"),"Katie, Katie, bo-batie\nBonana-fanna fo-fatie\nFee fi mo-matie\nKatie!");
}

#[test]
fn test_ex2() {
    assert_eq!(ng("Anna"),"Anna, Anna, bo-banna\nBonana-fanna fo-fanna\nFee fi mo-manna\nAnna!");
}

fn ng (name: &str) -> String {
    let re=Regex::new(r"(?i)^[bcdfghjklmnpqrstvwxz]*").unwrap();
    let mut tail: String=re.replace(name,"").to_string();
    if tail == name {
        tail.make_ascii_lowercase();
    }
    return format!("{}, {}, bo-b{}\nBonana-fanna fo-f{}\nFee fi mo-m{}\n{}!",name,name,tail,tail,tail,name);
}
