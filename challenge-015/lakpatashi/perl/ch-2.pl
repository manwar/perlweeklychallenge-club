#!/usr/bin/perl
use POSIX;
use strict;
use warnings;
use List::Util qw( min max sum);

my $message = 'hello World , hello world';
my $key = 'secret';			# key is all lowercase without space
print "plain message: $message\n";
my $encMessage = encrypt($message,$key);
print "encrypt message: $encMessage\n";
my $decMessage = decrypt($encMessage,$key);
print "decrypt message: $decMessage\n";


sub encrypt{
	my ($message,$key) = @_;
	$message = lc $message;
	$key = $key x ceil((length $message)/ (length $key));
	my @message = split '',$message;
	my @key = split '',$key;
	for my $i (0..$#message){
		next unless $message[$i] ge 'a' and $message[$i] le 'z';
		my $newChar = (ord($key[$i]) + ord($message[$i]) -2*ord('a') ) % 26;
		$message[$i] = chr(ord('a')+$newChar);
	}
	return join '',@message;
}

sub decrypt{
	my ($message,$key) = @_;
	$message = lc $message;
	$key = $key x ceil((length $message)/ (length $key));
	my @message = split '',$message;
	my @key = split '',$key;
	for my $i (0..$#message){
		next unless $message[$i] ge 'a' and $message[$i] le 'z';
		my $newChar = ( ord($message[$i])-ord($key[$i])  ) % 26;
		$message[$i] = chr(ord('a')+$newChar);
	}
	return join '',@message;
}
