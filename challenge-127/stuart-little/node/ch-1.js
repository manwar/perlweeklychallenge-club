#!/usr/bin/env node

// run <script> <space-separated set entries, with a '-' separating the two sets>

let [s1,s2,flag]=[[],[],0]
for (let it of process.argv.slice(2)) {
    if (it === '-') {
	flag=1
	continue
    }
    [s1,s2][flag].push(it)
}
console.log(s1.filter(x => s2.includes(x)).length > 0 ? 0 : 1)
