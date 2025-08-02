function main() {
    str1 = "abcd", str2 = "1234";
    proc(str1, str2);

    str1 = "abcde", str2 = "123";
    proc(str1, str2);

    str1 = "abc", str2 = "12345";
    proc(str1, str2);
}

function proc(s1, s2) {
    let m1 = s1.split(""), m2 = s2.split("");
    let n1 = s1.length, n2 = s2.length;
    let ans = "";
    let k = Math.min(n1, n2);
    for (let i = 0; i < k; i++) {
	ans += m1[i]+m2[i];
    }
    for (let i = k; i < Math.max(n1, n2); i++) {
	if (n1 < n2) {
	    ans += m2[i];
	} else {
	    ans += m1[i];
	}
    }
    console.log(`Input: str1 = ${s1}, str2 = ${s2}`);
    console.log("Output:", ans);
}

main();
