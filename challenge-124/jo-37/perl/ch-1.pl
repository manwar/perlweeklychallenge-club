#!/usr/bin/perl

use v5.16;
use warnings;

use Tk;
use Tk::Font;

# "Feel free to use any character."
# I chose U+2640.
my $mw = Tk::MainWindow->new;
$mw->title('Venus');
$mw->Label(
    -font => $mw->Font(-family => 'arial', -size => 240),
    -text => "\x{2640}"
)->pack;

MainLoop;
