use strict;
use warnings;
##
# Write a sript to find the first pair of Pentagon Numbers 
# whose sum and difference are also a Pentagon Number.
##
use constant N => 10_000;

sub n_pentagon_numbers{
    my($n) = @_;
    my @pentagon_numbers;
    my $x = 1;
    my %h;
    do{
        my $pentagon = $x * (3 * $x - 1) / 2;
        push @pentagon_numbers, $pentagon;
        $h{"$pentagon"} = $x;
        $x++;
    }while(@pentagon_numbers < $n);
    return (\@pentagon_numbers, \%h);
}

sub pairs_pentagon{
    my($n) = @_;
    my($pentagons, $lookup) = n_pentagon_numbers(N);
    my @pairs;
    for my $x (0 .. @{$pentagons} - 1){
        for my $y (0 .. @{$pentagons} - 1){
            unless($x == $y){
                my($sum, $difference) = ($pentagons->[$x] + $pentagons->[$y], abs($pentagons->[$x] - $pentagons->[$y]));
                 if($lookup->{$sum} && $lookup->{$difference}){
                     my($s, $t) = ($x + 1, $y + 1);
                     push @pairs, ["P($s)", "P($t)"]
                 }
            }
            last if @pairs == $n;
        }
        last if @pairs == $n;
    }
    return @pairs;
}

sub first_pair_pentagon{
    return [pairs_pentagon(1)];
}

MAIN:{
    print join(", ", @{first_pair_pentagon()->[0]}) . "\n";
}