let vowelList = "aeiouAEIOU";
let inputs = ["Perl", "Raku", "Julia", "Uiua"];
for (let inp of inputs) {
    let vows = [];
    let pos = [];
    let c = inp.split("");
    for (let i = 0; i < inp.length; i++) {
	for (let v of vowelList) {
	    if (c[i] == v) {
		vows.push(v);
		pos.push(i);
		break;
	    }
	}
    }
    console.log("Input:", inp);
    vows = vows.reverse();
    let ans = "";
    let j = 0;
    for (let i = 0; i < inp.length; i++) {
	let vflag = false;
	for (p of pos) {
	    if (i == p) {
		ans += vows[j];
		j++;
		vflag = true;
	    }
	}
	if (!vflag) {
	    ans += inp[i];
	}
    }
    console.log("Output:", ans);
}
