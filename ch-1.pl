#!/usr/bin/perl
use strict;
use Data::Dumper;

my @ro_tree1;

sub array_transform_rowform {

    my ($h, $val, @kids) = @_;
    if (! defined(@ro_tree1[$h])) {    
        @{$ro_tree1[$h]} = ();
    }
    push @{$ro_tree1[$h]}, $val; 

    if ($kids[0]) {
        my ($temp, @smallkids) = @{kids[0]};
        array_transform_rowform($h+1, shift @{$kids[0]}, @{$kids[0]});
    } 
    if ($kids[1]) {
        my ($temp, @smallkids) = @{kids[1]};
        array_transform_rowform($h+1, shift @{$kids[1]}, @{$kids[1]});
    }

}

sub rowform_transform_array {
    my @rowform = @_;
    my $height = $#rowform;
    my @data = ();
    for (0..2**$height-1) { push @data, [ $rowform[$height][$_] ];  }
    for my $i (reverse 1..$height-1) {
        my @newdata = ();
        for my $j (0..2**$i-1) {
            $newdata[$j] = CombineTwo($data[$j*2], $data[$j*2+1]);
            unshift @{$newdata[$j]}, $rowform[$i][$j];
        }
        for my $j (0..2**$i-1) {$data[$j] = $newdata[$j];}
    }

    return [$rowform[0][0], $data[0], $data[1]] ;
}

sub CombineTwo {
    my @temp = ($_[0], $_[1]);
    return \@temp;
}

sub swaprowformtree {
    my @btree = @_;
    my $N = $#btree;
    for my $i (1..$N) {
        for my $j (0..2**($i-1)-1) {
            ($btree[$i][$j], $btree[$i][2**($i)-1-$j])
            = ($btree[$i][2**($i)-1-$j], $btree[$i][$j]);
        }
    }

    return @btree;
}

# ===================================================

my $tree1 = [2, [3, [5], [7]], [11, [13], [17]] ] ; 
#SAMPLE INPUT (nested array form)

array_transform_rowform(0, shift @{$tree1}, @{$tree1});

$Data::Dumper::Terse = 1; 
$Data::Dumper::Indent = 0;

print Dumper rowform_transform_array swaprowformtree @ro_tree1;

# ===================================================

# REFERENCES (format of binary tree): 
# https://ry.ca/2020/04/path-sum/
# https://raku-musings.com/diff-sum.html
# http://blogs.perl.org/users/laurent_r/2020/04/perl-weekly-challenge-56-diff-k-and-path-sum.html


sub display_rowform {       # haven't used in program; use for checking
    my @bb = @_;
    print "(";
    for my $i (0..$#bb) {
        print "[";
        print join "," , @{$bb[$i]};
        print "],\n"
    }

    print ")";
}

