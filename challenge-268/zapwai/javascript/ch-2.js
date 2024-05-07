function proc(ints) {
    newt = [];
    console.log("Input:", ints);
    ints.sort();
    while (ints.length > 0) {
        x = ints.shift();
        y = ints.shift();
        newt.push(y)
        newt.push(x)
    }
    console.log("Output:", newt);
}

let ints = [2, 5, 3, 4];
proc(ints)

