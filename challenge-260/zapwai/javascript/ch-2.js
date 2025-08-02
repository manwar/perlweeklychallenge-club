function proc(word) {
    console.log("Input:", word);
    let h = {};
    L(word.length, word.split(''), h);
    let sorted = Object.keys(h).sort();
    console.log("Output:", 1 + seek_word(word, sorted));
}

function L(k, list, h) {
    if (k == 1)
	h[list.join('')] = 1;
    else {
	L(k-1, list, h);
	for (let i = 0; i < k-1; i++) {
	    if (k % 2 == 0)
		swap(i, k-1, list);
	    else
		swap(0, k-1, list);
	    L(k-1, list, h);
	}
    }
}

function swap(i, j, list) {
    let tmp = list[i];
    list[i] = list[j];
    list[j] = tmp;
}

function seek_word(word, sorted) {
    for (let i = 0; i < sorted.length; i++)
	if (sorted[i] == word)
	    return i;

    return -1;
}

proc("CAT");
proc("GOGGLE");
proc("SECRET");
