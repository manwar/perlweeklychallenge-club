#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        longestabsolutepath("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"),
        0
    );
}

#[test]
fn test_ex2() {
    assert_eq!(longestabsolutepath("file1.txt\nfile2.ext\na.png"), 9);
}

#[test]
fn test_ex3() {
    assert_eq!(
        longestabsolutepath(
            "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"
        ),
        38
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        longestabsolutepath("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"),
        14
    );
}

#[test]
fn test_ex5() {
    assert_eq!(longestabsolutepath("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"), 32);
}

fn longestabsolutepath(fs: &str) -> usize {
    let mut components = Vec::new();
    let mut maxlen = 0;
    for entry in fs.split("\n") {
        let parts = entry.split("\t").collect::<Vec<_>>();
        let depth = parts.len();
        while components.len() < depth {
            components.push(0);
        }
        while components.len() >= depth {
            components.pop();
        }
        components.push(parts[parts.len() - 1].len());
        if let Some(_) = parts[parts.len() - 1].find(".") {
            maxlen = std::cmp::max(
                maxlen,
                components.iter().sum::<usize>() + components.len() - 1,
            );
        }
    }
    maxlen
}
