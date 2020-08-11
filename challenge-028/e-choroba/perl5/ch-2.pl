#!/usr/bin/perl
use warnings;
use strict;

use Time::Piece;
use Tk;

my $time;
sub init_time { $time = localtime->strftime('%H:%M:%S') }

my $rate = 500;

my $mw = 'MainWindow'->new(-title => 'Digital Clock');

$mw->Label(-textvariable => \$time,
           -font         => 'Arial 48',
)->pack;

my $repeat_id = $mw->repeat($rate, \&init_time);

my $scale = $mw->Scale(-label   => 'Refresh rate:',
                       -orient  => 'horizontal',
                       -from    => 1,
                       -to      => 2000,
                       -command => sub { $repeat_id->time($rate = $_[0]) },
)->pack;
$scale->set($rate);

init_time();
MainLoop();
