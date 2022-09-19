"""Find the first unique character in the given string"""
for test in ["Perl Weekly Challenge", "Long Live Perl"]:
    histo = dict()
    for char in test:
        histo[char] = histo.get(char, 0) + 1
    for i in range(0, len(test)):
        if histo[test[i]] == 1:
            print(test, ": ", i)
            break
