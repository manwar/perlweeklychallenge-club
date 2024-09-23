let s = "123";
proc(s);
s = "2";
proc(s);
s = "1400";
proc(s);

function is_pal(s) {
    let r = s.split("").reduce((acc, char) => char + acc, "");
    return (s == r);
}

function proc(s) {
    console.log( "Input:", s);
    let n = parseInt(s, 10);
    let found = false;
    let step = 1;
    while (!found) {
	let m = n - step;
	if (is_pal(m.toString())) {
	    found = true;
	    n = m;
	} else {
	    m = n + step;
	    if (is_pal(m.toString())) {
		found = true;
		n = m;
	    }
	}
	step++;
    }
    console.log( "Output:", n);
}
