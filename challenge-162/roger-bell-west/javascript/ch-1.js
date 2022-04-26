#! /usr/bin/node

function generate(in0) {
    let in1 = in0.replace(/[^0-9]+/g,"")
    if (in1.length < 12) {
        return 99
    }
    in1 = in1.substring(0,12)
    let s = 0
    let m = 1
    for (let i of String(in1)) {
        s += parseInt(i) * m
        m = 4 - m
    }
    return (10-(s % 10)) % 10
}

function validate(in0) {
    let in1 = in0.replace(/[^0-9]+/g,"")
    if (in1.length < 13) {
        return false
    }
    return generate(in1) == parseInt(in1.charAt(12))
}

if (generate("978-0-306-40615-") == 7) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (generate("978-0-306-40615-7") == 7) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (validate("978-0-306-40615-7") == true) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (validate("978-0-306-46015-7") == false) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
