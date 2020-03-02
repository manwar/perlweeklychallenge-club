use v6.d;

#
#       49-1-smallest_multiple.raku
#
#         PWC 49 - TASK #1
#         Smallest Multiple
#             Write a script to accept a positive number as command line argument and
#             print the smallest multiple of the given number consists of digits 0 and
#             1.
#
#         For example:
#
#         For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Int:D $input) {

    my $val;

    for ( 1..* ) {
        $val = $input * $_;
        next if $val ~~ m/<[23456789]>/;
        last;
    }

    $val.say;

}
