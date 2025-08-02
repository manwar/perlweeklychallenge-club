let r1 = [11, 23, 35, 47, 59];
let r2 = [5, 20, 35, 50, 65];
let length_one = 41;
let length_two = 35;
let out = "";
for (let t = 1; t < 59; t++) {
    let delta_one = delta(t, r1);
    let delta_two = delta(t, r2);
    let time_taken_one = length_one + delta_one;
    let time_taken_two = length_two + delta_two;
    if ((delta_one <= delta_two) && (time_taken_one > time_taken_two)) {
	out += t+" ";
    }
}
console.log(out);

function delta(t, ran) {
    for (let r of ran) {
	if (r < t) {
	    continue;
	}
	return r - t;
    }
}
