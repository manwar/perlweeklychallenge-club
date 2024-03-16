let dict, word1, word2, ladder;
const ourParagraph = document.getElementById('ourParagraph');
const ourParagraph2 = document.getElementById('ourParagraph2');
const fileInput = document.getElementById('fileInput');
fileInput.addEventListener('change', handleFileUpload);
const ourWord = document.getElementById('ourWord');
ourWord.addEventListener('change', onWordChange);
const ourWord2 = document.getElementById('ourWord2');
ourWord2.addEventListener('change', onWord2Change);

function onWordChange(event) {
    word1 = event.target.value;
    display();
}

function onWord2Change(event) {
    word2 = event.target.value;
    display();
}

function handleFileUpload(event) {
    const file = event.target.files[0];
    if (!file) {
	console.error('No file selected');
	return;
    }
    const reader = new FileReader();
    reader.onload = function(e) {
	const content = e.target.result;
	const words = content.split(/\s+/);
	dict = words;
	getLadder();
	display2();
    };
    reader.readAsText(file);
}

function quit() {
    console.log("Output: ()");
}

function neighbor(word, word_list) {
    for (let w of word_list)
	if (dist(w, word) == 1)
	    return w;
}

function dist(wrd1, wrd2) {
    let cnt = 0;
    let w1 = wrd1.split('');
    let w2 = wrd2.split('');
    for (let i = 0; i < w1.length; i++)
	if (w1[i] != w2[i])
	    cnt++;
    return cnt;
}

function check(m, n, A, B) {
    let ans = [];
    for (let i = 0; i <= m; i++)
	for (let j = 0; j <= n; j++){
	    let a = intersection(A[i], B[j]);
	    if (a.length > 0)
		for (let e of a)
		    ans.push(e);
	}
    return ans;
}

function expand(word, words) {
    let new1 = [];
    for (let i = 0; i < word.length; i++) {
	let pre = word.slice(0, i);
	let post = word.slice(i+1);
	for (let w of words) {
	    let pat = new RegExp(pre + "." + post);
	    if (pat.test(w))
		new1.push(w);
	}
    }
    let anew = new1;		// filter for not eq to word
    return anew;
}

function intersection(A, B) {
    let ints = [];
    for (let i = 0; i < A.length; i++) 
	for (let j = 0; j < B.length; j++) 
	    if (A[i] == B[j])
		ints.push(A[i]);
    return ints;
}

function proc(input1, input2) {
    let limit = 4;
    console.log("Input:", input1, input2);
    if (input1.length != input2.length)
	return quit();
    let cnt = 0;
    
    for (let word of dict){
	let reg1 = new RegExp(input1);
	let reg2 = new RegExp(input2);
	if (reg1.test(word) || reg2.test(word))
	    cnt++;
    }

    if (cnt < 2)
	return quit();

    let wordlen = input1.length;
    let words = []
    for (let d of dict)
	if (d.length == wordlen)
	    words.push(d);
    let A = [[input1]]
    let B = [[input2]]
    let center = []
    let lvl = 0;
    while (lvl < limit && center.length == 0) {
	let anew = [];
	let bnew = [];
	for (let wa of A[lvl])
	    for (let w of expand(wa, words))
		anew.push(w);
	for (let wb of B[lvl])
	    for (let w of expand(wb, words))
		bnew.push(w);
	let uniq_a = [];
	let uniq_b = [];
	for (let item of anew)
	    if (!(item in uniq_a))
		uniq_a.push(item);
	for (let item of bnew)
	    if (!(item in uniq_b))
		uniq_b.push(item);
	A.push(uniq_a);
	B.push(uniq_b);
	lvl++;
	center = check(lvl, lvl, A, B);
    }
    if (lvl == limit)
	return quit();
    let counter = lvl - 1;
    let mylist = [center[0]];
    let x = neighbor(center[0], A[counter]);
    let y = neighbor(center[0], B[counter]);
    if (y != null) {
	while (counter > 0) {
	    mylist.unshift(x);
	    mylist.push(y);
	    counter--;
	    x = neighbor(x, A[counter]);
	    y = neighbor(y, B[counter]);
	}
    }
    if (x != null)
	mylist.unshift(x);
    if (y != null)
	mylist.push(y);
    console.log("Output:", mylist);
}

function getLadder() {
    console.log("dictionary loaded");
    proc(word1, word2);
}

function display() {
    ourParagraph.innerHTML = `word1: ${word1}<br>word2: ${word2}<br>`;
}

function display2() {
    ourParagraph2.innerHTML = `${dict}`;
}

