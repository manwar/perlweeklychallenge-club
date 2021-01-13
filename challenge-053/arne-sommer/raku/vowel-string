#! /usr/bin/env raku

unit sub MAIN (Int $n where 1 <= $n <= 5, :$verbose);

my @start = <a e i o u>;
my %next;

%next<a> = <e i>;
%next<e> = <i>;
%next<i> = <a e o u>;
%next<o> = <a u>;
%next<u> = <o e>;

say ": ", %next       if $verbose;
say ": ", %next.raku  if $verbose;

do-it($_) for @start;

sub do-it ($string)
{
  if $string.chars == $n
  {
     say $string;
  }
  else
  {
    my $last = $string.substr(*-1);
    say ": $string -> { @(%next{$last}).join("|") }" if $verbose;
    do-it("$string$_") for @(%next{$last});
  }
}
