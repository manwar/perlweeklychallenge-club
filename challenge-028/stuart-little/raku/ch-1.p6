#!/usr/bin/env perl6
use v6;
use Inline::Perl5;

my $file=@*ARGS[0];

(! $file.IO.e) && die ("No such file.");
($file.IO.z) && do {
    say "empty";
    exit;
}

my $p5 = Inline::Perl5.new;
$p5.run(qq"print ((-B '$file') ? ('binary') : ('text')); print '\n'");

# run as <script> <path-to-file>
