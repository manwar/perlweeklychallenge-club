let x = "003407";
let ans = "";
let on = false;
for (let c of x) {
    if (on) {
	ans += c;
    } else {
	if (c != "0") {
	    on = true;
	    ans += c;
	}
    }
}
console.log("Input: ", x);
console.log("Output: ", ans);
