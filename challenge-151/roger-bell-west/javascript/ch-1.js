#! /usr/bin/node

function str2tree (st) {
    let o=[0];
    let d=0;
    let p=0;
    for (let e of st.match(/\S+/g)) {
        if (e == "|") {
            d++;
            p=0;
            m=(1<<(d+1))-1;
            while (o.length < m) {
                o.push(0);
            }
        } else {
            let y=0;
            if (e != "*") {
                y=e;
            }
            let i=(1<<d) -1 +p;
            o[i]=y;
            p++;
        }
    }
    return o;
}

function mindepth(tree) {
    let firstleaf=tree.length;
    for (let i=0; i < tree.length; i++) {
        if (tree[i]==0) {
            continue;
        } else if ((i+1) << 1 >= tree.length ) {
            firstleaf=i;
            break;
        } else {
            let ni=((i+1) << 1)-1;
            if (tree[ni]==0 && tree[ni+1]==0) {
                firstleaf=i;
                break;
            }
        }
    }
    let t=firstleaf+1;
    let d=0;
    while (t>0) {
        t >>= 1;
        d++;
    }
    return d;
}

if (mindepth(str2tree("1 | 2 3 | 4 5")) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (mindepth(str2tree("1 | 2 3 | 4 *  * 5 | * 6")) == 3) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

