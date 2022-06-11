use itertools::Itertools;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        missingpermutations(
            [
                "PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE", "EPRL", "EPLR",
                "ERPL", "ERLP", "ELPR", "ELRP", "RPEL", "RPLE", "REPL", "RELP",
                "RLPE", "RLEP", "LPER", "LPRE", "LEPR", "LRPE", "LREP"
            ]
            .iter()
            .map(|&s| s.into())
            .collect()
        ),
        vec!["LERP"]
    );
}

fn missingpermutations(list: Vec<String>) -> Vec<String> {
    let mut perms: HashSet<String> = HashSet::new();
    for p in list[0].chars().permutations(list[0].len()) {
        perms.insert(p.iter().collect::<String>());
    }
    for p in list {
        perms.remove(&p);
    }
    let mut out: Vec<String> = Vec::new();
    for s in perms.iter() {
        out.push((*s.clone()).to_string());
    }
    return out;
}
