def proc(p, w):
    words = p.split();
    freq = {};
    for word in words:
        if not word[len(word)-1].isalpha():
            word = word[:-1];
        if not word == w:
            freq[word] = 0;
    for word in words:
        if not word[len(word)-1].isalpha():
            word = word[:-1];
        if not word == w:
            freq[word] += 1;
    print("Input:  p =", p, "\n\tw =", w);
    print("Output:",max(freq, key=freq.get));
proc("Joe hit a ball, the hit ball flew far after it was hit.", "hit");
proc("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.","the");
