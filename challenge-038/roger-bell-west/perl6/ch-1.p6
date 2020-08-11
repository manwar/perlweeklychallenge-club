#! /usr/bin/perl6

for @*ARGS -> $dc {
  unless ($dc.chars==7) {
    warn "$dc is wrong length\n";
    next;
  }
  unless ($dc ~~ /^<[0..9]>+$/) {
    warn "$dc has non-digit characters\n";
    next;
  }
  $dc ~~ /^(.)(..)(..)(..)$/;
  my ($cen,$year,$month,$day)=($0,$1,$2,$3);
  if ($cen==2) {
    $year+=1900;
  } elsif ($cen==1) {
    $year+=2000;
  } else {
    warn "$dc has invalid century digit $cen\n";
    next;
  }
  if ($month < 1 || $month > 12) {
    warn "$dc has invalid month $month\n";
    next;
  }
  my $d;
  CATCH {
    $d=Date.new($year,$month,$day);
  }
  unless (defined $d) {
    warn "$dc has invalid day $day\n";
    next;
  }
  say $d.yyyy-mm-dd;
}
