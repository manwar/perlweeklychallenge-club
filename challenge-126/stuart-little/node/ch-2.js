#!/usr/bin/env node

// run <script>

function nbrs(mat,i,j) {
    return [-1,0,1].map(x => [-1,0,1].map(y => [i+x,j+y])).flat().filter(p => p[0] !== i || p[1] !== j).filter(p => 0<=p[0] && p[0] < mat.length).filter(p => 0<=p[1] && p[1] < mat[0].length)
}

inpt=`x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
`.split(/\n/).map(s => s.split(/\s+/)).filter(x => x[0].length>0)

for (let i=0; i<inpt.length; i++) {
    let str=""
    for (let j=0; j<inpt[0].length; j++) {
	str += (((inpt[i][j] === 'x') ? ('x') : (nbrs(inpt,i,j).filter(p => inpt[p[0]][p[1]] === 'x').length)) + " ")
    }
    console.log(str)
}
