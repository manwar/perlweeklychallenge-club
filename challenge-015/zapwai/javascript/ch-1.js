let N = 100;

function fill_weak_strong(primes, avg, weak, strong, other) {
    //    weak.push(3);
    for (let i = 1; i < primes.length - 1; i++) {
	if (primes[i] < avg[i])
	    weak.push(primes[i]);
	else if (primes[i] > avg[i])
	    strong.push(primes[i]);
	else 
	    other.push(primes[i]);
    }
}

function fill_primes(primes, num) {
    primes.push(2);
    let current = 2;
    while (primes.length < num) {
	current++;
	let cnt = 0;
	for (let i = 0; i < primes.length; i++) {
	    let p = primes[i];
	    if (current % p == 0)
		cnt++;
	}
	if (cnt == 0)
	    primes.push(current);
    }
}

function avg_primes(primes, avg) {
    avg.push(0);
    for (let i = 1; i < primes.length - 1; i++)
	avg.push((primes[i + 1] + primes[i - 1]) / 2);
    avg.push(0);
}

function main() {
    let primes = [];
    let avg = [];
    fill_primes(primes, 60);
    avg_primes(primes, avg);
    let weak = [];
    let strong = [];
    let other = [];
    fill_weak_strong(primes, avg, weak, strong, other);
    console.log(weak);
    console.log(strong);
}

main();
