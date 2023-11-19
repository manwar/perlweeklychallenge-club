#!/usr/bin/env node
'use strict';

// Procedural, with manual accumulator
function task1a ( ns ) {
    let ret = 0;

    for     ( const [i, left] of ns.entries()  )
        for ( const     right of ns.slice(i+1) )
            if ( left > (right * 2) )
                ret++;

    return ret;
}

// task1a, with inner loop (for&if) refactored to functional (filter&length).
function task1b ( ns ) {
    let ret = 0;
    for ( const [i, left] of ns.entries() ) {
        ret += ns.slice(i+1).filter((right) => left > (right * 2)).length;
    }
    return ret;
}

// task1b, with the filter expression extracted to a named local function.
function task1c ( ns ) {
    let ret = 0;
    for ( const [i, left] of ns.entries() ) {

        const is_reverse_pair = (right) => left > (right * 2);

        ret += ns.slice(i+1)
                 .filter(is_reverse_pair)
                 .length;
    }
    return ret;
}

// task1c, with the outer loop refactored to .map(), and accumulator embedded in a .reduce().
function task1d ( ns ) {
    const add = (a, b) => a + b;

    const count_of_reverse_pairs_with_left = ([i, left]) => {

        const is_reverse_pair = (right) => left > (right * 2);

        return ns.slice(i+1)
                 .filter(is_reverse_pair)
                 .length;
    }

    return [...ns.entries()].map( count_of_reverse_pairs_with_left ).reduce(add, 0);
}

// Cannot use a faster .reduce directly on Iterator; experimental feature provided by Node.
function task1e ( ns ) {
    const count_of_reverse_pairs_with_this_element = (accumumlator, [i, left]) => {
        const is_reverse_pair = (right) => left > (right * 2);

        const count = ns.slice(i+1)
                        .filter(is_reverse_pair)
                        .length;

        return accumumlator + count;
    }

    return [ ...ns.entries() ].reduce(count_of_reverse_pairs_with_this_element, 0);
}

// task1d with map+reduce merged
function task1f ( ns ) {
    // const add = (a, b) => a + b;

    const reverse_pairs = ([i, left]) => {

        const is_reverse_pair = (right) => left > (right * 2);

        return ns.slice(i+1)
                 .filter(is_reverse_pair)
                 .length;
    }
    const sum_reverse_pairs = (a, e) => a + reverse_pairs(e);

    return [ ...ns.entries() ].reduce(sum_reverse_pairs, 0);
}

// pre-doubled once into a parallel `two_n` array, to reduce recalculations.
function task1g ( ns ) {
    const two_n = ns.map( n => 2*n );

    const reverse_pairs = ([i, left]) => {

        const is_reverse_pair = (right) => left > right;

        return two_n.slice(i+1)
                 .filter(is_reverse_pair)
                 .length;
    }
    const sum_reverse_pairs = (a, e) => a + reverse_pairs(e);

    return [ ...ns.entries() ].reduce(sum_reverse_pairs, 0);
}

// Extracted "combinations"
function task1h ( ns ) {
    const combinations_2 = (arr, func) => {
        arr.forEach( (left,i) => {
            arr.slice(i+1).map( (right) => func(left, right) );
        });
    }

    let count = 0;
    const count_wanted = (L,R) => { if ( L > (R * 2) ) count++ };
    combinations_2(ns, count_wanted);
    return count;
}

const subs = [
    [ 'task1a', task1a ],
    [ 'task1b', task1b ],
    [ 'task1c', task1c ],
    [ 'task1d', task1d ],
    [ 'task1e', task1e ],
    [ 'task1f', task1f ],
    [ 'task1g', task1g ],
    [ 'task1h', task1h ],
];
const tests = [
    [ 2, [1, 3, 2, 3, 1],  'Example 1 from task' ],
    [ 3, [2, 4, 3, 5, 1],  'Example 2 from task' ],
    [ 0, []             ,  'Null array' ],
];
let test_number = 0;
function is ( got, expected, desc ) {
    test_number++;
    const ok_msg = (got === expected) ? "ok" : "not ok";
    const description = (typeof desc !== 'undefined') ? ` - ${desc}` : '';
    console.log(`${ok_msg} ${test_number}${description}`);
}
for     ( const [ sub_name, task1_coderef    ] of subs  ) {
    for ( const [ expected, input, test_name ] of tests ) {
        const got = task1_coderef(input);
        is( got, expected, `${sub_name}: ${test_name}`);
    }
}
