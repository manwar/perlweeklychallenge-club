#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';
use Data::Dumper;

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-127/ TASK #2

my $in;
while (@ARGV) {
    push @{$in}, [shift, shift];
}
say "Input:";
say Dumper($in);

my $pair = shift @{$in};
my %seen = map { $_ => 1 } @{$pair}; 

my @out;
while ( @{$in} ) {
    $pair = shift @{$in};
    my ($c, $d) = @{$pair};
    my $hit = 0;
    foreach ( $c .. $d ) {
        $hit = 1 if (defined($seen{$_}));
        $seen{$_} = 1;
    }
    push @out, $pair if ($hit);
}
say "Output:";
say Dumper(\@out);

__END__

./ch-2.pl 1 4 3 5 6 8 12 13 3 20 
Input:
$VAR1 = [
          [
            '1',
            '4'
          ],
          [
            '3',
            '5'
          ],
          [
            '6',
            '8'
          ],
          [
            '12',
            '13'
          ],
          [
            '3',
            '20'
          ]
        ];

Output:
$VAR1 = [
          [
            '3',
            '5'
          ],
          [
            '3',
            '20'
          ]
        ];


./ch-2.pl 3 4 5 7 6 9 10 12 13 15
Input:
$VAR1 = [
          [
            '3',
            '4'
          ],
          [
            '5',
            '7'
          ],
          [
            '6',
            '9'
          ],
          [
            '10',
            '12'
          ],
          [
            '13',
            '15'
          ]
        ];

Output:
$VAR1 = [
          [
            '6',
            '9'
          ]
        ];


