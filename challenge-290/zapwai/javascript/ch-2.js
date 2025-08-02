function proc(s0) {
    console.log( "Input:", s0);
    s = s0.replace(/\s+/g, "");
    let dig = s.split("");
    let payload = Number(dig.pop());
    digit = dig.reverse().map(Number);
    let sum = 0;
    for (let i = 0; i < digit.length; i++) {
	if (i % 2 == 0) {
	    let x = 2*digit[i];
	    if (x > 9) {
		let a = Math.floor(x / 10);
		let b = x % 10;
		sum += a + b;
	    } else {
		sum += x;
	    }
	} else {
	    sum += digit[i];
	}
    }
    let ans = "false";
    if ((sum + payload) % 10 == 0) {
	ans = "true";
    }
    console.log( "Output:", ans);
}

let s = "17893729974";
proc(s);
s = "4137 8947 1175 5904";
proc(s);
s = "4137 8974 1175 5904";
proc(s);
