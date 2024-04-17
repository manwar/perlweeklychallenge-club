let ints = [1,2,3,3,3,3,4,2];
let ints2 = [1,1];
let ints3 = [1,2,3];
proc(ints);
proc(ints2);
proc(ints3);

function proc(ints) {
    console.log("Input:",ints);
    let third = ints.length / 3;
    let freq = [0,0,0,0,0];
    for (let i = 0; i < ints.length; i++) {
	freq[ints[i]]++;
    }
    let ans = [];
    for (let val = 0; val < freq.length; val++) {
	if (freq[val] >= third)
	    ans.push(val); 
    }
    ans.sort();
    console.log("Output:", ans[0]);
}
