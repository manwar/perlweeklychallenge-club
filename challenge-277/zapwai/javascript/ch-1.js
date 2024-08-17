let words1 = ["Perl", "is", "let", "friend"];
let words2 = ["Perl", "and", "Raku", "are", "friend"];
proc(words1, words2);
words1 = ["Perl", "and", "Python", "are", "very", "similar"];
words2 = ["Python", "is", "top", "in", "guest", "languages"];
proc(words1, words2);

function proc(words1, words2) {
    console.log("Input:", words1, words2);
    let cnt = 0;
    for (let word1 of words1) {
	if (is_multi(word1, words1)) {
	    continue;
	}
	for (let word2 of words2) {
	    if (is_multi(word2, words2)) {
		continue;
	    }
	    if (word1 == word2) {
		cnt++ ;
	    }
	}
    }
    console.log("Output:", cnt);
}

function is_multi(word, words) {
    let cnt = 0;
    for (let w of words) {
	if (word == w) {
	    cnt++ ;
	}
    }
    if (cnt == 1) {
	return 0;
    }
    return 1;
}
