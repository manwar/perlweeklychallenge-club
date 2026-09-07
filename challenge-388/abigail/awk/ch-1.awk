#!/opt/homebrew/bin/gawk

function process (n, u, d, prefix) {
    if (d == n) {printf "%s ", prefix}
    if (d < u)  {process(n, u, d + 1, prefix "D")}
    if (u < n)  {process(n, u + 1, d, prefix "U")}
}

{
    process($0, 0, 0, "")
    print ""
}
