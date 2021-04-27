#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub is_phone_number_acceptable ($n) {
   scalar(
      $n =~ m{
         \A
         (?:
               \+\d\d     # +nn
            |  \(\d\d\)   # (nn)
            |  \d{4}      # nnnn
         )
         \s+
         \d{10}           # nnnnnnnnnn
         \z
      }mxs
   );
}

sub valid_phone_numbers ($f) {
   $f = ref($f)     ? $f
      : ($f eq '-') ? \*STDIN
      :               do { open my $h, '<', $f or die "$!\n"; $h };
   is_phone_number_acceptable(s{\A\s+|\s+\z}{}rgmxs) && print while <$f>;
}

my $f = shift // do {
   my $input = <<'END';
0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341
END
   open my $fh, '<', \$input;
   $fh;
};

valid_phone_numbers($f);
