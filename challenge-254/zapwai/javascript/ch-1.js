function main() {
    let n1 = 27;
    let n2 = 0;
    let n3 = 6;
    console.log(`Input: ${n1}`);
    console.log(`Output: ${is_pow(n1)}`);
    console.log(`Input: ${n2}`);
    console.log(`Output: ${is_pow(n2)}`);
    console.log(`Input: ${n3}`);
    console.log(`Output: ${is_pow(n3)}`);
    
}

function is_pow(n) {
    if (n < 3) {
	return false;
    }
    do {
	n /= 3;
	if (n == 1) {
	    return true;
	} else if (n % 3 != 0) {
	    return false;
	}
    }
    while (1);
}

main();
