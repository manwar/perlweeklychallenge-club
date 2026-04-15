#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        validtag("Cooking with 5 ingredients!"),
        "#cookingWithIngredients"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(validtag("the-last-of-the-mohicans"), "#thelastofthemohicans");
}

#[test]
fn test_ex3() {
    assert_eq!(validtag("  extra spaces here"), "#extraSpacesHere");
}

#[test]
fn test_ex4() {
    assert_eq!(validtag("iPhone 15 Pro Max Review"), "#iphoneProMaxReview");
}

#[test]
fn test_ex5() {
    assert_eq!(validtag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"), "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn");
}

fn validtag(a: &str) -> String {
    let mut p = String::new();
    p.push('#');
    let mut up = false;
    for c in a.chars() {
        if c.is_alphabetic() {
            let mut cc = c;
            if up {
                cc.make_ascii_uppercase();
                up = false;
            } else {
                cc.make_ascii_lowercase()
            }
            p.push(cc);
        } else if c == ' ' && p.len() > 1 {
            up = true;
        }
    }
    if p.len() > 100 {
        p.replace_range(100.., "");
    }
    p
}
