#! /usr/bin/node

let f=new Map()
let r=new Map()

const readable = process.stdin
let buffer = ""
readable.on('readable', () => {
    let chunk;
    while (null !== (chunk = readable.read())) {
        buffer += chunk
    }
})
readable.on('end', () => {
    buffer.split(/\r?\n/).forEach(line =>  {
        let b=1
        let v=0
        for (let lx = 'a'.charCodeAt(0); lx <= 'z'.charCodeAt(0); lx++) {
            if (line.indexOf(String.fromCharCode(lx)) > -1) {
                v |= b
            }
            b <<= 1
        }
        if (!r.has(v) || r.get(v).length > line.length) {
            f.set(line,v)
            r.set(v,line)
        }
    })
    let w = []
    const lt = (1 << 26) -1
    let lu = [0]
    while (lu[lu.length-1] != lt) {
        let wn=""
        if (w.length > 0) {
            let mode = 0
            let sc = []
            for (let wv of r.keys()) {
                if ((wv & lu[lu.length-1] == 0)) {
                    if (mode == 0) {
                        mode = 1
                        sc = []
                    }
                    sc.push(r.get(wv))
                } else if (mode == 0 && (wv | lu[lu.length-1]) != lu[lu.length-1]) {
                    sc.push(r.get(wv))
                }
            }
            if (sc.length == 0) {
                w.pop
                lu.pop
            } else {
                wn=sc[Math.floor(Math.random()*sc.length)]
            }
        } else {
            let sc=[...f.keys()]
            wn=sc[Math.floor(Math.random()*sc.length)]
        }
        if (wn != "") {
            w.push(wn)
            lu.push(lu[lu.length-1] | f.get(wn))
        }
    }

    console.log(w.join(" "))
})

