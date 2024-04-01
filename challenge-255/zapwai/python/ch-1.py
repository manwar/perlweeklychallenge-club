def proc(s, t):
    print("Input: s =",s,"t =",t);
    freqs = {};
    freqt = {};
    for c in s:
        freqs[c] = 0;
    for c in s:
        freqs[c] += 1;
    for c in t:
        freqt[c] = 0;
    for c in t:
        freqt[c] += 1;
    ans = None;
    for k in freqt.keys():
        if not k in freqs.keys():
            ans = k;
            break;
    if ans is None:
        for i in range(len(s)):
    	    if freqs[s[i]] < freqt[s[i]]:
                ans = s[i];
                break;
    print("Output:",ans);
proc("Perl", "Preel");
proc("Weekly", "Weeakly");
proc("Box", "Boxy");
