fn fill_primes(num :i32, primes :&mut Vec<i32> ) {
    let mut i = 2;
    while primes[primes.len() - 1] < num {
	i += 1;
	let mut cnt = 0;
	for p in &mut *primes {
	    if i % *p == 0 {
		cnt += 1;
	    }
	}
	if cnt == 0 {
	    primes.push(i);
	}
    }
}

fn is_prime(num :i32, primes :&Vec<i32>) -> bool {
    for p in primes {
	if p < &num {
	    if num % p == 0 {
		return false;
	    }
	} else {
	    break;
	}
    }
    return true;
}

fn primorial(n :i32, primes :&Vec<i32>) -> i32 {
    let mut p = 1;
    let mut i = n as usize;
    while i > 0 {
	i -= 1;
	p *= primes[i];
    }
    return p;
}

fn euclid(n :i32, primes : &Vec<i32>) -> i32 {
    return 1 + primorial(n, primes);
}

fn main() {
    let mut primes = vec![2];
    fill_primes(15000, &mut primes);
    for i in 0 .. 8 {
	if !is_prime(euclid(i, &primes), &primes) {
	    println!("{}", euclid(i, &primes));
	    break;
	}
    }
}
