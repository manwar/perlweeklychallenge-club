#! /usr/bin/env raku

unit sub MAIN ($results where * ~~ /^ <[HA]> ** 6 $/,
              :n($nice),
              :v(:$verbose));


my @results = $results.comb;

## Week 1 ##

my ($winner1, $looser1) = @results[0] eq "H" ?? (2,7) !! (7,2);
my ($winner2, $looser2) = @results[1] eq "H" ?? (3,6) !! (6,3);
my ($winner3, $looser3) = @results[2] eq "H" ?? (4,5) !! (5,4);

my @seeded1 = ($winner1, $winner2, $winner3).sort;

## Week 2 ##

my ($winner4, $looser4) = @results[3] eq "H" ?? (1, @seeded1[2]) !! (@seeded1[2], 1);
my ($winner5, $looser5) = @results[4] eq "H" ?? (@seeded1[0], @seeded1[1]) !! (@seeded1[1], @seeded1[0]);

my @seeded2 = ($winner4, $winner5).sort;

## Week 3 ##

my ($winner6, $looser6) = @results[5] eq "H" ?? (@seeded2[0], @seeded2[1]) !! (@seeded2[1], @seeded2[0]);

if $verbose
{
  my %ha = ( H => 'home', A => 'away' );

  say ": Week 1: Team $winner1 (%ha{@results[0]}) won against team $looser1";
  say ": Week 1: Team $winner2 (%ha{@results[1]}) won against team $looser2";
  say ": Week 1: Team $winner3 (%ha{@results[2]}) won against team $looser3";
  say ": Week 2: Team $winner4 (%ha{@results[3]}) won against team $looser4";
  say ": Week 2: Team $winner5 (%ha{@results[4]}) won against team $looser5";
}

say "Team $winner6 { $nice ?? "won against" !! "defeated" } Team $looser6";