let ints = [2, 1, 3, 4, 5];
let ints2 = [3,2,4];
let ints3 = [5, 4, 3, 8];
proc(ints);
proc(ints2);
proc(ints3);

function proc(ints) {
    console.log( "Input: ints = ", ints );
    let arr1 = [ints.shift()];
    let arr2 = [ints.shift()];
    while (ints.length > 0) {
	let x = ints.shift();
	if (arr1[arr1.length-1] > arr2[arr2.length-1]) {
	    arr1.push(x);
	} else {
	    arr2.push(x);
	}
    } 
    console.log("Output: arr1 = ", arr1, "arr2 = ", arr2);
}
