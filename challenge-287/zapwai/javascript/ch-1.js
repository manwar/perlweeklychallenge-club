let str = "a";
proc(str);
str = "aB2";
proc(str);
str = "PaaSW0rd";
proc(str);
str = "turbbbbot";
proc(str);
str  = "111";
proc(str);

function proc(str) {
    console.log( "Input:", str);
    let len = str.length;
    let len_diff = 0;
    if (len < 6) {
	len_diff = 6 - len;
    } else if (len > 20) {
	len_diff = len - 20;
    }
    let l = str.split("");
    let lengths = [];
    let hits = 0;
    for (let i = 0; i < l.length - 1; i++) {
	if (l[i] == l[i+1]) {
	    hits++;
	} else {
	    if (hits > 1) {
		lengths.push(1+hits);
	    }
	    hits = 0;
	}
    }
    if (hits > 1) {
	lengths.push(1+hits);
    }
    let steps = 0;
    for (let l of lengths) {
	steps += Math.floor(l/3);
    }
    let lflag = 1;
    let uflag = 1;
    let dflag = 1;
    let lreg = new RegExp('[a-z]');
    let ureg = new RegExp('[A-Z]');
    let dreg = new RegExp('\d');
    if (lreg.test(str)) {
	lflag = 0;
    }
    if (ureg.test(str)) {
	uflag = 0;
    }
    if (dreg.test(str)) {
	dflag = 0;
    }
    let tally = lflag + uflag + dflag;
    let out_val = len_diff + steps;
    if (out_val < tally) {
	out_val += tally - out_val;
    }
    console.log( "Output: ", out_val);
}

