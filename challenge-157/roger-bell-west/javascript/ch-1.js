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

function pythagoreanmeans(s) {
    return new Map([
        ["AM", round1(arithmeticmean(s))],
        ["GM", round1(geometricmean(s))],
        ["HM", round1(harmonicmean(s))],
    ])
}

function round1(x) {
    return Math.round(10*x)/10
}

function arithmeticmean(s) {
    return s.reduce((x,y) => x+y, 0) / s.size
}

function geometricmean(s) {
    return s.reduce((x,y) => x*y, 1) ** (1/s.size)
}

function harmonicmean(s) {
    return s.size/(s.map(x => 1/x).reduce((x,y) => x+y, 0))
}

if (deepEqual(pythagoreanmeans([1,3,5,7,9]),new Map([
    ["AM", 5.0],
    ["GM", 3.9],
    ["HM", 2.8]
]))) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(pythagoreanmeans([2,4,6,8,10]),new Map([
    ["AM", 6.0],
    ["GM", 5.2],
    ["HM", 4.4]
]))) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(pythagoreanmeans([1,2,3,4,5]),new Map([
    ["AM", 3.0],
    ["GM", 2.6],
    ["HM", 2.2]
]))) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
