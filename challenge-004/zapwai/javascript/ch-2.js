let allow = "docgotrark";
proc(allow);

function proc(allow) {
    let f = {}			// hash containing allowed letters & counts
    fill(f, allow);
    let words = ["dog", "chair", "rack", "doggo"];
    let ans = [];
    for (let word of words) {
	let g = {};
	fill(g, word);
	if (comp(f,g) == 1) {
	    ans.push(word);
	}
    }
    console.log("Input:", allow);
    console.log("Output:", ans);
}
// fills a hashmap to count letters
function fill(f, word) {
    for (let c of word) {
	f[c] = 0;
    }
    for (let c of word) {
	f[c]++;
    }
}
// compare hashes, f is allowed chars, g is the word
function comp(f,g) {
    for (let k of Object.keys(g)) {
	if (!(k in f)) {
	    return 0;
	}
	if (f[k] < g[k]) {
	    return 0;
	}
    }
    return 1;
}
