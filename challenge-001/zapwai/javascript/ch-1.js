let str = "Perl Weekly Challenge!";
let cnt = 0;
let newstr = "";
for (let c of str) {
    if (c == "e") {
	c = "E";
	cnt++;
    }
    document.write(c);
    newstr += c;
}
console.log(newstr);
document.write("\n<br>There were ", cnt, " e's in the sentence.");
console.log("\nThere were ", cnt, " e's in the sentence.");
