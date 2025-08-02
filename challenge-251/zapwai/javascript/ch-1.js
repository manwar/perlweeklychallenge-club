let ints = [6, 12, 25, 1];
let ints2 = [10, 7, 31, 5, 2, 2];
let ints3 = [1, 2, 10];
proc(ints);
proc(ints2);
proc(ints3);
function proc(ints) {
    console.log("Input:", ints);
    let sum = 0;
    while (ints.length > 0) {
	let a = ints.shift();
	let num = a;
	if (ints.length > 0) {
	    let b = ints.pop();
	    num = `${a}`+`${b}`;
	}
	sum += parseInt(num);
    }
    console.log("Output:", sum);
}
