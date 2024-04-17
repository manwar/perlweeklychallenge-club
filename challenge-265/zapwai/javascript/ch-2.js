let stringy = 'aBc 11c';
let strlist = ['accbbb', 'abc', 'abbc'];
proc(stringy, strlist);

stringy = 'La1 abc';
strlist = ['abcl', 'baacl', 'abaalc'];
proc(stringy, strlist);

stringy = 'JB 007';
strlist = ['jj', 'bb', 'bjb'];
proc(stringy, strlist);

function freq(stringy) {
    let f = new Map();
    let A = stringy.split("");
    for (let a of A) {
	a = a.toLowerCase();
	if (a.match(/[a-z]/)) {
	    if (f[a]) {
		f[a]++;
	    }
	    else {
		f[a] = 1;
	    }
	}
    }
    return f;
}

// Return true if g contains f
function hash_contains(g, f) {
    let cnt = 0;
    for (let k of Object.keys(f)) {
	if (f[k] <= g[k]) {
	    cnt++;
	}
    }
    return (cnt == Object.keys(f).length);
}

function proc(stringy, strlist) {
    console.log("Input:  string = ", stringy);
    console.log(strlist);
    let ans = [];
    for (let s of strlist) {
	if (hash_contains(freq(s), freq(stringy))) {
	    ans.push(s);
	}
    }
    let min = ans[0].length;
    let answer = ans[0];
    for (let i = 0; i < ans.length; i++) {
	if (ans[i].length < min) {
	    min = ans[i].length;
	    answer = ans[i];
	}
    }
    console.log("Output:", answer);
}
