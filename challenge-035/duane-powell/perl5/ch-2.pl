#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Write a program to decode binary morse code.

my $input = shift || "Hello World.";

my $m = MorseCode->new();
$m->encode($input);
$m->print();
$m->sounds_play();
$m->lights_blink();

my $n = MorseCode->new();
$n->decode($m->buffer_get());
$n->print();
exit;

package MorseCode;
use Data::Dumper;
sub new {
	my $class = shift;
	my $self = {
		buffer => '',
		morse => { 
                        'A' => '10111',  
                        'B' => '111010101',
                        'C' => '11101011101',
                        'D' => '1110101',
                        'E' => '1',
                        'F' => '101011101',
                        'G' => '111011101',
                        'H' => '1010101',
                        'I' => '101',
                        'J' => '1011101110111',
                        'K' => '111010111',
                        'L' => '101110101',
                        'M' => '1110111',
                        'N' => '11101',
                        'O' => '11101110111', 
                        'P' => '10111011101',
                        'Q' => '1110111010111',
                        'R' => '1011101',
                        'S' => '10101',
                        'T' => '111',
                        'U' => '1010111',
                        'V' => '101010111',
                        'W' => '101110111',
                        'X' => '11101010111',
                        'Y' => '1110101110111',
                        'Z' => '11101110101',
                        '1' => '10111011101110111',
                        '2' => '101011101110111',
                        '3' => '1010101110111',
                        '4' => '10101010111',
                        '5' => '101010101',
                        '6' => '11101010101',
                        '7' => '1110111010101',
                        '8' => '111011101110101',
                        '9' => '11101110111011101',
                        '0' => '1110111011101110111',
                        ',' => '1110111010101110111',
                        '.' => '10111010111010111',
                        '?' => '101011101110101',
                        '/' => '1110101011101',
                        '-' => '111010101010111',
                        '(' => '111010111011101',
                        ')' => '1110101110111010111',
                        ' ' => '0000000',
                        'char_gap' => '000',
		},
	};
	bless $self, $class;
	return $self;
}
sub encode {
	my $self    = shift;
	my $message = shift;

	my @char = split(//,$message);
	$self->{buffer} = '';
	foreach my $c (@char) {
		$c = uc($c);
		unless (defined $self->{morse}{$c}) {
			warn "Invalid input char $c, skipping\n";
			next;
		}
		if ($c eq ' ') {
			 $self->{buffer} .= $self->{morse}{$c};
		}
		else {
			 $self->{buffer} .= $self->{morse}{$c} . $self->{morse}{char_gap};
		}
	}
	$self->{buffer} =~ s/0000000000/0000000/g; # convert adjacent char and word gap to just word gab
		
}
sub decode {
	my $self  = shift;
	my $morse = shift;

	my %hash  = reverse %{$self->{morse}};
	$self->{buffer} = '';

	my @word = split(/0000000/,$morse);
	foreach my $w (@word) {
		my @char = split(/000/,$w);
		foreach my $c (@char) {
			if (defined $hash{$c}) {
				$self->{buffer} .= $hash{$c};
			} 
			else {
				warn "invalid segement $c\n";
			}
		}
		$self->{buffer} .= ' ';
	}
}
sub sounds_play {
	my $self = shift;
	# stub method, create new sound object and cause it to beep at morse rate
}
sub lights_blink {
	my $self = shift;
	# stub method, create new light object and cause it to blink at morse rate
}
sub print {
	my $self = shift;
	say $self->{buffer};
}
sub buffer_get {
	my $self = shift;
	return $self->{buffer};
}
1;

__END__

./ch-2.pl
10101010001000101110101000101110101000111011101110000000101110111000111011101110001011101000101110101000111010100010111010111010111000
HELLO WORLD.
