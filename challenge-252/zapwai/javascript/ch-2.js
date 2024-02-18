let inputs = [5, 3, 1];
for (let inp of inputs) {
    proc(inp);
}
function proc(n) {
    let list = [];
    if (n % 2 == 1) {
	list.push(0);
    }
    let k = parseInt(n / 2);
    for (let i = 0; i < k; i++) {
	list.push(-1 * (i+1));
	list.push(i+1);	
    }
    console.log("Input:", n);
    console.log("Output:", list);
}
