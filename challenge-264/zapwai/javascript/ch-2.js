let source  = [0, 1, 2, 3, 4];
let indices = [0, 1, 2, 2, 1];
proc(source, indices);

source  = [1, 2, 3, 4, 0];
indices = [0, 1, 2, 3, 0];
proc(source, indices);

source = [1];
indices = [0];
proc(source, indices);

function proc(s, i) {
    let source = s;
    let indices = i;
    console.log("Input:", source, indices);
    let target = [];
    for (let i = 0; i < source.length; i++) {
	let chunk = target.splice(indices[i]);
	target[indices[i]] = source[i];
	if (chunk.length > 0)
	    for (let j = 0; j < chunk.length; j++)
		target.push(chunk[j]);
    }
    console.log("Output:", target);
}
