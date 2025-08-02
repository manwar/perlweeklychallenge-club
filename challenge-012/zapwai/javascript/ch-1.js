let primes = [2];

function is_prime(num) {
    for (let p of primes) {
	if (p < num) {
	    if (num % p == 0)
		return false;
	}
	else {
	    break;
	}
    }
    return true;
}

function primorial(n) {
    let p = 1;
    while (n > 0) {
	n--;
	p *= primes[n];
    }
    return p;
}

function fill_primes(num) {
    let i = 2;
    while (primes[primes.length-1] < num) {
	i++;
	let cnt = 0;
	for (let j = 0; j < primes.length; j++) {
	    if (i % primes[j] == 0)
		cnt++;
	}
	if (cnt == 0)
	    primes.push(i);
    }
}

function euclid(i) {
    return 1 + primorial(i);
}

fill_primes(15000);
for (let i = 2; i < 8; i++) {
    if (!(is_prime(euclid(i)))) {
	console.log(euclid(i));
	break;
    }
}
