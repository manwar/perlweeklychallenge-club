function check(x, y) {
    let cnt = 0;
    for (let i = 0; i < x.length; i++) {
        if (x[i] == y[i]) {
            cnt++;
	}
    }
    return ( cnt == x.length )
}

function proc(x, y) {
    console.log("Input:  x =", x, "\n\ty =", y)
    x.sort();
    y.sort();
    for (let i = -99; i < 99; i++) {
	let n = x.map((x) => x);
	for (let j = 0; j < n.length; j++) {
	    n[j] += i;
	}
	if (check(n, y)) {
	    console.log("Output:", i);
	    break;
	}
    }
}

x = [3, 7, 5];
y = [9, 5, 7];
proc(x, y);
