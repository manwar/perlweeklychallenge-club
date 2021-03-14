# https://perlweeklychallenge.org/blog/perl-weekly-challenge-103/

class Time {
  has $.second;

  method time() {
    my ($hour, $minute) = (0,0);
    if $!second >= 3600 {
      $hour    = $!second div 3600;
      $!second = $!second %   3600;
    }
    if $!second >= 60 {
      $minute  = $!second div 60;
      $!second = $!second %   60;
    }
    return sprintf('%02d:%02d:%02d',$hour,$minute,$!second);
  }
}

class Movies {

  has $.starttime;
  has $.currenttime;
  has $.filelist;
  has @!show; # ( [ time, show ] )
  has $!position;
  has $.time-playlist;

  submethod TWEAK {
    # miliseconds -> seconds
    $!filelist.IO.lines».split(',').map( -> ($a, $b) { @!show.push: ( $a, $b )  });
    $!position      =  ( $!currenttime - $!starttime ) % (@!show[*;0].sum/1000);
    $!time-playlist = Time.new( second => $!position.Int ).time;
  }

  method what-show() {
    my ($time, $show);
    for @!show[*;0] -> $show-time {
      $time += $show-time;
      return @!show[$show++;1] if $time > $!position;
    }
  }
}

multi sub MAIN( $start-time, $current-time, $filelist ) {
  my $show = Movies.new( starttime => $start-time, currenttime => $current-time, filelist => $filelist);
  say "Input: 3 command line parameters: start time, current time, file name\n";
  say '# starttime  : ',$start-time;
  say '# currenttime: ',$current-time;
  say sprintf("# %s\n",$filelist);
  say "Output:";
  say $show.what-show;
  say $show.time-playlist;
}

multi sub MAIN( 'challenge' ) {

  my $a = '1606134123';
  my $b = '1614591276';
  my $c = 'filelist.csv';

  MAIN($a, $b, $c);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is Time.new( second => 59).time,  '00:00:59';
  is Time.new( second => 61).time,  '00:01:01';
  is Time.new( second => 3661).time,'01:01:01';

  my $a = '1606134123';
  my $b = '1614591276';
  my $c = 'filelist.csv';
  my $d = '"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"';
  my $e = '00:10:24';

  my $mv = Movies.new( starttime => $a, currenttime => $b, filelist => $c);
  is $mv.what-show,$d;
  is $mv.time-playlist,$e;
 
}
