#!/usr/bin/env node

// run <script> <starting arrivals followed by departures, all space-separated>

const times = process.argv.slice(2).map((v,ix) => [v, ix % Math.floor(process.argv.slice(2).length/2)]).sort()
let sol=0
let station = Array(Math.floor(process.argv.slice(2).length/2)).fill(0)

times.forEach( tm => {
    station[tm[1]]^=1
    let sm = station.reduce((a,b) => a+b, 0)
    if (sm > sol) {sol = sm}
})

console.log(sol)
