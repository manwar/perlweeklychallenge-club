#! /usr/bin/node
function deepEqual(a,b)
{
    if( (typeof a == 'object' && a != null) &&
        (typeof b == 'object' && b != null) )
    {
        var count = [0,0]
        for( var key in a) count[0]++
        for( var key in b) count[1]++
        if( count[0]-count[1] != 0) {return false}
        for( var key in a)
        {
            if(!(key in b) || !deepEqual(a[key],b[key])) {return false}
        }
        for( var key in b)
        {
            if(!(key in a) || !deepEqual(b[key],a[key])) {return false}
        }
        return true
    }
    else
    {
        return a === b
    }
}

function kronecker (a,b) {
    let o = [];
    let ax = a[0].length;
    let ay = a.length;
    let bx = b[0].length;
    let by = b.length;
    for (let y = 0; y < ay * by; y++) {
        let byi = y % by;
        let ayi = Math.floor(y/by);
        let row = []
        for (let x = 0; x < ax * bx; x++) {
            let bxi = x % bx;
            let axi = Math.floor(x/bx);
            row.push(a[ayi][axi] * b[byi][bxi]);
        }
        o.push(row)
    }
    return o
}

if (deepEqual(kronecker([[1,2],[3,4]],
                        [[5,6],[7,8]]),
              [
                  [ 5,  6, 10, 12],
                  [ 7,  8, 14, 16],
                  [15, 18, 20, 24],
                  [21, 24, 28, 32]
              ])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
