#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @ord    = qw(x first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth thirteenth
                forteenth fifteenth sixteenth seventeenth eighteeinth nineteenth);
my @ord_10 = qw(z tenth twentieth thirtieth fortieth fiftieth sixtieth seventiet eightieth ninetieth hundredth);
my @power  = map { [$_,$_.'th'] } qw(x thousand), map { $_.'illion' } qw(m b tr quad quin sext sept oct nov),
              ( map { $a=$_, map { $_.$a } qw(un duo tre quattuor quin sex sept octo novem) }
              qw(dec vigint trigint quardagint quinquagint sexagint septuagint octagint nonagint) );
my @nat    = qw(a one two three four five six seven eight nine ten eleven twelve thirteen forteen fifteen
                sixteen seventeen eighteen nineteen);
my @nat_10 = qw(b ten twenty thirty fourty fifty sixty seventy eighty ninety);

my @tests = qw(1 6 10 19 21 45 90 100 101 152 160 300 999 1000 1001 1095 1999 2000 10000 10001 1000000 1000001 1999999 10000000 10000001
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999);

my @TESTS = (
  [ 11,        'eleventh' ],
  [ 62,        'sixty-second' ],
  [ 99,        'ninety-ninth' ],
  [ 999,       'nine-hundred and ninety-ninth' ],
  [ 1_099,     'one thousand and ninety-ninth' ],
  [ 999_999,   'nine-hundred and ninety-nine thousand nine-hundred and ninety-ninth' ],
  [ 1_000_000, 'one millionth' ],
  [ 1_000_001, 'one million and first' ],
  [ '99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999',
  'ninety-nine novemnonagintillion nine-hundred and ninety-nine octononagintillion nine-hundred and ninety-nine septnonagintillion nine-hundred and ninety-nine sexnonagintillion nine-hundred and ninety-nine quinnonagintillion nine-hundred and ninety-nine quattuornonagintillion nine-hundred and ninety-nine trenonagintillion nine-hundred and ninety-nine duononagintillion nine-hundred and ninety-nine unnonagintillion nine-hundred and ninety-nine nonagintillion nine-hundred and ninety-nine novemoctagintillion nine-hundred and ninety-nine octooctagintillion nine-hundred and ninety-nine septoctagintillion nine-hundred and ninety-nine sexoctagintillion nine-hundred and ninety-nine quinoctagintillion nine-hundred and ninety-nine quattuoroctagintillion nine-hundred and ninety-nine treoctagintillion nine-hundred and ninety-nine duooctagintillion nine-hundred and ninety-nine unoctagintillion nine-hundred and ninety-nine octagintillion nine-hundred and ninety-nine novemseptuagintillion nine-hundred and ninety-nine octoseptuagintillion nine-hundred and ninety-nine septseptuagintillion nine-hundred and ninety-nine sexseptuagintillion nine-hundred and ninety-nine quinseptuagintillion nine-hundred and ninety-nine quattuorseptuagintillion nine-hundred and ninety-nine treseptuagintillion nine-hundred and ninety-nine duoseptuagintillion nine-hundred and ninety-nine unseptuagintillion nine-hundred and ninety-nine septuagintillion nine-hundred and ninety-nine novemsexagintillion nine-hundred and ninety-nine octosexagintillion nine-hundred and ninety-nine septsexagintillion nine-hundred and ninety-nine sexsexagintillion nine-hundred and ninety-nine quinsexagintillion nine-hundred and ninety-nine quattuorsexagintillion nine-hundred and ninety-nine tresexagintillion nine-hundred and ninety-nine duosexagintillion nine-hundred and ninety-nine unsexagintillion nine-hundred and ninety-nine sexagintillion nine-hundred and ninety-nine novemquinquagintillion nine-hundred and ninety-nine octoquinquagintillion nine-hundred and ninety-nine septquinquagintillion nine-hundred and ninety-nine sexquinquagintillion nine-hundred and ninety-nine quinquinquagintillion nine-hundred and ninety-nine quattuorquinquagintillion nine-hundred and ninety-nine trequinquagintillion nine-hundred and ninety-nine duoquinquagintillion nine-hundred and ninety-nine unquinquagintillion nine-hundred and ninety-nine quinquagintillion nine-hundred and ninety-nine novemquardagintillion nine-hundred and ninety-nine octoquardagintillion nine-hundred and ninety-nine septquardagintillion nine-hundred and ninety-nine sexquardagintillion nine-hundred and ninety-nine quinquardagintillion nine-hundred and ninety-nine quattuorquardagintillion nine-hundred and ninety-nine trequardagintillion nine-hundred and ninety-nine duoquardagintillion nine-hundred and ninety-nine unquardagintillion nine-hundred and ninety-nine quardagintillion nine-hundred and ninety-nine novemtrigintillion nine-hundred and ninety-nine octotrigintillion nine-hundred and ninety-nine septtrigintillion nine-hundred and ninety-nine sextrigintillion nine-hundred and ninety-nine quintrigintillion nine-hundred and ninety-nine quattuortrigintillion nine-hundred and ninety-nine tretrigintillion nine-hundred and ninety-nine duotrigintillion nine-hundred and ninety-nine untrigintillion nine-hundred and ninety-nine trigintillion nine-hundred and ninety-nine novemvigintillion nine-hundred and ninety-nine octovigintillion nine-hundred and ninety-nine septvigintillion nine-hundred and ninety-nine sexvigintillion nine-hundred and ninety-nine quinvigintillion nine-hundred and ninety-nine quattuorvigintillion nine-hundred and ninety-nine trevigintillion nine-hundred and ninety-nine duovigintillion nine-hundred and ninety-nine unvigintillion nine-hundred and ninety-nine vigintillion nine-hundred and ninety-nine novemdecillion nine-hundred and ninety-nine octodecillion nine-hundred and ninety-nine septdecillion nine-hundred and ninety-nine sexdecillion nine-hundred and ninety-nine quindecillion nine-hundred and ninety-nine quattuordecillion nine-hundred and ninety-nine tredecillion nine-hundred and ninety-nine duodecillion nine-hundred and ninety-nine undecillion nine-hundred and ninety-nine decillion nine-hundred and ninety-nine novillion nine-hundred and ninety-nine octillion nine-hundred and ninety-nine septillion nine-hundred and ninety-nine sextillion nine-hundred and ninety-nine quinillion nine-hundred and ninety-nine quadillion nine-hundred and ninety-nine trillion nine-hundred and ninety-nine billion nine-hundred and ninety-nine million nine-hundred and ninety-nine thousand nine-hundred and ninety-ninth' ]
);

