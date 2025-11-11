#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;
use Lingua::EN::Numbers;

=begin comment
May be edited for space.
347-1: Format Date             Submitted by: Mohammad Sajid Anwar
You are given a date in the form: 10th Nov 2025.
Write a script to format the given date in the form: 2025-11-10 using the set below.

@DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
@MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
@YEARS  = (1900..2100)

=end comment

my @Test =
    "1st Jan 2025",     "2025-01-01",
    "22nd Feb 2025",    "2025-02-22",
    "15th Apr 2025",    "2025-04-15",
    "23rd Oct 2025",    "2025-10-23",
    "31st Dec 2025",    "2025-12-31",
;
my @Dead =  "31st Dec 2225",
            "31st Dec 1825",
            "32st Dec 1925",
            "11st Dec 1925",
            "30st Feb 2025",
            "31nd Dec 2025",
;
plan +@Dead + +@Test ÷ 2;

my @month = <Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec>;
my %month-number = @month [Z=>] [1...12];
my @day-of-month = (1...31)».&ordinal-digit;
constant \year-min = 1900;
constant \year-max = 2100;

# strict about the input spec
multi task( Str:D $a -->Str:D) {
    my $m = $a  ~~ m/ ^  (<[123]>?  <[1..9]>) (<:L>**2)
                      \s (@month)
                      \s (\d\d\d\d) $ /;
    my $candi = "$m[3]-%month-number{$m[2]}.fmt('%02s')-" ~ "$m[0].fmt('%02s')";
    die "Input '$a' does not represent a valid date"
       unless  $candi.Date ~~ Date:D
            and year-min  ≤ $m[3] ≤ year-max
            and $m[0] ~ $m[1] eq $m[0].&ordinal-digit;
    return $candi;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
for @Dead -> $in {
    dies-ok { task $in }, "$in.raku() dies";
}
done-testing;

my $str = "31st Dec 2025";

say qq{\nInput: \$str = "$str"\nOutput: }, task $str;
