function has_distinct_digits(num) {
    letters = num.toString().split('');
    freq = Array(10).fill(0);
    for (let l of letters) {
	n = parseInt(l, 10);
	freq[n]++;
    }
    for (let l of letters) {
	n = parseInt(l, 10);
	if (freq[n] > 1) {
	    return false;
	}
    }
    return true;
}

function proc() {
    for (let i = 0; i < 150; i++) {
	num = i*i;
	if ((num.toString().length == 5) && has_distinct_digits(num)) {
	    console.log(i, num);
	    break;
	}
    }
}

proc();
