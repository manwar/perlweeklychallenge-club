function main() {
    let items1c = [ [1,1], [2,1], [3,2] ];
    let items2c = [ [2,2], [1,3] ];
    let items1a = [ [1,2], [2,3], [1,3], [3,2] ];
    let items2a = [ [3,1], [1,3] ];
    let items1b = [ [1,1], [2,2], [3,3] ];
    let items2b = [ [2,3], [2,4] ];
    proc(items1c, items2c);
    proc(items1a, items2a);
    proc(items1b, items2b);
}

function print_input(items1, items2) {
    console.log("Input:", items1, items2);
}

function print_output(h) {
    console.log("Output:", h);
}

function proc(items1, items2) {
    print_input(items1, items2);
    let h = {};
    for (let i of items1) {
	h[i[0]] = 0
    }
    for (let i of items2) {
	h[i[0]] = 0
    }
    for (let i of items1) {
	h[i[0]] += i[1];
    }
    for (let i of items2) {
	h[i[0]] += i[1];
    }
    print_output(h);
}

main();
