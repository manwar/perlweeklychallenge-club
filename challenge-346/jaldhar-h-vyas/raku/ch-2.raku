#!/usr/bin/raku

class DepthFirstSearch {
    has Str $.str is required;
    has Int $.target is required;
    has Int $!n;
    has @!result;

    submethod BUILD(:$str, :$target) {
        $!str = $str;
        $!target = $target;
        $!n = $str.chars;
        @!result = ();
    }

    method find() {
        self!search(0, q{}, 0, 0);
        return @!result;
    }

    method !search($i, $expr, $current, $previous) {
        if $i == $!n {
            if $current == $!target {
                @!result.push($expr);
            }
            return self;
        }

        for 1 .. ($!n - $i) -> $len {
            my $part = $!str.substr($i, $len);
            if $part.chars > 1 && $part ~~ /^0/ {
                next;
            }
            my $num = $part.Int;

            if $i == 0 {
                self!search($i + $len, $part, $num, $num);
            } else {
                self!search(
                    $i + $len, $expr ~ '*' ~ $part,
                    $current - $previous + $previous * $num, $previous * $num);
                self!search($i + $len, $expr ~ '+' ~ $part,
                    $current + $num, $num);
                self!search($i + $len, $expr ~ '-' ~ $part,
                    $current - $num, -$num);
            }
        }
        return self;
    }
}

sub MAIN(
    $str,
    $target
) {
    my $dfs = DepthFirstSearch.new(str => $str, target => $target);
    say q{(}, $dfs.find.map({ "\"$_\"" }).join(q{, }), q{)};
}

