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

function is_power_of_n (number, n) {
    return number <  1 ? 0  \
         : number == 1 ? 1  \
         : number %  n ? 0  \
         : is_power_of_n(number / n, n)
}

function is_power_of_2 (number) {
    return is_power_of_n(number, 2)
}
                 

{
    r = gcd($1, $2)
    print (r > 1 && is_power_of_2(r) ? 1 : 0)
}
