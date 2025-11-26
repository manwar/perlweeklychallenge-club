#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Task 2: Covert Time          Submitted by: Mohammad Sajid Anwar
You are given two strings, $source and $target, containing time in 24-hour time form.
Write a script to convert the source into target by performing one of the following operations:

1. Add  1 minute
2. Add  5 minutes
3. Add 15 minutes
4. Add 60 minutes
Find the total operations needed to get to the target.
=end comment

my @Test =
    # source    target  exp
    "02:30", "02:45", 1,
    "11:55", "12:15", 2,
    "09:00", "13:00", 4,
    "23:45", "00:30", 3,
    "14:20", "15:25", 2,

    "00:40", "00:40", 0,
;
plan +@Test ÷ 3;

constant MINUTE       =  1;
constant TWELFTH-HOUR =  5;
constant QTR-HOUR     = 15;
constant HOUR         = 60;
constant DAY          = 24*HOUR;

# Time of day as HHMM to integer minutes.
multi tod( Str:D $hh-mm -->Int:D) {
    my $hh = $hh-mm.substr(0,2);  die 'Bad hour'      unless $hh ~~ ^24;
    my $mm = $hh-mm.substr(3);    die 'Bad minute'    unless $mm ~~ ^HOUR;
    my $sep= $hh-mm.substr(2,1);  die 'Bad separator' unless ':' eq $sep;
    $hh*HOUR + $mm;
}
# Time of day in integer minutes to HHMM string.
multi tod( Int:D $mod where * ~~ ^DAY -->Str:D) {
    ($mod div HOUR).fmt( '%02s')  ~  ':'   ~  ($mod % HOUR).fmt( '%02s')
}

sub task( Str:D $source, Str $target -->Int) {
    my $src = tod( $source);
    my $trg = tod( $target);
    my $diff = do given $src <=> $trg {
        when More { $trg + DAY - $src }
        when Less { $trg - $src       }
        return 0;
    }

    my $steps;
    for HOUR, QTR-HOUR, TWELFTH-HOUR, MINUTE -> $s {
        $steps += $diff div $s;
        $diff  %= $s;
    }
    $steps;
}

for @Test -> $src, $targ, $exp {
    is task( $src, $targ), $exp, "{$exp // $exp.^name()} <- $src ∘> $targ";
}
done-testing;

my $source = "11:55";
my $target = "10:47";

say qq{\nInput: \$source = "$source"\n       \$target = "$target"}
   ~qq{\nOutput:  &task($source, $target)};
