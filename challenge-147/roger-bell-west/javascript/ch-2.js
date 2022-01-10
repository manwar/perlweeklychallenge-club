#! /usr/bin/node

function pentagon(n) {
    return Math.floor(n*(3*n-1)/2);
}

function pentpair() {
    let fpent=[0];
    let rpent=new Map();
    let mx=0;
    let a=1;
    while (true) {
        while (mx < a) {
            mx++;
            fpent.push(pentagon(mx));
            rpent.set(fpent[mx],mx);
        }
        for (b = 1; b < a; b++) {
            let d=fpent[a]-fpent[b];
            if (d < fpent[b]) {
                break;
            }
            if (rpent.has(d)) {
                let s=fpent[a]+fpent[b];
                while (s > fpent[mx]) {
                    mx++;
                    fpent.push(pentagon(mx));
                    rpent.set(fpent[mx],mx);
                }
                if (rpent.has(s)) {
                    console.log("P(%d) + P(%d) = %d + %d = %d = P(%d)",a,b,fpent[a],fpent[b],s,rpent.get(s));
                    console.log("P(%d) - P(%d) = %d - %d = %d = P(%d)",a,b,fpent[a],fpent[b],d,rpent.get(d));
                    throw '';
                }
            }
        }
        a++;
    }
}

pentpair();
