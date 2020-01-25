# Only 100, please.
#
# You are given a string “123456789”. Write a script that would insert ”+” or
# ”-” in between digits so that when you evaluate, the result should be 100.


# General calculator that handles + and - using Grammars.
grammar Calculator {
    rule TOP {
        <num>+ %% <op>
    }
    token op { '+' | '-' };
    token num { \d+ }
}

class Arithm {
    method TOP($/) {
        my $res = $<num>[0];

        loop (my $i = 1; $i < $<num>.elems; $i++) {
            my $num = Int($<num>[$i]);
            given $<op>[$i - 1] {
                when '+' { $res += $num; }
                when '-' { $res -= $num; }
            }
        }

        $/.make($res);
    }
}

# Subroutine helper that creates all combinations using + and - and uses
# Calculator grammar to check if the combination adds up to the target value.
sub _pmcomb($action, @rest, $target) {
    if (@rest.elems == 0) {
        my $result = Calculator.parse($action, :actions(Arithm)).made;
        if ($result == $target) {
            say $action ~ '=' ~ $result;
        }
    } elsif ($action.chars == 0) {
        _pmcomb(Str(@rest.first), @rest.tail(*-1), $target);
    } else {
        _pmcomb($action ~ '+' ~ @rest.first, @rest.tail(*-1), $target);
        _pmcomb($action ~ '-' ~ @rest.first, @rest.tail(*-1), $target);
        _pmcomb($action ~ '' ~ @rest.first, @rest.tail(*-1), $target);
    }
}

sub pmcomb($str, $n) {
    _pmcomb('', $str.comb, $n);
}

sub pmcomb100($str) {
    pmcomb($str, 100);
}


say "All arithmic combinations of 1234567890 that add up to 100:";
pmcomb100('1234567890');

say "All arithmic combinations of 1234567890 that add up to 101:";
pmcomb('1234567890', 101);

say "All arithmic combinations of 1133557799 that add up to 42:";
pmcomb('1133557799', 42);
