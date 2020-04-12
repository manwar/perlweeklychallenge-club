#!/usr/bin/perl
use strict;
{
package lr;

sub new {
    my ($class) = @_;
    bless{
        _value=> $_[1],
        _bl=>$_[2],
        _br=>$_[3],
      }, $class;
}

sub bl{ $_[0]->{_bl}}
sub br{ $_[0]->{_br}}
sub value{ $_[0]->{_value} }

}

$ARGV[0] eq "0" || die "no argument input!" if not(defined($ARGV[0]));

my @binaryint = split //, $ARGV[0];
my @block;

if ($binaryint[0]==0) {
   @block = (-1,) ;
   } else {@block = (1,) ;}

#begin: special case of 1111..
my %specialcase = {0=>0, 1=>0};
$specialcase{$_}++ foreach @binaryint;
if ($specialcase{1} == $#binaryint + 1) {
	print "L = ", $_, ", R = ", $_, "\n" foreach (0.. $#binaryint);
    exit;
}
#end of the special case 




sub increase_magnitude {
	if ($_[1] == 0) {
        return ($_[0]-1);
    } else {
        return ($_[0]+1);
    }
}


my $h = 0;
for (1..$#binaryint) {
	if ($binaryint[$_-1] == $binaryint[$_]) { 
		$block[$h] = increase_magnitude($block[$h], $binaryint[$_]);
	} else {
		$h++; 
		if ($binaryint[$_] == 0) {
            $block[$h] = -1 ;
        } else {$block[$h] = 1;} 
	}
}


my $g;  # g is ahead of h

if ($binaryint[0] == 0) {
    $g = 0 
} else {$g = 1;}

sub sumblock {
	my $v = 0;
	my $a = $_[0];
    my $b = $_[1];
    if ($a==0) {$v = $block[$a] if $block[$a] > 0 ;}
    if ($a >= 1) {for (0..$a-1) {
        $v += $block[$_] if $block[$_] > 0;}}
   	for ($a..$b) {
        $v += $block[$_]*(-1) if $block[$_]<0;}
	if ($b < $h) {for ($b+1..$h) {
		$v += $block[$_] if $block[$_] > 0;}}

	return $v;
}

my @maxlr = ();
my $max = sumblock(0,0);

my $i; my $j;
for ($i=$g; $i<=$h; $i=$i+2) { 
	for ($j=$i; $j<=$h; $j=$j+2 ){
		my $temp = lr->new( sumblock($i,$j) , $i, $j);
		if ($temp->value > $max) {
			@maxlr = ();
			$max = $temp->value;
		}
        if ($temp->value == $max)
            {push @maxlr, $temp;}
	}
}



sub magnitude {
    if ($_[0] > 0) {return $_[0]} else {return -$_[0]}
}


foreach (@maxlr) {
    my $ref;
    my $L = 0;
    if ($_->bl > 0) {
        for $ref (0..$_->bl-1) {$L += magnitude($block[$ref]);}
    }
    my $R = 0; 
    if ($_->br >= 0) {
        for $ref (0..$_->br) { 
            $R += magnitude($block[$ref]);}
    }
    $R = $R-1;
	print "L = ", $L, ", R = ", $R, "\n";
}

