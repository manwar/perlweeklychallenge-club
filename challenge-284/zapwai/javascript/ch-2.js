let list1 = [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5];
let list2 = [2, 1, 4, 3, 5, 6];
proc(list1, list2);
list1 = [3, 3, 4, 6, 2, 4, 2, 1, 3];
list2 = [1, 3, 2];
proc(list1, list2);
list1 = [3, 0, 5, 0, 2, 1, 4, 1, 1];
list2 = [1, 0, 3, 2];
proc(list1, list2);

function proc(l1, l2) {
    console.log("Input:");
    console.log(l1);
    console.log(l2);
    let tail = [];
    for (let item of list1) {
	let elem_of_l2_flag = 0;
	for (let item2 of list2) {
	    if (item == item2) {
		elem_of_l2_flag = 1;
		break;
	    }
	}
	if (elem_of_l2_flag == 0) {
	    tail.push(item);
	}
    }
    let pre = [];
    for (let item2 of list2) {
	for (let item of list1) {
	    if (item == item2) {
		pre.push(item);
	    }
	}
    }
    let sorted_tail = tail.sort();
    let out = pre;
    for (let t of sorted_tail) {
	out.push(t);
    }
    console.log("Output:", out);
}
