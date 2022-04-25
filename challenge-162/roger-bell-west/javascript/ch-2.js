#! /usr/bin/node

function posmod(a,b) {
    let m = a % b
    while (m < 0) {
        m += b
    }
    return m
}

function playfair(dir,kwi0,input) {
    let kw = ""
    let k = new Map()
    let kwi = kwi0.toLowerCase().replace(/[^a-z]+/g,"")
    for (let lx = 'a'.charCodeAt(0); lx <= 'z'.charCodeAt(0); lx++) {
        kwi = kwi + String.fromCharCode(lx)
    }
    for (let char0 of kwi.split("")) {
        let char1 = char0
        if (char1 == 'j') {
            char1 = 'i'
        }
        if (!k.has(char1)) {
            k.set(char1,true)
            kw = kw + char1
        }
    }
    let grid = []
    let gc = new Map()
    let index = 0
    for (let row = 0; row <= 4; row++) {
        let r = []
        for (let column = 0; column <= 4; column++) {
            r.push(kw.charAt(index))
            gc.set(kw.charAt(index),[row,column])
            index++
        }
        grid.push(r)
    }
    let ii = input.toLowerCase().replace(/[^a-z]+/g,"").replace(/j/g,"i")
    let out = ""
    index = 0
    while (index < ii.length) {
        let ca = ii.charAt(index)
        let cb = "x"
        if (index + 1 < ii.length) {
            cb = ii.charAt(index+1)
        }
        index += 2
        if (ca == cb) {
            cb = "x"
            index--
        }
        let car = gc.get(ca)[0]
        let cac = gc.get(ca)[1]
        let cbr = gc.get(cb)[0]
        let cbc = gc.get(cb)[1]
        let oar = car
        let oac = cac
        let obr = cbr
        let obc = cbc
        if (car == cbr) {
            oac = posmod(cac + dir, 5)
            obc = posmod(cbc + dir, 5)
        } else if (cac == cbc) {
            oar = posmod(car + dir, 5)
            obr = posmod(cbr + dir, 5)
        } else {
            oac = cbc
            obc = cac
        }
        out = out + grid[oar][oac]
        out = out + grid[obr][obc]
    }
    return out
}

function encrypt(kw,plaintext) {
    return playfair(1,kw,plaintext)
}

function decrypt(kw,ciphertext) {
    return playfair(-1,kw,ciphertext)
}

if (encrypt("playfair example","hide the gold in the tree stump") ==
    "bmodzbxdnabekudmuixmmouvif") {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (decrypt("perl and raku","siderwrdulfipaarkcrw") ==
    "thewexeklychallengex") {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
