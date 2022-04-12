#! /usr/bin/node

function fim (n0) {
    let words=["zero","one","two","three","four",
               "five","six","seven","eight","nine"]
    let n=n0
    let p=[]
    while (true) {
        let s=words[n] + " is "
        if (n == 4) {
            s += "magic."
            p.push(s)
            break
        } else {
            n=words[n].length
            s += words[n]
            p.push(s)
        }
    }
    return p.join(", ").replace(/^\w/,function (c) {
        return c.toUpperCase()
    })
}

if (fim(5) == "Five is four, four is magic.") {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (fim(7) == "Seven is five, five is four, four is magic.") {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (fim(6) == "Six is three, three is five, five is four, four is magic.") {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (fim(4) == "Four is magic.") {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
