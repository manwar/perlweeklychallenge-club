#! /usr/bin/node
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

function permute(a) {
    let out=new Set
    let n=a.length
    let c=[]
    for (let i = 0; i < n; i++) {
        c.push(0)
    }
    out.add(a.join(""))
    let i=0
    while (true) {
        if (i >= n) {
            break
        }
        if (c[i] < i) {
            if (i % 2 == 0) {
                [a[0],a[i]] = [a[i],a[0]]
            } else {
                [a[c[i]],a[i]] = [a[i],a[c[i]]]
            }
            out.add(a.join(""))
            c[i]++
            i=0
        } else {
            c[i]=0
            i++
        }
    }
    return out
}

function missingpermutations (list) {
    let l0=list[0].split("");
    let perms=permute(l0)
    for (let i of list) {
        perms.delete(i)
    }
    let out=[...perms]
    out.sort(function(a,b) {
        return a-b
    });
    return out
}

if (deepEqual(missingpermutations(["PELR", "PREL", "PERL", "PRLE",
                                   "PLER", "PLRE", "EPRL", "EPLR",
                                   "ERPL", "ERLP", "ELPR", "ELRP",
                                   "RPEL", "RPLE", "REPL", "RELP",
                                   "RLPE", "RLEP", "LPER", "LPRE",
                                   "LEPR", "LRPE", "LREP"]),
              ["LERP"])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
