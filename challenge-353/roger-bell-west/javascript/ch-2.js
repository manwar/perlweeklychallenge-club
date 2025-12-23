#! /usr/bin/node

"use strict"

function validatecoupon(codes, names, status) {
    const rx = new RegExp("^([0-9A-Za-z_]+)$");
    const dep = new Set(["electronics", "grocery", "pharmacy", "restaurant"]);
    let out = [];
    codes.forEach((cc, i) => {
        out.push(cc.search(rx) != -1 &&
            dep.has(names[i]) &&
                 status[i]);
    });
    return out;
}

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

if (deepEqual(validatecoupon(['A123', 'B_456', 'C789', 'D@1', 'E123'], ['electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery'], [true, false, true, true, true]), [true, false, true, false, true])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(validatecoupon(['Z_9', 'AB_12', 'G01', 'X99', 'test'], ['pharmacy', 'electronics', 'grocery', 'electronics', 'unknown'], [true, true, false, true, true]), [true, true, false, true, false])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(validatecoupon(['_123', '123', '', 'Coupon_A', 'Alpha'], ['restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery'], [true, true, false, true, true]), [true, true, false, true, true])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(validatecoupon(['ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4'], ['electronics', 'electronics', 'grocery', 'grocery'], [true, true, true, true]), [true, true, true, true])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(validatecoupon(['CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99'], ['restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics'], [true, true, true, true, false]), [true, true, true, true, false])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
