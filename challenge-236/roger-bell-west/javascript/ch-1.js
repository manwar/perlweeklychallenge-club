#! /usr/bin/node

"use strict"

function Reserve(vv) {
    let r = Object.create(Reserve.methods);
    let vq = vv.sort(function(a, b) {
        return b - a;
    });
    r.values = vq;
    r.counts = [];
    r.vm = new Map;
    for (let i = 0; i < vq.length; i++) {
        r.counts.push(0);
        r.vm.set(vq[i], i);
    }
    return r;
}

Reserve.methods = {
    makechange(price, tendered) {
        let val = 0;
        for (let note of tendered) {
            if (!this.vm.has(note)) {
                return false;
            }
            this.counts[this.vm.get(note)]++;
            val += note;
        }
        if (val < price) {
            return false;
        }
        val -= price;
        for (let bid = 0; bid < this.values.length; bid++) {
            while (val >= this.values[bid] && this.counts[bid] > 0) {
                val -= this.values[bid];
                this.counts[bid]--;
            }
        }
        return (val == 0);
    }
}

function exactchange(a) {
    var reserve = Reserve([5, 10, 20])
    for (let tendered of a) {
        if (!reserve.makechange(5, [tendered])) {
            return false;
        }
    }
    return true;
}


if (exactchange([5, 5, 5, 10, 20])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!exactchange([5, 5, 10, 10, 20])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (exactchange([5, 5, 5, 20])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
