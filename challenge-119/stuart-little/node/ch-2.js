#!/usr/bin/env node

// run <script> <number>

function nxt(st) {
    const mtch = st.match(/(.*)([^3])(3*)$/);
    return (mtch) ? (mtch[1] + (parseInt(mtch[2])+1) + '12'.repeat(mtch[3].length).substr(0,mtch[3].length)) : ('12'.repeat(st.length).substr(0,st.length+1));
    
}

let out = '0';
[...Array(parseInt(process.argv[2])).keys()].forEach(_ => out = nxt(out))
console.log(out)
