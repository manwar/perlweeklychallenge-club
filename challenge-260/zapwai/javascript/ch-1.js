let l1 = [1,2,2,1,1,3];
let l2 = [1,2,3];
let l3 = [-2,0,1,-2,1,1,0,1,-2,9];
for (let l of [l1, l2, l3]) 
    proc(l);

function proc(l) {
    console.log("Input:", l);
    let f = {};
    for (let i of l) 
	(i in f) ? f[i]++ : f[i] = 1;
    let freq = [];
    let output = 1;
    for (let v of Object.values(f)) {
	if (freq.includes(v)) 
	    output = 0;
	else
	    freq.push(v);
    }
    console.log("Output:", output);
}
