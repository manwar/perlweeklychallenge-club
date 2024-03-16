function std(a) {
    b = [];
    rank = 1;
    lvl = a[0];
    for (let i = 0; i < a.length; i++) {
	if (a[i] > lvl) {
	    rank = i + 1;
	    lvl = a[i];
	}
	b.push(rank);
    }
    console.log("Stand:", b);
}

function modi(a) {
    b = [];
    a.reverse();
    lvl = a[0];
    rank = a.length;
    for (let i = 0; i < a.length; i++) {
	if (a[i] < lvl) {
	    rank = a.length - i;
	    lvl = a[i];
	}
	b.push(rank);
    }
    b.reverse();
    console.log("Modif:", b);
}

function den(a) {
    b = [];
    rank = 1;
    lvl = a[0];
    for (let i = 0; i < a.length; i++) {
	if (a[i] > lvl) {
	    rank += 1;
	    lvl = a[i];
	}
	b.push(rank);
    }
    console.log("Dense:", b);
}


function proc(a) {
    console.log("Input:", a);
    std(Array.from(a));
    modi(Array.from(a));
    den(a);
}

let list1 = [1, 2, 2, 3];
let list2 = [1, 4, 6, 6, 8, 10, 10];
let list3 = [1, 2, 2, 4, 4, 4, 5, 7, 9, 11, 11, 11];
let list4 = [3, 3, 6, 6];

for (let a of [list1, list2, list3, list4]) 
    proc(a);

