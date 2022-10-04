#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ '1ac2.34f0.b1c2', '1a:c2:34:f0:b1:c2' ],
  [ 'abc1.20f1.345a', 'ab:c1:20:f1:34:5a' ],
);

is( mac_pack(  $_->[0]), $_->[1] ) foreach @TESTS;
is( mac_submap($_->[0]), $_->[1] ) foreach @TESTS;
is( mac_substr($_->[0]), $_->[1] ) foreach @TESTS;
is( mac_regex( $_->[0]), $_->[1] ) foreach @TESTS;
is( mac_regexg($_->[0]), $_->[1] ) foreach @TESTS;
is( mac_regex2($_->[0]), $_->[1] ) foreach @TESTS;
is( mac_split( $_->[0]), $_->[1] ) foreach @TESTS;

cmpthese( 1_000_000, {
  'pack'   => sub { mac_pack(  $_) for @TESTS; },
  'submap' => sub { mac_substr($_) for @TESTS; },
  'substr' => sub { mac_substr($_) for @TESTS; },
  'regex'  => sub { mac_regex( $_) for @TESTS; },
  'regexg' => sub { mac_regexg($_) for @TESTS; },
  'regex2' => sub { mac_regex2($_) for @TESTS; },
  'split'  => sub { mac_split( $_) for @TESTS; },
});
done_testing();

sub mac_split  { join ':', @{[split /(\w\w)/, pop]}[1,3,5,7,9,11] }
sub mac_regex2 { join':',pop=~/(..)(..).?/g }
sub mac_pack   { sub { pack 'ScScScScScS', $_[0],58, $_[1],58, $_[3],58, $_[4],58, $_[6],58,$_[7] }->( unpack 'SScSScSS', $_[0] ) }
sub mac_regexg { join':',pop=~/(\w.)(\w+)/g }
sub mac_submap { join ':', map { substr $_[0], $_, 2 } 0,2,5,7,10,12 }
sub mac_substr { join ':', substr($_[0],0,2), substr($_[0],2,2), substr($_[0],5,2), substr($_[0],7,2), substr($_[0],10,2), substr($_[0],12,2) }
sub mac_regex  { pop =~ s{(\w\w)(\w\w)[.](\w\w)(\w\w)[.](\w\w)(\w\w)} {$1:$2:$3:$4:$5:$6}r }

__END__
            Rate  split regex2   pack regexg submap substr  regex
split   101626/s     --   -61%   -72%   -77%   -82%   -82%   -95%
regex2  259067/s   155%     --   -28%   -42%   -54%   -54%   -88%
pack    358423/s   253%    38%     --   -20%   -36%   -36%   -83%
regexg  450450/s   343%    74%    26%     --   -19%   -20%   -79%
submap  558659/s   450%   116%    56%    24%     --    -1%   -74%
substr  561798/s   453%   117%    57%    25%     1%     --   -74%
regex  2127660/s  1994%   721%   494%   372%   281%   279%     --

