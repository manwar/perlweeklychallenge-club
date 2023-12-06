use rand::seq::SliceRandom;
use rand::thread_rng;

fn main() {
    let mut candidates = (1..=49).collect::<Vec<u32>>();
    let mut rng = thread_rng();
    candidates.shuffle(&mut rng);
    candidates.resize(6, 0);
    candidates.sort();
    println!("{:?}", candidates);
}
