let MAX_LENGTH = 20;
let ints = [1, 2, 2, 4, 1, 5];
proc(ints);
ints = [1, 2, 3, 4, 5];
proc(ints);

function proc(ints) {
    console.log("Input:", ints);
    let nums = [];
    let freq = Array(MAX_LENGTH).fill(1);
    for (let item of ints) {
	let have = 0;
	for (let j of nums) {
	    if (j == item) {
		have++;
	    }
	}
	if (have == 0) {
	    nums.push(item);
	} else {
	    freq[item] = have + 1;
	}
    }
    let mostfreq = [];
    let f = 0; 
    for (let num of nums) {
	if (freq[num] > f) {
	    f = freq[num];
	}
    }
    for (let num of nums) {
	if (freq[num] == f) {
	    mostfreq.push(num);
	}
    }
    console.log("The most frequent is", mostfreq, "with", f, "occurrences.");
}
