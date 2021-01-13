#!/usr/local/bin/perl
use 5.016;
use warnings;
use DateTime;

my $dt=DateTime->new(year=>2000, month=>1, day=>1);
my $dt_end = DateTime->new(year=>2999,month=>12, day=> 31);
while ( DateTime->compare( $dt, $dt_end ) <= 0 )
{
  local $_ = $dt->strftime("%m%d%Y");
  /(\d)(\d)(\d)(\d)\4\3\2\1/ and say;
  $dt->add( days => 1 );
}
