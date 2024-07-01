let sentence = "Perl Weekly Challenge";
let keys = ['l', 'a'];
proc(sentence, keys);
sentence = "Perl and Raku"; keys = ['a'];
proc(sentence, keys);
sentence = "Well done Team PWC"; keys = ['l', 'o'];
proc(sentence, keys);
function proc(sentence, keys) {
    console.log("Input: Sentence =", sentence, "keys =", keys);
    let num = 0;
    for (let word of sentence.split(' ')) {
	let tally = 0;
	for (let key of keys) {
	    if (word.indexOf(key) != -1) {
		break;
	    } else {
		tally++;
	    }
	}
	if (tally == keys.length) {
	    num++;
	}
    }
	 console.log("Output:", num);
}

