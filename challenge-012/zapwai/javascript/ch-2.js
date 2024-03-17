let input = `/a/b/c/d
/a/b/cd
/a/b/cc
/a/b/c/d/e`;

function proc(input) {
    let line = input.split("\n");
    let prefix = line[0];
    let cnt = 1;
    while (cnt > 0) {
        cnt = 0;
        prefix = prefix.slice(0,prefix.lastIndexOf("/"));
        for (let i = 0; i < line.length; i++) {
	    let pattern = new RegExp("^"+prefix+"/");
            if (!pattern.test(line[i])) {
		cnt++;
	    }
	}
    }
    return prefix;
}

console.log(proc(input))