is( ordinal($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

say "$_ -> ",ordinal($_) foreach @tests;

sub ordinal {
  my ($ptr,$last,@parts,@result) = (0, map { scalar reverse } ((reverse pop) =~ m{(\d{1,3})}g));
  @result = _ordinal($last, !@parts ) if -$last;
  $ptr++, -$_ && (unshift @result, _natural($_).' '.$power[$ptr][ @result ? 0 : 1 ] ) for @parts;
  "@result" =~ s/\s+/ /gr
}

## Create a natural triple of 1s, 10, 100s
sub _natural {
  my $v = pop;
  join ' and ',
    ($v       > 99) ? $nat[$v/100].'-hundred' : (),
    $v%100 ? ( $v%100 > 19 ? $nat_10[($v%100)/10].( $v%10 ? '-'.$nat[$v%10] : '' )
             : $v%100 > 0  ? $nat[$v%100] : () ) : ();
}

## Create an ordinal triple
sub _ordinal {
  my($v,$flag) = @_;

  join ' and ',
    (!$flag && $v < 100) ? '' : (),
    ($v       > 99) ? $nat[$v/100].($v%100?'-hundred':'-hundredth') : (),
    $v%100 ? ( $v%100 > 19 ? ( $v%10 ? $nat_10[($v%100)/10].'-'.$ord[$v%10] : $ord_10[($v%100)/10] )
             : $v%100 > 0  ? $ord[$v%100] : () ) : ();
}


