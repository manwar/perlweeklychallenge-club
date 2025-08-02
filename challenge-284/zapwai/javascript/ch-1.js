let ints = [2, 2, 3, 4];
proc(ints);
ints = [1, 2, 2, 3, 3, 3];
proc(ints);
ints = [1, 1, 1, 3];
proc(ints);
function proc(ints) {
    console.log("Input: ints =", ints);
    let lucky = -1;
    let max = 0;
    for (let item of ints) {
	if (max < item) {
	    max = item;
	}
    }
    let freq = [];
    for (let j = 0; j < 1 + max; j++) {
	freq.push(0);
    }
    for (let item of ints) {
	freq[item]++;
    }
    for (let i = 1; i < freq.length; i++) {
	if (i == freq[i]) {
	    lucky = i;
	}
    }
    console.log("Output:", lucky);
}
