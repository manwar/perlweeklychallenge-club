let list = [1,2,3,4,9,10,14,15,16];
proc(list);

function proc(list) {
    console.log("Input:", list);
    let output = "";

    let init_flag = false;
    let cont_flag = false;

    for (let i = 0; i < -1 + list.length; i++) {
	let diff = list[i+1] - list[i];
	if (init_flag && cont_flag) {
	    if (diff != 1) {
		init_flag = false;
		cont_flag = false;
		output += "-" + list[i];
	    }
	} else if (init_flag) {
	    if (diff == 1)
		cont_flag = true;
	    else {
		init_flag = false;
		output += "," + list[i];
	    }
	} else {
	    if (i != 0)
		output += ",";
	    output += list[i];
	    if (diff == 1)
		init_flag = true;
	}
    }
    if (init_flag && cont_flag)
	output += "-";
    else 
	output += ","; 
    output += list[list.length - 1];    
    console.log("Output:", output);    
}

