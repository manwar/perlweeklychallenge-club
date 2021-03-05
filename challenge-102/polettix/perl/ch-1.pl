#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

use FindBin '$Bin';
use lib "$Bin/../local/lib/perl5";
use Mojo::UserAgent;

my $digits = shift || 10;
my $rn = rare_numbers($digits);

my $title = ($digits == 1) ? '1 digit:' : "$digits digits:";
say $title, ' ', join ', ', $rn->@*;

sub rare_numbers ($N) {
   my ($ml, $retval) = get_rare_numbers_for($N, get_rn_cache());
   return $retval if $N <= $ml;
   ($ml, $retval) = get_rare_numbers_for($N, get_rn_web());
   return $retval if $N <= $ml;
   die "carbon footprint too high, sorry!\n";
}

sub get_rare_numbers_for ($N, $list) {
   my @retval;
   my $max_length = 0;
   for my $item ($list->@*) {
      my $len = length $item;
      $max_length = $len if $len > $max_length;
      last if $max_length > $N;
      push @retval, $item if $len == $N;
   }
   return ($max_length, \@retval);
}

sub get_rn_web {
   my $ua = Mojo::UserAgent->new(connect_timeout => 5, max_redirects => 5);
   my $res = $ua->get('http://oeis.org/A035519/b035519.txt')->res;
   die "web is not collaborating, sorry!\n" unless $res->is_success;
   return [
      map { my ($i, $n) = split m{\s+}; $n } split m{\n}mxs, $res->body
   ];
}

sub get_rn_cache { [ 65, 621770, 281089082, 2022652202, 2042832002 ] }
