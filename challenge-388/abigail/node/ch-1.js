#!/opt/homebrew/bin/node

  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', n => {
    generate (+n, 0, 0, "")
    console . log ("")
})


function generate (n, u, d, prefix) {
    if (d == n) {process . stdout . write (prefix + " ")}
    if (d <  u) {generate (n, u, d + 1, prefix + "D")}
    if (u <  n) {generate (n, u + 1, d, prefix + "U")}
}
