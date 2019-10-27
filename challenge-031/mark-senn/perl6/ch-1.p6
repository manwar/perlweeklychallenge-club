#
# Perl Weekly Challenge - 031
# Task #1
#
# Mark Senn, http://engineering.purdue.edu/~mark
# October 25, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-031#task-1
#     Create a function to check divide by zero error
#     without checking if the denominator is zero.
#
# Below are three ways to do this.
#

# Perl 6 is in the process of being renamed Raku.
# Run using Raku v6.d;
use v6.d;


# Return $c or, if $c is undefined return Inf and let
# the caller handle that.
sub div1($a, $b) {
    my $c = $a / $b;
    return $c  //  Inf;
}


# Raise a "/0 or other problem" exception.  I'm using "or other problem"
# in case something else (maybe a bug) causes $c to be Inf.
# This code is based on code from
#     https://docs.perl6.org/type/Failure
sub div2($a, $b) {
    my $c = $a / $b;  
    ($c == Inf)  and  fail '/0 or other problem';
    return $c;
}


sub div3($a, $b) {
    my $c;
    try {
        CATCH {
            when (X::Numeric::DivideByZero)  { return '  /0 or other problem'; }
        }
        $c = $a / $b;
    }
    return "  $c";
}


sub MAIN() {

    my $n = 10;

    print 'div1:';
    for (0,2) -> $d {
        my $c = div1($n, $d);
        ($c == Inf)
            ??  '  /0 or other problem'.print
            !!  "  $c".say;
    }

    print 'div2:';
    for (0,2) -> $d {
        with div2($n, $d) -> $c {
            "  $c".say;
        }  else  {
            "  {.exception.message}".print;
        }
    }

    print 'div3:';
    for (0,2) -> $d {
        # This won't work without using ".Num".
        my $c = div3($n.Num, $d.Num);
        $c.print;
    }
    ''.say;

}

