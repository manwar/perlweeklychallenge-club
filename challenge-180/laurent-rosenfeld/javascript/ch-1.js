let tests = [ "Perl Weekly Challenge", "Long Live Perl" ]
for  (let i = 0; i < tests.length; i++) {
    test = tests[i]
    histo = new Map();
    chars = test.split("")
    chars.forEach( char => {
        histo.set(char, histo.has(char) ? histo.get(char) + 1 : 1)
    })
    for (let i = 0; i < chars.length; i++) {
        if (histo.get(chars[i]) == 1) {
            console.log(test, ": ", i)
            break
        }
    }
}
