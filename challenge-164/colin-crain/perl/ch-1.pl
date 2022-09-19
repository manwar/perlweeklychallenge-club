#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       palaprime_party.pl
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my $input = shift @ARGV // 1000;

sub sieve ($limit) {
    my @s = (1) x $limit;
    @s[0,1] = (0,0);    
    for my $f (2..sqrt($limit)) {    
        $s[$f * $_] = 0 for $f..$limit/$f;
    }
    return grep { $s[$_] } (0..$limit);
}

say $_ for grep { /^(.*).?(??{reverse($1)})$/ } sieve($input);






