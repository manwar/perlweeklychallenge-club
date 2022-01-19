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

function fraction() {
    let r = Object.create(fraction.methods);
    r.n = 1;
    r.d = 1;
    return r;
}

fraction.methods = {
    get_parent() {
        let nn=this.n;
        let dd=this.d;
        if (nn < dd) {
            dd -= nn
        } else {
            nn -= dd
        }
        let f=fraction();
        f.n=nn;
        f.d=dd;
        return f;
    },

    stringify() {
        return `${this.n}/${this.d}`;
    },

    set_from_string(s) {
        let q=s.split("/");
        this.n=q[0];
        this.d=q[1];
        return this;
    }
}

function p_gp(s) {
    let f=fraction().set_from_string(s);
    let out=[]
    for (let i = 1; i <= 2; i++) {
        f=f.get_parent();
        out.push(f.stringify());
    }
    return out;
}

if (deepEqual(p_gp("3/5"),[ "3/2", "1/2" ])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(p_gp("4/3"),[ "1/3", "1/2" ])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

