#!perl.exe

use strict;
use warnings;
use DateTime;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-06
# Challenge # 181  Hot Day ( Perl )

my %daytemps;

sub setupHashArray {
  while( my $info = <DATA>){
    chomp($info);

    if ($info) {
      my( $dt, $temp) = split(", ",$info);
      $daytemps{$dt} = $temp;
      #print("$dt $temp\n");
    }

  }
}

sub getPreviousDay {
  my $dt1 = shift;

  my ( $year, $month, $day) = $dt1 =~ /^(\d\d\d\d)-(\d?\d)-(\d\d)/;

  $dt1 = DateTime->new(
    year      => $year,
    month     => $month,
    day       => $day,
    time_zone => 'America/Chicago',
  );

  my $yesterday = $dt1->clone->add(days => -1);

  return $yesterday->ymd;
}

sub main {

  setupHashArray();

  for my $key ( keys %daytemps ){

    my $prev = getPreviousDay($key);

    if (exists $daytemps{$prev} && $daytemps{$key} > $daytemps{$prev}){

      print("$key\n");

    }

  }

}

main();

__DATA__

2022-08-01, 20

2022-08-09, 10

2022-08-03, 19

2022-08-06, 24

2022-08-05, 22

2022-08-10, 28

2022-08-07, 20

2022-08-04, 18

2022-08-08, 21

2022-08-02, 25
