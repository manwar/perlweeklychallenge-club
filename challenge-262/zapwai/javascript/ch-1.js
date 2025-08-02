let ints = [-3, 1, 2, -1, 3, -2, 4];
console.log("Input:", ints);
let neg = 0, pos = 0;
for (let num of ints) {
    if (num < 0) {
	if (neg > num)
	    neg = num;
    }
    else {
	if (pos < num)
	    pos = num;
    }
}
ans = Math.max(Math.abs(neg), pos);
console.log("Output:", ans);
