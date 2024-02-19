let p = "Joe hit a ball, the hit ball flew far after it was hit.";
let w = "hit";

let p2 = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.";
let w2 = "the";

function proc(p, w) {
    let f = {};
    let mywords = [];
    let words = p.split(" ");
    for (let word of words) {
	let c = word.split("");
	if ( (c[word.length - 1] == ".") ||
	     (c[word.length - 1] == ",") ) {
	    word = word.slice(0,-1);
	}
	if (word == w) {
	    continue;
	} 
	f[word] = 0;
	mywords.push(word);
    }
    for (let word of mywords) {
	f[word]++;
    }
    console.log(`Input: ${p}, ${w}`);
    let max = 0;
    let maxword;
    for (let k of Object.keys(f)) {
	if (max < f[k]) {
	    max = f[k];
	    maxword = k;
	}
    }
    console.log(maxword);
}

proc(p, w);
proc(p2, w2);
