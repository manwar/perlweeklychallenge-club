let ints = [3, 1, 2, 2, 2, 1, 3];
let k = 2;
console.log("Input: ints:", ints, "k:", k);
let cnt = 0;
for (let i = 0; i < ints.length - 1; i++) {
    for (let j = i + 1; j < ints.length; j++) {    
	if (ints[i] != ints[j]) {
	    continue;
	}
	if (i * j % k == 0) {
	    cnt++;
	}
    }
}
console.log("Output:", cnt);
