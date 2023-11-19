// Procedural
function task2a ( ns ) {
    let ret = 0;
    for     ( const x of ns ) {
        for ( const y of ns ) {
            ret += Math.floor( x / y );
        }
    }
    return ret;
}

// Functional, both using extracted code for Cartesian product.
const cartesian =
  (...top_level_arrays) => top_level_arrays.reduce(
      (accum, an_array) => accum.flatMap(
             (element1) => an_array.map(
             (element2) => [element1, element2].flat()
)));

// .map(), then sum via .reduce .
function task2b  (ns) {
    return cartesian(ns, ns)
          .map(([x,y]) => Math.floor(x/y))
          .reduce(((a,b) => a+b),0);
}

// Do the summing *and* mapping during the .reduce .
const task2c = (ns) => cartesian(ns, ns).reduce(((a,[x,y]) => a+Math.floor(x/y)),0);



let test_number = 0;
function is ( got, expected, desc ) {
    test_number++;
    const ok_msg = (got === expected) ? "ok" : "not ok";
    const description = (typeof desc !== 'undefined') ? ` - ${desc}` : '';
    console.log(`${ok_msg} ${test_number}${description}`);
}
const subs = [
    [ 'task2a', task2a ],
    [ 'task2b', task2b ],
    [ 'task2c', task2c ],
];
const tests = [
    [ 10, [2, 5, 9]      , 'Example 1 from task'],
    [ 49, [7,7,7,7,7,7,7], 'Example 2 from task'],
    [ 10, [2, 5, 9]      , 'Null array'],
];
for     ( const [ sub_name, task2_coderef    ] of subs  ) {
    for ( const [ expected, input, test_name ] of tests ) {
        const got = task2_coderef(input);
        is( got, expected, `${sub_name}: ${test_name}`);
    }
}
