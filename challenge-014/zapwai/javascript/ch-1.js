function vaneck(seq) {
    if (seq.length == 1)
	seq.push(0);
    else {
	let pop = seq[seq.length - 1];
	let done_flag = false;
	let j = seq.length - 2;
	while (j >= 0) {
	    if (!done_flag && (pop == seq[j])) {
		done_flag = true;
		seq.push(seq.length - 1 - j);
	    }
	    j--;
	}
	if (!done_flag)
	    seq.push(0);
    }
}
let N = 19;
let seq = [0];
for (let i = 0; i < N; i++) {
    vaneck(seq);
}
console.log(seq);
