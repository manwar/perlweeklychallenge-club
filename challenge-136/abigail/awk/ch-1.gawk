#!/opt/local/bin/gawk

#
# See ../README.md
#

#
# Run as: gawk -f ch-1.gawk < input-file
#


#
# Find the GCD, using Stein's algorithm
#    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
#
function gcd (u, v, u_odd, v_odd) {
    u_odd = u % 2
    v_odd = v % 2

    return u == v || !v     ? u                                             \
         :           !u     ? v                                             \
         : !u_odd && !v_odd ? lshift (gcd(rshift (u, 1), rshift (v, 1)), 1) \
         : !u_odd && !v_odd ?         gcd(rshift (u, 1), v)                 \
         : !u_odd && !v_odd ?         gcd(u,             rshift (v, 1))     \
         :  u     >   v     ?         gcd(u - v,         v)                 \
         :                            gcd(v - u,         u)
}

#
# Pre calculate powers of 2. We can do powers up to and including 2^52
#
BEGIN {
    for (i = 1; i <= 52; i ++) {
        power_of_2 [lshift (1, i)] = 1
    }
}


{
    print power_of_2 [gcd($1, $2)] || 0
}
