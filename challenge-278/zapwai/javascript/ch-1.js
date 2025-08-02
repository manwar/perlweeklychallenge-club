let str = "and2 Raku3 cousins5 Perl1 are4";
proc(str);
str = "guest6 Python1 most4 the3 popular5 is2 language7";
proc(str);
str = "Challenge3 The1 Weekly2";
proc(str);

function proc(str) {
    console.log("Input:", str);
    let words = [];
    let keys = [];
    for (let word of str.split(" ")) {
	let key = word.substr(-1);
	let w = word.substr(0, word.length - 1);
	words.push(w);
	keys.push(key);
    }
    let cnt = 1;
    while (cnt > 0) {
	cnt = 0;
	for (let i = 0; i < words.length - 1; i++) {
	    if (keys[i] > keys[i + 1]) {
		let keynum = keys[i];
		keys[i] = keys[i + 1];
		keys[i + 1] = keynum;
		let word = words[i];
		words[i] = words[i + 1];
		words[i + 1] = word;
		cnt++;
	    }
	}
    }
    console.log( "Output:",words);
}
