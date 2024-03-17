for (let i = 1; i < 21; i++) {
    let ans = "";
    if (i % 3 == 0) {
	ans += "fizz";
    }
    if (i % 5 == 0) {
	ans += "buzz";
    }
    if (ans) {
	console.log(ans);
    } else {
	console.log(i);
    }
}
