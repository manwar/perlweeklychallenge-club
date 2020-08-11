#!perl
use strict;
use warnings FATAL => qw(all);

use Benchmark qw(:all) ;









my $message = <<'EOF';
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
EOF


# In two ways: 

cmpthese(-1, {
    'arrays' => \&arrays,
    'strings' => \&strings,
});

=output
With print:
           Rate  arrays strings
arrays  10612/s      --    -34%
strings 16037/s     51%      --





With print commented out:
           Rate  arrays strings
arrays  15292/s      --    -31%
strings 22226/s     45%      --
=cut

sub arrays
{
     my @strings =  map [split(/\s/, $_)], split(/\n/, $message);

     my $max_idx = $#{$strings[0]};
     my @cols = map { my $idx = $_; 
          my @slice = map $_->[$idx] // '', @strings; [@slice];
          } 0 .. $max_idx;

     my @doubles = map { my %seen; grep $seen{$_}++ > 0, @$_;} @cols;

     # print join('',@doubles), $/; # PerlRaku
}


sub strings
{
     my @strings =  map {tr/ //ds; $_;} split(/\n/, $message);
     my $len = length($strings[0]);


     # BrowserUK: http://www.perlmonks.org/?node_id=1202721:
     my $buf = chr(0)  x $len;
     my @cRefs = map \substr( $buf, $_, 1 ), 0 .. $len - 1;

     my $txt;

     for my $idx ( 0 .. $len - 1 )
     {
          my ($letter) = do 
          { 
               my %seen; 
               grep $seen{$_}++ > 0, 
               map { substr( $buf, 0 )  = $_; ${ $cRefs[ $idx ] }; } @strings; 
          };
     $txt .= $letter;
     }

     # print $txt, $/; # PerlRaku
}