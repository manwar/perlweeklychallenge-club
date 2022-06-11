#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;
use Test;
use lib $?FILE.IO.parent(1).add("lib");
use Odd-Brazilian;

# ~TASK #2 › Brazilian Number

constant TEST = False;

my $EXPLAIN = True;  # Justify answers
my @Justify;            # Ephemeral support for explanation

if TEST {
    $EXPLAIN = False;
    plan 10 + 2;
    for 4, 7, 8, 25, 36, 37, 151, 153, 25_611, 1_000_002 -> $n {
        my $exp = check-brazilian($n);
        is is-brazilian($n), $exp, "brazilian";
    }
    dies-ok { check-brazilian(25_613) }, "Limit of testing";
    dies-ok { check-brazilian(3) },      "Limit of testing";
    exit;
}

sub MAIN( $n where $n > 3 = 25613 ) {
    $EXPLAIN = True;
    my $boo = is-brazilian($n);
    say "Input: \$n = $n\n"
        ~ "Output: $boo.Int()\n"
        ~ "\n" ~ _consume-data( $boo);
}

sub is-brazilian( $n , Bool :$EXPLAIN -->  Bool ) {
    for 2...$n-2 -> $base {
        if $base < 37  {
            my $base-num = $n.base( $base);
            return True if is-repdigit( $n, $base-num, $base);
        }
        if $base ≥ 37 {
            my @base-num;
            my $balance = $n;
            while $balance > $base {
                my $rem = $balance % $base;
                @base-num.unshift: $rem;
                $balance = Int($balance / $base);
            }
            @base-num.unshift($balance) if $balance > 0;
            return True if is-repdigit( $n, @base-num, $base);
        }
    }
    return False;
}

multi sub is-repdigit ( Int $n, Str $base-num, Int $base --> Bool ) {
    my $f = $base-num.substr( 0, 1);
    my $ret =  Bool($base-num ~~ / ^ $f + $ /);
    @Justify.push: [ $n, $base-num, $base, $ret] if $EXPLAIN;
    $ret;
}

multi sub is-repdigit ( Int $n, @base-num, Int $base --> Bool ) {
    my $ret = so @base-num.all == @base-num[0];
    @Justify.push: [ $n, @base-num, $base, $ret] if $EXPLAIN;;
    $ret;
}

# TODOable: more is-repdigit w/o storing @Justify; flag or no 1st Int

sub check-brazilian( $n ) {
    die "Err domain: $n" if $n < 4 or ( $n > $test-limit and not $n %% 2);
    return True if ( %odd-brazilian{"$n"}:exists )
                    or ( ($n %% 2) and ($n ≥ 8) );
    return False;
}

enum Idx ( :num(0), :base-num(1), :base(2), :is-BRA(3) );
sub _consume-data ( Bool $is-bra --> Str ) {
    if $is-bra {
        my $e = @Justify.first: { $_[is-BRA] };
        return "Since $e[num] in base $e[base] is $e[base-num].gist().";
    }

    my $ret;                                              # gather???
    for 0 .. @Justify.end -> $i {

        $ret ~= $i == 0 ?? "Since " !!  " " x 6;

        $ret ~= "@Justify[$i][num] in base @Justify[$i][base]"
                 ~ " is @Justify[$i][base-num].gist()";

        $ret ~= ",\n"    if $i ≤  @Justify.end -2;
        $ret ~= " and\n" if $i == @Justify.end -1;
        $ret ~= ".\n"    if $i == @Justify.end;
    }
    return $ret;
}
