#! /usr/bin/node

// by Frank Tan
// https://stackoverflow.com/questions/38400594/javascript-deep-comparison
function deepEqual(a,b)
{
    if( (typeof a == 'object' && a != null) &&
        (typeof b == 'object' && b != null) )
    {
        var count = [0,0];
        for( var key in a) count[0]++;
        for( var key in b) count[1]++;
        if( count[0]-count[1] != 0) {return false;}
        for( var key in a)
        {
            if(!(key in b) || !deepEqual(a[key],b[key])) {return false;}
        }
        for( var key in b)
        {
            if(!(key in a) || !deepEqual(b[key],a[key])) {return false;}
        }
        return true;
    }
    else
    {
        return a === b;
    }
}

function fds(n) {
    let out=[];
    let f=[1,0];
    let ft=new Set(f);
    let k=0;
    while (out.length < n) {
        let ds=0;
        let j=k;
        while (j > 0) {
            ds += j % 10;
            j=Math.floor(j/10);
        }
        while (f[0] < ds) {
            let t=f[1]+f[0];
            f[1]=f[0];
            f[0]=t;
            ft.add(f[0]);
        }
        if (ft.has(ds)) {
            out.push(k);
        }
        k++;
    }
    return out;
}

if (deepEqual(fds(8),[0, 1, 2, 3, 5, 8, 10, 11])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(fds(20),[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(fds(61),[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44, 49, 50, 53, 58, 62, 67, 71, 76, 80, 85, 94, 100, 101, 102, 104, 107, 110, 111, 113, 116, 120, 122, 125, 131, 134, 139, 140, 143, 148, 152, 157, 161, 166, 170, 175, 184, 193, 200, 201, 203, 206])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

