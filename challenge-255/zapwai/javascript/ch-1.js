let [s, t] = ["Perl", "Preel"];
let [s2, t2] = ["Weekly", "Weeakly"];
let [s3, t3] = ["Box", "Boxy"];
proc(s, t);
proc(s2, t2);
proc(s3, t3);
function proc(s,t) {
    console.log(`Input: s: ${s}, t: ${t}`);
    let f = {};
    for (let l of s.split("")) {
	f[l] = 0;
    }
    let g = {};
    for (let l of t.split("")) {
	g[l] = 0;
    }
    for (let l of s.split("")) {
	f[l]++;
    }
    for (let l of t.split("")) {
	g[l]++;
    }
    let letter;
    for (let G of Object.keys(g)) {
	let cnt = 0;
	for (let F of Object.keys(f)) {
	    if (F == G) {
		break;
	    }
	    cnt++;
	}
	if (cnt == Object.keys(f).length) {
	    letter = G;
	}
    }
    if (letter == undefined) {
	for (let l of Object.keys(f)) {
	    if (f[l] < g[l]) {
		letter = l;
	    }
	}
    }
    console.log(`Output: ${letter}`);
}

