#! /usr/bin/node

"use strict"

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

function combinations(arr, k) {
    let c = [];
    for (let i = 0; i < k; i++) {
        c.push(i);
    }
    c.push(arr.length);
    c.push(0);
    let out = [];
    while (true) {
        let inner = [];
        for (let i = k-1; i >= 0; i--) {
            inner.push(arr[c[i]]);
        }
        out.push(inner);
        let j = 0;
        while (c[j] + 1 == c[j + 1]) {
            c[j] = j;
            j += 1;
        }
        if (j >= k) {
            break;
        }
        c[j] += 1;
    }
    return out;
}

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
}

let deck = [];
for (let suit = 0; suit <= 3; suit++) {
    for (let rank = 1; rank <= 13; rank++) {
        deck.push([rank, suit]);
    }
}

let hands = new Map;
combinations(deck, 5).forEach((hand) => {
    let bin = 0;
    let ranks = hand.map(x => x[0]);
    ranks.sort(function(a, b) {
        return a - b;
    });
    const ranksc = counterify(ranks);
    let ranksk = [...ranksc.values()];
    ranksk.sort(function(a, b) {
        return b - a;
    });
    let suits = hand.map(x => x[1]);
    suits.sort(function(a, b) {
        return a - b;
    });
    const suitsc = counterify(suits);
    let suitsk = [...suitsc.values()];
    suitsk.sort(function(a, b) {
        return b - a;
    });
    // Can't generate 5 of a kind.
    // Royal flush
    if (suitsc.size == 1 &&
        deepEqual(ranks, [1, 10, 11, 12, 13])) {
        bin = 2;
    }
    // Straight flush
    if (bin == 0 &&
        suitsc.size == 1 &&
        Math.min(...ranks) + 4 == Math.max(...ranks)) {
        bin = 2;
    }
    // Four of a kind
    if (bin == 0 && ranksk[0] == 4) {
        bin = 3;
    }
    // Full house
    if (bin == 0 && ranksk[0] == 3 && ranksk[1] == 2) {
         bin = 4;
    }
    // Flush
    if (bin == 0 && suitsk[0] == 5) {
        bin = 5;
    }
    // Straight
    if (bin == 0 &&
        // match full rank struct
        (
            (ranks[0] + 1 == ranks[1] &&
             ranks[1] + 1 == ranks[2] &&
             ranks[2] + 1 == ranks[3] &&
             ranks[3] + 1 == ranks[4])
                ||
                deepEqual(ranks, [1, 10, 11, 12, 13])
        )) {
        bin = 6;
    }
    // Three of a kind
    if (bin == 0 && ranksk[0] == 3) {
        bin = 7;
    }
    // Two pair
    if (bin == 0 && ranksk[0] == 2 && ranksk[1] == 2) {
        bin = 8;
    }
    // One pair
    if (bin == 0 && ranksk[0] == 2) {
        bin = 9;
    }
    // Anything else is High card
    if (bin == 0) {
        bin = 10;
    }
    if (!hands.has(bin)) {
        hands.set(bin, 0);
    }
    hands.set(bin, hands.get(bin) + 1);
});
let tot = 0;
for (let k of [...hands.keys()].sort(function(a, b) {
    return a - b;
})) {
    console.log(k + " " + hands.get(k));
    tot += hands.get(k);
}
console.log("total " + tot);
