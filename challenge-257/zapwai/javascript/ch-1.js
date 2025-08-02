let ints = [5, 2, 1, 6];
proc(ints);
ints = [1, 2, 0, 3];
proc(ints);
ints = [0, 1];
proc(ints);
ints = [9, 4, 9, 2];
proc(ints);

function proc(ints) {
    console.log("Input: ", ints);
    let ans = [];

    for (let i = 0; i < ints.length; i++) {
	let cnt = 0;
	for (let j = 0; j < ints.length; j++) {
	    if (i == j) { continue; }
	    if (ints[i] > ints[j]) {
		cnt++;
	    }
	}
	ans.push(cnt);
    }
    console.log("Output: ", ans);
}
