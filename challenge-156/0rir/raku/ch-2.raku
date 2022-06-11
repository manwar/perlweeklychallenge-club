#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;

# 2 Weird Number

my $n = 5;

my \TEST = False;

if TEST {
    my @w = 70, 836, 4030, 5830, 7192, 7912, 9272, 10430, 10570,
            10792, 10990, 11410, 11690, 12110, 12530, 12670,
            13370, 13510, 13790, 13930, 14770, 15610, 15890,
            16030, 16310, 16730, 16870, 17272, 17570, 17990,
            18410, 18830, 18970, 19390, 19670;

    for     10, 12, 20, 21, 5000, 88,
            70, 836, 4030, 5830, 7192, 7912, 9272, 10430, 10570,
            10792, 10990, 11410, 11690, 12110, 12530, 12670,
            13370, 13510, 13790, 13930, 14770, 15610, 15890,
            16030, 16310, 16730, 16870, 17272, 17570, 17990,
            18410, 18830, 18970, 19390, 19670
    -> $x {
        if is_weird($x) {
            die unless $x == @w.any;
            say $x;
        }else{
            die unless $x == @w.none;
        }
    }
}

sub MAIN( Int $x = 70 ) {
    my @state = is_weird( $x);
    present(  | @state);
    exit;
}

sub is_weird( Int $n where $n > 1, --> Any ) {

    my @proper = ( 1 … Int($n/2) ).grep: $n %% *;
    my $sum = [+] @proper;

    if $n ≥ $sum {  return ( False, @proper, $n, [], 'gte') but False; }

    my $diff = $sum - $n;
    my @equalizer = @proper.grep( * ≤ $diff).combinations;
    sink @equalizer.shift;
    for @equalizer -> @e {
        if $diff == [+] @e {
            return (False, @proper, $n, @e, 'match') but False;
        }
    }
    return ( True, @proper, $n, [], 'fine') but True;
}

sub present( Bool $flag, @proper, Int $n, @variance, Str $annot ) {
    say "Input: \$n = $n\nOutput: $flag.Int()\n";
    _format( $flag, @proper, $n, @variance, $annot );
}

sub _format( Bool $flag, @p, Int $n, @variance, Str $annot ) {
    given $annot {
        when 'gte'   {
            say "Since the proper divisor" ~ _format_list(@p)
            ~ " sum to " ~ ([+] @p)
            ~ " which is not greater than $n.";
        }
        when 'match' {
            say "Since the proper divisor", _format_list(@p),
                " sum to ", ( [+] @p), " but the subset",
                _format_list((@p (-) @variance).Hash.keys.sort).substr(5),
                " does sum to $n." ;
        }
        when 'fine'  {
            say "Since the proper divisors of $n "
                ~ _format_list( @p ).substr( 2) ~ " sums to "
                ~ ([+] @p) ~ " and no subset of divisors sums to $n.";
        }
        default { die "bad annot -- unreachable w/ $n";
        }
    }
    return;
}

sub _format_list( @list --> Str ) {
    given @list.elems {
       when 1 { return "is @list[0] " }
       when 2 { return "s are @list[0] and @list[1] " }
       default { return "s are @list[0..*-2].join(', ') and @list[*-1]" }
    }
    die "unreachable";
}
