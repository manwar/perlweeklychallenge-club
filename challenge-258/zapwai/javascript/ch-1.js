let ints = [10, 1, 111, 24, 1000];
let ints2 = [111, 1, 11111];
let ints3 = [2, 8, 1024, 256];
proc(ints);
proc(ints2);
proc(ints3);

function proc(ints) {
    console.log("Input:", ints);
    let cnt = 0;
    for (let num of ints) {
	if (num.toString().length % 2 == 0) {
	    cnt++;
	}
    }
    console.log("Output:", cnt);
}
