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
    buffer.split(/[\r\n ]+/).forEach(line =>  {
        if (line.length > 0) {
            console.log(line)
            points.push(line.split(","))
        }
    })
    let slope = []
    for (let i = 0; i < points.length-1; i++) {
        for (let j = i+1; j < points.length; j++) {
            if (points[i][0] != points[j][0]) {
                slope.push((points[j][1]-points[i][1])/(points[j][0]-points[i][0]))
            }
        }
    }
    let m = median(slope)
    let c = median(points.map(p => p[1] - m*p[0]))
    let x = points.map(p => p[0])
    let l = []
    for (let xb of [Math.min(...x),Math.max(...x)]) {
        l.push(xb)
        l.push(xb * m + c)
    }
    console.log(l.join(","))
})

function median(s0) {
    let s = s0
    s.sort((a,b) => b-a)
    return s[Math.floor(s.length/2)]
}
