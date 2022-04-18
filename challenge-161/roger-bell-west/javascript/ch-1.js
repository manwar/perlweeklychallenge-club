#! /usr/bin/node

const readable = process.stdin
let buffer = ""
readable.on('readable', () => {
    let chunk;
    while (null !== (chunk = readable.read())) {
        buffer += chunk
    }
})
readable.on('end', () => {
    let b=[]
    buffer.split(/\r?\n/).forEach(line =>  {
        let u=true
        let a=line.split("")
        for (let i=0;i < a.length-1; i++) {
            if (a[i] > a[i+1]) {
                u=false
                break
            }
        }
        if (u) {
            b.push(line)
        }
    })
    b.sort(function(aa,bb) {
        return bb.length - aa.length
    })
    for (let l of b) {
        console.log(l)
    }
})
