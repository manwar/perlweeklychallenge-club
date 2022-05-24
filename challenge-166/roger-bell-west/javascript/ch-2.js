#! /usr/bin/node

function kdd(dirlist0) {
    const fs = require("fs")
    let dirlist = Array.from(dirlist0)
    dirlist.sort()
    let fx = new Map()
    for (let d of dirlist) {
        for (let entry of fs.readdirSync(d, { withFileTypes: true })) {
            let nn = entry.name
            if (entry.isDirectory()) {
                nn += "/"
            }
            if (!fx.has(nn)) {
                fx.set(nn,new Set())
            }
            let t = fx.get(nn)
            t.add(d)
            fx.set(nn,t)
        }
    }
    let mm = dirlist.length
    let out = [dirlist]
    for (let f of [...fx.keys()].sort()) {
        if (fx.get(f).size != mm) {
            let l = []
            for (let d of dirlist) {
                if (fx.get(f).has(d)) {
                    l.push(f)
                } else {
                    l.push("")
                }
            }
            out.push(l)
        }
    }
    tabular(out)
}

function tabular(d) {
    let columnlength = []
    d.forEach(row => {
        row.forEach((col, i) => {
            while (columnlength.length <= i) {
                columnlength.push(0)
            }
            columnlength[i] = Math.max(columnlength[i], col.length)
        })
    })
    d.forEach(row => {
        let s = []
        row.forEach((col, i) => {
            s.push(col.padEnd(columnlength[i]))
        })
        console.log(s.join(" | "))
    })
}
    
kdd(["dir_a","dir_b","dir_c"])
