const l1 = '{%  id   field1="value1"    field2="value2"  field3=42 %}';
const l2 = '{%  youtube title="Title \"quoted\" done" foo="bar" baz=31 %}';
const l3 = '{%  youtube title="Title with escaped backslash \\" %}';
const l4 = '{% id field="val1" field2="val2" %}';
const l5 = '{% test field1="value1" df=42 %}';
const l6 = 'LINES';
const l7 = 'More Lines';
const l8 = '{% endtest %}';

function prev_space(pos, line) {
    let i = pos;
    while (line.charAt(i) != " ") {
	i--;
    }
    return i;
}

function proc(line_num, line, field, value) {
    if (line.charAt(0) == '{') {
	let eq_pos = [];
	for (let i = 2; i < line.length; i++) {
	    if (line.charAt(i) == '=') {
		eq_pos.push(i);
	    }
	}
	let num_of_fields = eq_pos.length;
	let id = "";
	let id_flag = true;
	for (let i = 3; i < line.length; i++) {
	    if (id_flag && (line[i] == ' ')) {
		continue;
	    }
	    else if (id_flag) {
		id += line.charAt(i);
		id_flag = false;
	    }
	    else {
		if (line.charAt(i) == ' ') {
		    break;
		} else {
		    id += line.charAt(i);
		}
	    }
	}

	if (id.substring(0,3) == "end") {
	    return;
	}
	
	console.log("Name =>", id);

	field[line_num] = [];

	    for (let i = 0; i < num_of_fields; i++) {
		let eq = eq_pos[i];
		let sp = prev_space(eq, line);
		let word = "";
		for (let k = sp + 1; k < eq; k++) {
			word += line.charAt(k);
		}
		field[line_num].push(word);
	    }

	value[line_num] = [];
	for (let l = 0; l < num_of_fields - 1; l++) {
	    let eq = eq_pos[l];
	    let eq_next = eq_pos[l + 1];
	    let fieldlen = field[line_num][l + 1].length;
	    let value_word = "";
	    for (let k = eq + 1; k < eq_next - fieldlen; k++) {
		value_word += line.charAt(k);
	    }
	    value[line_num].push(value_word);
	}
	let eq = eq_pos[num_of_fields - 1];
	let last_field = "";
	for (let i = eq + 1; i < line.length - 3; i++) {
	    last_field += line.charAt(i);
	}
	value[line_num].push(last_field);
	console.log("Fields => {");
	for (let l = 0; l < num_of_fields; l++) {
	    console.log("\t",field[line_num][l], "->", value[line_num][l]);
	}
	console.log("}");
    } else {
	console.log("Text =>", line);
    }
}

function main() {
    let field = [], value = [];
    let i = 0;
    for (let l of [l1, l2, l3, l4, l5, l6, l7, l8]) {
	proc(i, l, field, value);
	i++;
    }
}

main();
