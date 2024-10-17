use itertools::Itertools;
use counter::Counter;

fn main() {
    let mut deck: Vec<(usize, usize)> = Vec::new();
    for suit in 0 ..= 3 {
        for rank in 1 ..= 13 {
            deck.push((rank, suit));
        }
    }
    let mut hands: Counter<usize> = Counter::new();
    for hand in deck.iter().combinations(5) {
        let mut bin: usize = 0;
        let ranks = hand.iter().map(|x| x.0).sorted().collect::<Vec<_>>();
        let ranksc = ranks.iter().collect::<Counter<_>>();
        let ranksk = ranksc.values().sorted().rev().collect::<Vec<_>>();
        let suits = hand.iter().map(|x| x.1).sorted().collect::<Vec<_>>();
        let suitsc = suits.iter().collect::<Counter<_>>();
        let suitsk = suitsc.values().sorted().rev().collect::<Vec<_>>();
        // Can't generate 5 of a kind.
        // Royal flush
        if  suitsc.len() == 1 &&
            ranks == vec![1, 10, 11, 12, 13] {
                bin = 2;
            }
        // Straight flush
        if bin == 0 &&
            suitsc.len() == 1 &&
            ranks.iter().min().unwrap() + 4 == *ranks.iter().max().unwrap() {
                bin = 2;
            }
        // Four of a kind
        if bin == 0 && *ranksk[0] == 4 {
            bin = 3;
        }
        // Full house
        if bin == 0 && *ranksk[0] == 3 && *ranksk[1] == 2 {
            bin = 4;
        }
        // Flush
        if bin == 0 && *suitsk[0] == 5 {
            bin = 5;
        }
        // Straight
        if bin == 0 &&
        // match full rank struct
            (
                (ranks[0] + 1 == ranks[1] &&
                 ranks[1] + 1 == ranks[2] &&
                 ranks[2] + 1 == ranks[3] &&
                 ranks[3] + 1 == ranks[4])
                    ||
                    ranks == vec![1, 10, 11, 12, 13]
            ) {
            bin = 6;
        }
        // Three of a kind
        if bin == 0 && *ranksk[0] == 3 {
            bin = 7;
        }
        // Two pair
        if bin == 0 && *ranksk[0] == 2 && *ranksk[1] == 2 {
            bin = 8;
        }
        // One pair
        if bin == 0 && *ranksk[0] == 2 {
            bin = 9;
        }
        // Anything else is High card
        if bin == 0 {
            bin = 10;
        }
        hands[&bin] += 1;
    }
    let mut tot = 0;
    for k in hands.keys().sorted() {
        println!("{} {}",k,hands[&k]);
        tot += hands[&k]
    }
    println!("total {}",tot);
}
