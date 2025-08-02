function proc(words, sep) {
    let list = [];
    for (let word of words) {
	let wordmaybe = word.split(sep);
	for (let w of wordmaybe) {
	    if (w != "") {
		list.push(w);
	    }
	}
    }
    console.log("Input:", words);
    console.log("Output:", list);    
}


function main() {
    let words = ["one.two.three","four.five","six"];
    let sep = ".";
    let words2 = ["$perl$$", "$$raku$"];
    let sep2 = "$";
    proc(words, sep);
    proc(words2, sep2);
}

main();
