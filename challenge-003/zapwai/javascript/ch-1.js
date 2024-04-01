let n = 1000;
let v = [];
for (let i = 0; i < 50; i++) {
    for (let j = 0; j < 32; j++) {
	for (let k = 0; k < 22; k++) {
	    let x = Math.pow(2, i) * Math.pow(3, j) * Math.pow(5, k);
	    if (x > n) {
		continue;
	    }
	    v.push(x);
	}
    }
}
v.sort(function (a, b) { return a - b; });
console.log(v);
