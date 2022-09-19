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
    let points = []
    let lines = []
    let x = []
    let y = []
    buffer.split(/\r?\n/).forEach(line =>  {
        let f=line.split(",")
        for (let i = 0; i < f.length; i++) {
            if (i % 2 == 0) {
                x.push(f[i])
            } else {
                y.push(f[i])
            }
        }
        if (f.length == 4) {
            lines.push(f)
        } else if (f.length == 2) {
            points.push(f)
        }
    })
    let mnx = Math.min(...x)
    let mxx = Math.max(...x)
    let mny = Math.min(...y)
    let mxy = Math.max(...y)
    let lo = [
        mnx - (mxx-mnx)/10,
        mny - (mxy-mny)/10,
    ]
    let hi = [
        mxx + (mxx-mnx)/10,
        mxy + (mxy-mny)/10,
    ]
    let w = hi[0]-lo[0]
    let h = hi[1]-lo[1]
    console.log(`<?xml version="1.0" encoding="UTF-8" standalone="yes"?>`)
    console.log(`<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">`)
    console.log(`<svg width="${w}" height="${h}" viewBox="${lo[0]} ${lo[1]} ${w} ${h}" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">`)

    if (lines.length > 0) {
        console.log(`  <g id="lines" stroke="#369" stroke-width="4">`);
        for (let p of lines) {
            console.log(`    <line x1="${p[0]}" y1="${p[1]}" x2="${p[2]}" y2="${p[3]}" />`)
        }
        console.log("  </g>")
    }

    if (points.length > 0) {
        console.log(`  <g fill="#f73" id="points">`);
        for (let p of points) {
            console.log(`    <circle cx="${p[0]}" cy="${p[1]}" r="3" />`)
        }
        console.log("  </g>")
    }

    console.log("</svg>")

})
