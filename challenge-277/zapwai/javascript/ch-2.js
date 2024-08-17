let ints = [1, 2, 3, 4, 5];
proc(ints);
ints = [5, 7, 1, 7];
proc(ints);

function proc(ints) {
    console.log("Input:", ints);
    let cnt = 0;
    for (let i = 0; i < ints.length - 1; i++) {
	for (let j = i + 1; j < ints.length; j++) {
	    if (ints[i] != ints[j] && (Math.abs(ints[i] - ints[j]) < Math.min(ints[i],ints[j]))) {
		cnt++;
	    }
	}
    }
    console.log("Output:", cnt);
}
