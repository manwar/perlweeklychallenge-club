let ints1 = [1, 5, 3, 2, 4, 2]; let k1 = 2;
let ints2 = [1, 2, 4, 3, 5]; let k2 = 6;
let ints3 = [5, 3, 2, 4, 2, 1]; let k3 = 4;
proc(k1, ints1);
proc(k2, ints2);
proc(k3, ints3);
function proc(k, ints) {
    console.log("Input:", ints);
    ints = ints.sort();
    let ind = [];
    for (let i = 0; i < ints.length; i++)
	if (ints[i] == k)
	    ind.push(i);
    console.log("Output:", ind);
}
