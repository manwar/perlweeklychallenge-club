#! /usr/bin/node

function hexwords(lo,hi,sb) {
    const fs = require("fs")
    let out = []
    let buffer = fs.readFileSync("dictionary.txt","utf8")
    buffer.split(/\r?\n/).forEach(line =>  {
        if (line.length >= lo && line.length <= hi) {
            let valid = true
            let sbc = 0
            for (let c of line.split("") ) {
                if (c == 'o' || c == 'i' || c == 'l' || c == 's' || c == 't') {
                    sbc++
                    if (sbc > sb) {
                        valid = false
                    }
                } else if (c < 'a' || c > 'f') {
                    valid = false
                }
                if (!valid) {
                    break
                }
            }
            if (valid) {
                out.push(line)
            }
        }
    })
    return out
}

function combiwords(wl,l) {
    let wh = new Map()
    for (let w of wl) {
        let lw = w.length
        if (!wh.has(lw)) {
            wh.set(lw,[])
        }
        let t = wh.get(lw)
        t.push(w)
        wh.set(lw,t)
    }
    let tmap = [[]]
    let omap = []
    while (tmap.length > 0) {
        let c = tmap.pop()
        let s = c.reduce((x,y) => x+y, 0)
        for (let j=1; j < l-s; j++) {
            if (wh.has(j)) {
                let cc = [...c]
                cc.push(j)
                tmap.push(cc)
            }
        }
        if (wh.has(l-s)) {
            c.push(l-s)
            omap.push(c)
        }
    }
    let out = []
    for (let pat of omap) {
        let c = []
        let cm = []
        for (let i of pat) {
            cm.push(wh.get(i).length-1)
            c.push(0)
        }
        let ex = false
        while (!ex) {
            let o = []
            for (let i = 0; i < c.length; i++) {
                o.push(wh.get(pat[i])[c[i]])
            }
            out.push(o.join(""))
            let ss = c.length-1
            while (true) {
                c[ss]++
                if (c[ss] > cm[ss]) {
                    if (ss == 0) {
                        ex = true
                        break
                    }
                    c[ss] = 0
                    ss--
                } else {
                    break
                }
            }
        }
    }
    return out
}

if (hexwords(2,8,8).length == 1463) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (hexwords(8,8,8).length == 164) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (hexwords(2,8,0).length == 45) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (hexwords(2,8,1).length == 244) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (combiwords(hexwords(4,4,0),8).length == 144) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (combiwords(hexwords(3,5,0),8).length == 274) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
