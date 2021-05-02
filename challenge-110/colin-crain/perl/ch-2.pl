#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       reflect.pl
#
#       Transpose File
#         Submitted by: Mohammad S Anwar
#         You are given a text file.
# 
#         Write a script to transpose the contents of the given file.
# 
#         Input File
#             name,age,sex
#             Mohammad,45,m
#             Joe,20,m
#             Julie,35,f
#             Cristina,10,f
# 
#         Output:
#             name,Mohammad,Joe,Julie,Cristina
#             age,45,20,35,10
#             sex,m,m,f,f

#         method:
#             Are we going to assume this is proper CSV data as distinguished from
#             a bunch of data separated by commas? The difference being one has
#             edge-cases covered and the other will presumably break sooner or
#             later.
# 
#             We'll start with use split on the commas and proceed with our arrays
#             from there.
# 
#             What do we do if the data doesn't align? I think we need to fill
#             with undefs to keep the transposed data relationships intact. It's
#             the decent thing to do.
# 
#             T(N) ∘ T⁻ⁱ(N) = N
# 
#             So the dimensions of the transposition will be based on the largest
#             dimensions of the rows and columns. This doesn't affect the given
#             input but should a datum be missing the record would look like:
# 
#                 Joe,,m
# 
#             We'll assume there are no commas in the data to keep the clutter
#             down. Maybe we'll bring in CSV.pm when we're done, but the logic
#             isn't about that really so it's just a distraction.
            
        
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

@ARGV = qw( transpose-data.txt );

my @mat;
my @trans;

my $max = 0;

while (<>) {
    chomp;
    push @mat, [ split ',', $_ ];
    $mat[-1]->@* > $max and $max = $mat[-1]->@*;
}

for my $i (0..@mat-1) {
    for  my $j (0..$max-1) {
        $trans[$j][$i] = $mat[$i][$j];
    }
}

local $" = ',';
say "@$_" for @trans;


