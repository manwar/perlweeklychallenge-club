#!/opt/homebrew/bin/gawk

{
    sf = 1
    for (i = 1; i <= $1; i ++) {
        sf = i * sf + 1 - 2 * (i % 2)
    }
    print (sf)
}
