let letters = ['R', 'E', 'P', 'L'];
let weights = [3, 2, 1, 4];
proc(letters, weights);
letters = ['A', 'U', 'R', 'K'];
weights = [2, 4, 1, 3];
proc(letters, weights);
letters = ['O', 'H', 'Y', 'N', 'P', 'T'];
weights = [5, 4, 2, 6, 1, 3];
proc(letters, weights);

function proc(l, w) {
    console.log("Input: letters, weights", l, w);
    let ans = [];
    for (let i = 0; i < l.length; i++) {
	ans[w[i] - 1] = l[i];
    }
    console.log("Output: ", ans);
}
