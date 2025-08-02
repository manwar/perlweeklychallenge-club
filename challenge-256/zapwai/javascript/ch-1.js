function main() {
    let words = ["ab", "de", "ed", "bc"];
    proc(words);
    words = ["aa", "ba", "cd", "ed"];
    proc(words);
    words = ["uv", "qp", "st", "vu", "mn", "pq"];
    proc(words);
}

function proc(words) {
    let cnt = 0;
    for (let i = 0; i < words.length - 1; i++) {
	let rev = words[i].split("").reverse().join("");
	for (let j = i + 1; j < words.length; j++) {
	    if (words[j] == rev) { cnt++; }
	}
    }    
    console.log("Input: ", words);
    console.log("Output: ", cnt);
}

main();
