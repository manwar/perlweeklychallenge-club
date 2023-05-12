#! /usr/bin/node

"use strict"

function word2map(word) {
    let m = new Map();
    for (let c of word.toLowerCase()) {
        if (m.has(c)) {
            m.set(c, m.get(c) + 1);
        } else {
            m.set(c, 1);
        }
    }
    return m;
}

function shallowclonemap(m) {
    let mm = new Map();
    for (let k of m.keys()) {
        mm.set(k, m.get(k));
    }
    return mm;
}

function wordstickers(stickers, word) {
    const w = word2map(word);
    let t = shallowclonemap(w);
    let stick = [];
    for (let s of stickers) {
        let f = word2map(s);
        for (let c of f.keys()) {
            t.delete(c);
        }
        stick.push(f);
    }
    if (t.size > 0) {
        return 0;
    }
    let stack = [[w, 0]];
    while (stack.length > 0) {
        const st = stack.shift();
        if (st[0].size == 0) {
            return st[1];
        } else {
            const n = st[1] + 1;
            for (let sti of stick) {
                let sp = shallowclonemap(st[0]);
                let v = false;
                for (let l of sti.keys()) {
                    if (sp.has(l)) {
                        v = true;
                        const p = sp.get(l) - sti.get(l);
                        if (p > 0) {
                            sp.set(l, p);
                        } else {
                            sp.delete(l);
                        }
                    }
                }
                if (v) {
                    stack.push([sp, n]);
                }
            }
        }
    }
}

if (wordstickers(['perl', 'raku', 'python'], 'peon') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordstickers(['love', 'hate', 'angry'], 'goat') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordstickers(['come', 'nation', 'delta'], 'accomodation') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordstickers(['come', 'country', 'delta'], 'accomodation') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
