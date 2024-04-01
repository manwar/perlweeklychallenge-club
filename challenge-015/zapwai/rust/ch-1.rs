fn fill_weak_strong(primes :&Vec<i32>, avg :&Vec<i32>, weak :&mut Vec<i32>, strong :&mut Vec<i32>, other :&mut Vec<i32>) {
    weak.push(3);
    for i in 1 .. primes.len() - 1 {
	if primes[i] < avg[i] {
	    weak.push(primes[i]);
	}
	else if primes[i] > avg[i] {
	    strong.push(primes[i]);
	}
	else {
	    other.push(primes[i]);
	}
    }
}

fn fill_primes(primes :&mut Vec<i32>, num :i32) {
    primes.push(2);
    let mut current = 2;
    while primes.len() < num as usize{
	current += 1;
	let mut cnt = 0;
	for i in 0 .. primes.len() {
	    let p = primes[i];
	    if current % p == 0 {
		cnt += 1;
	    }
	}
	if cnt == 0 {
	    primes.push(current);
	}
    }
}

fn avg_primes(primes :&Vec<i32>, avg :&mut Vec<i32>) {
    avg.push(0);	/* First and last are garbage values */
    let prime_len = primes.len();
    for i in 1 .. prime_len - 1 {
	avg.push((primes[i + 1] + primes[i - 1]) / 2);
    }
    avg.push(0);
}

fn main() {
    let mut primes :Vec<i32> = vec![];
    let mut avg :Vec<i32> = vec![];
    fill_primes(&mut primes, 60);
    avg_primes(&primes, &mut avg);
    let mut weak :Vec<i32> = vec![];
    let mut strong :Vec<i32> = vec![];
    let mut other :Vec<i32> = vec![];
    fill_weak_strong(&primes, &avg, &mut weak, &mut strong, &mut other);
    print!("Weak: ");
    for i in 0 .. 10 {
	print!("{} ", weak[i]);
    }
    print!("\nStrong: ");
    for i in 0 .. 10 {
	print!("{} ", strong[i]);
    }
    println!();
}
