let ints = [1, 2, 1, 0];
proc(ints);
ints = [0, 3, 0];
proc(ints);
function proc(ints) {
    console.log("Input: ints =", ints);
    let veracity = "true";
    for (let i = 0; i < ints.length; i++) {
	let freq = ints[i];
	let cnt = 0;
	for (let elem of ints) {
	    if (elem == i) {
		cnt++;
	    }
	}
	if (cnt != freq) {
	    veracity = "false";
	    break;
	}
    }
    console.log("Output:", veracity);
}
