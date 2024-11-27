function proc(ints) {
    console.log( "Input: ints =", ints);
    let ans = "false";
    for (let i = 0; i < ints.length - 1; i++) {
	for (let j = i + 1; j < ints.length; j++) {
	    if (ints[i] == 2 * ints[j] || ints[j] == 2 * ints[i]) {
		ans = "true";
	    }
	}
    }
    console.log( "Output:", ans);
}

let ints = [6, 2, 3, 3];
proc(ints);
ints = [3, 1, 4, 13];
proc(ints);
ints = [2, 1, 4, 2];
proc(ints);
