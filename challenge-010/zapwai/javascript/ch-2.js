function jw(s1, s2) {
    j_sim = jsim(s1, s2);
    p = 0.1;
    l = 0;
    L1 = s1.split('');
    L2 = s2.split('');
    for (let i = 0; i < 4; i++)
        if (L1[i] == L2[i])
            l += 1;
    w_sim = j_sim + l*p*(1 - j_sim);
    return 1 - w_sim;
}

function jsim(s1, s2) {
    l1 = s1.length;
    l2 = s2.length;
    offset = Math.max(l1, l2) / 2;
    [m, t] = num_matches(s1, s2, offset);
    if (m > 0)
        return 1/3 * (m/l1 + m/l2 + (m - t)/m)
    else
        return 0
}

function num_matches(s1, s2, offset) {
    L1 = s1.split('');
    L2 = s2.split('');
    cnt = 0;
    trans = 0;
    for (let i = 0; i < s1.length; i++) {
        let found_match = false; 
	for (let j = 0; j < s2.length; j++) {
            if (!found_match)
                if (Math.abs(i - j) < offset)
                    if (L1[i] == L2[j]) {
                        found_match = true;
                        cnt += 1;
                        if (i != j) 
                            if (((i + 1 < s1.length) && (L1[i] == L2[i + 1]) && (L2[i] == L1[i + 1])) || ((i - 1 >= 0) && (L1[i] == L2[i - 1]) && (L2[i] == L1[i - 1])))
                        trans += 1;
		    }
	}
    }
    return [cnt, trans/2];
}
s1 = "faremviel";
s2 = "farmville";
console.log(jw(s1, s2));
