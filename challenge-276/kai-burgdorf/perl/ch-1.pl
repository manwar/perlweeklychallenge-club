#!/usr/bin/perl

#@hours = (12, 12, 30, 24, 24);
@hours = (72, 48, 24, 5);

my $paircounter = 0;;
my $i = 0;

foreach( @hours ) {
  my $j = 0;
  my $firstSummand = $_;
  foreach( @hours ) {
    if( $j>$i && (($firstSummand + $_) % 24) == 0) {
      $paircounter++;
      print "Pair $paircounter: ($firstSummand, $_)\n";
    }
    $j++;
  };
  $i++;
}

print "Output: $paircounter\n";

