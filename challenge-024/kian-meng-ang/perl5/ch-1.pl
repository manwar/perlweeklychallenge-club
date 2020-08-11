#!/usr/bin/perl
use B;

__END__
Create a smallest script in terms of size that on execution doesn’t throw any
error. The script doesn’t have to do anything special. You could even come up
with smallest one-liner.

# `perl` interpreter run the script just fine without error.
$ perl ch-1.pl; echo $?
0

# `perlcritic` do not raise error on missing warnings.
$ perlcritic ch-1.pl
ch-1.pl source OK

# `file` identifies it as Perl script.
$ file ch-1.pl
ch-1.pl: Perl script text executable

# script length.
$ head -n 2 ch-1.pl | wc -c
23
