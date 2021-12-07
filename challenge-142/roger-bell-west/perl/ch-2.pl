#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

my @a;
foreach (1..10) {
  push @a,int(rand()*100+10);
}

is_deeply(sleepsort(\@a),[sort {$a <=> $b} @a],'example 1');

use Parallel::ForkManager;
use Time::HiRes qw(usleep);

sub sleepsort {
  my $n=shift;
  my @r;
  my $pm=Parallel::ForkManager->new(scalar @{$n});
  $pm->set_waitpid_blocking_sleep(0);
  $pm->run_on_finish(sub{
                       if (defined $_[5]) {
                         push @r,${$_[5]};
                       }
                     });
  foreach my $e (@{$n}) {
    $pm->start and next;
    usleep 1000*$e;
    $pm->finish(0,\$e);
  }
  $pm->wait_all_children;
  return \@r;
}
