#!/usr/bin/perl -w0777

use v5.12;
seek DATA, 0, 0;
say +(keys %{ {<DATA> =~ /(\S+)()/g} })[0];
__DATA__
Hello David!
