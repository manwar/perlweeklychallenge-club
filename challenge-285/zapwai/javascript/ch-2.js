let amt = 100;
let cnt = 0;
for (let h = 0; h <= amt/50; h++) {
    for (let q = 0; q <= amt/25; q++) {
	for (let d = 0; d <= amt/10; d++) {
	    for (let n = 0; n <= amt/5; n++) {
		for (let p = 0; p <= amt; p++) {
		    if (tally(p, n, d, q, h) == amt) {
			cnt++;
		    }
		}
	    }
	}
    }
}
console.log( "There are", cnt,"ways to make change for", amt,"cents.");
function tally(p, n, d, q, h) { return p + 5*n + 10*d + 25*q + 50*h; }

