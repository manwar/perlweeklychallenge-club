#!/usr/bin/env perl
=begin comment
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-05
Challenge 220 Task 1 common Characters ( Perl )
------------------------------------------------
=cut
use strict;
use warnings;
use feature 'say';

my @words = (["Perl", "Rust", "Raku"], ["love", "live", "leave"]);

my $cnt = 0;
my $str = '';
my %found = ();
my $arrlen = 0;

for (my $wd = 0; $wd < scalar @words; $wd ++ ) {
    $arrlen = scalar @{$words[$wd]};
    $str = join('', "a".."z");
    $cnt = 0;

    my $arrelem = 0;
    print("Input: \@words = ");
    while($arrelem < $arrlen){
        print("$words[$wd][$arrelem] ");
        $arrelem++;
    }
    print("\n");

    while ($cnt < length($str)) {
        my $ch = substr($str, $cnt++, 1);
        if ((lc($words[$wd][0]) =~ /$ch/) and (lc($words[$wd][1]) =~ /$ch/) and (lc($words[$wd][2]) =~ /$ch/)) {
            $found{$ch} = 1;
        }
    }

    my @arr = ();
    print("Output: ");
    for my $key (keys %found) {
        push(@arr,$key);
    }
    my $str = join(",",sort(@arr));
    print("\($str\)\n\n");
    %found = ();
}

=begin comment
------------------------------------------------
SAMPLE OUTPUT
perl .\CommonChars.pl

Input: @words = Perl Rust Raku
Output: (r)

Input: @words = love live leave
Output: (e,l,v)
------------------------------------------------
=cut

