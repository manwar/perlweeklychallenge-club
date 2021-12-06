// Cargo.toml:
// [dependencies]
// rand = "0.8.4"

use rand::Rng;
use std::sync::mpsc::channel;
use std::thread::{sleep, spawn};
use std::time;

#[test]
fn text_ex1() {
    let mut a = vec![];
    let mut rng = rand::thread_rng();
    for _i in 1..=10 {
        a.push(rng.gen_range(1..=100) as u32);
    }
    let mut b = a.clone();
    b.sort();
    assert_eq!(sleepsort(a), b);
}

fn sleepsort(n: Vec<u32>) -> Vec<u32> {
    let (sender, receiver) = channel();
    let mut handles = vec![];
    for &i in &n {
        let ss = sender.clone();
        handles.push(spawn(move || {
            sleep(time::Duration::from_millis(i as u64));
            ss.send(i).unwrap();
        }));
    }
    for handle in handles {
        handle.join().unwrap();
    }
    let mut ri = receiver.iter();
    let mut r = vec![];
    for _i in n {
        r.push(ri.next().unwrap());
    }
    r
}
