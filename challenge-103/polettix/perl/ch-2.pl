#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use autodie;
use File::Spec::Functions qw< splitpath catpath >;

sub what_s_playing ($start, $now, $file) {
   my $tracks = load_tracks_list($file);
   my $offset = 1000 * ($now - $start);
   my $current_title;
   OUTER:
   while ('necessary') {
      my $period = 0;
      for my $track ($tracks->@*) {
         my $duration = $track->{duration};
         if ($offset <= $duration) {
            $current_title = $track->{title};
            last OUTER;
         }
         $offset -= $duration;
         $period += $duration;
      }
      $offset %= $period;
   }

   my $ms = $offset % 1000;
   $offset = int($offset / 1000);
   my $s = $offset % 60;
   $offset = int($offset / 60);
   my $m = $offset % 60;
   $offset = int($offset / 60);
   my $current_position = sprintf '%02d:%02d:%02d.%03d', $offset, $m, $s, $ms;

   return {position => $current_position, title => $current_title};
}

sub load_tracks_list ($file) {
   open my $fh, '<', $file;
   my @lines = map {
      chomp;
      my ($duration, $title) = split m{,}mxs, $_, 2;
      $duration =~ s{\A\s+|\s+\z}{}gmxs;
      substr $duration, -3, 3, '000' if $ENV{CUT_MILLISECONDS};
      {duration => $duration, title => $title};
   } <$fh>;
   return \@lines;
}

sub default_args {
   my ($v, $ds, $f) = splitpath(__FILE__);
   my $file = catpath($v, $ds, 'filelist.csv');
   return (1606134123, 1614591276, $file);
}

my @args = @ARGV ? @ARGV : default_args();
my $wp = what_s_playing(@args);
say $wp->{title};
say $wp->{position};
