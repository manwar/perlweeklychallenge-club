sub count-primes (Int $n) {
    return (grep ({.is-prime}), 1..$n).elems;
}
for <10 15 1 25> -> $i {
    say "$i \t => ", count-primes $i;
}
