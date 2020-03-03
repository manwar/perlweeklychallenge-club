use v6.d;
unit sub MAIN() {
    my constant @INTERVALS = ((2, 7), (3, 9), (10, 12), (15, 19), (18, 22));
    # - Flatten @INTERVALS:
    #   => (2, 7, 3, 9, 10, 12, 15, 19, 18, 22)
    # - Take the first number:
    #   => (2)
    # - Take any pairs of numbers in between the first and last ones where the
    #   first is lesser than the second (those that aren't overlap):
    #   => (2, 9, 10, 12, 15)
    # - Take the last number:
    #   => (2, 9, 10, 12, 15, 22)
    # - Pair the numbers back together:
    #   => ((2, 9), (10, 12), (15, 22))
    say (.[0], |.[0^..^*-1].grep(* < *).flat, .[*-1]).rotor(2) given @INTERVALS.flat;
}
