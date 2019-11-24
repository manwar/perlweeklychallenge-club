#!/usr/bin/perl
use strict;
use warnings;

my ( $dot, $dash ) = ( '1', '111' );
my ( $i_gap, $ch_gap, $w_gap ) = ( '0', '000', '0000000' );
my ( $text, $code );

my %code_table = &create_code_table;
&load_text( shift );
&encode;
&save_code;

sub encode {
	my @ch = split //, $text;
	my @chars;
	map{ push @chars, $_ if defined $code_table{uc($_)} }@ch;
	$code = '';
	foreach ( keys @chars ) {
		$code .= $code_table{uc($chars[$_])} if defined $code_table{uc($chars[$_])};
		next if $chars[$_] eq ' ';
		$code .= $ch_gap if defined $chars[$_+1] && $chars[$_+1] ne ' ' && defined $code_table{uc($chars[$_])};
	}
}

sub create_code_table {
	my %table = ( ' ' => $w_gap );

	while ( <DATA> ) {
		chomp;
		my ( $char, $code ) = split /;/;
		$code =~ s/\G.\K(?=.)/$i_gap/sg;
		$code =~ s/\./$dot/g;
		$code =~ s/-/$dash/g;
		$table{$char} = $code;
	}

	return %table;
}

sub load_text {
	my ( $file ) = shift;
	open my $fh, '<', $file or die $!;
	
	while ( <$fh> ) {
		chomp;
		$text .= $_;
	}
	
	close $fh;
}

sub save_code {
	open my $fh, '>', 'encoded_text.txt' or die $!;
	print $fh $code;
	close $fh;
}

__DATA__
A;.-
B;-...
C;-.-.
D;-..
E;.
F;..-.
G;--.
H;....
I;..
J;.---
K;-.-
L;.-..
M;--
N;-.
O;---
P;.--.
Q;--.-
R;.-.
S;...
T;-
U;..-
V;...-
W;.--
X;-..-
Y;-.--
Z;--..
0;-----
1;.----
2;..---
3;...--
4;....-
5;.....
6;-....
7;--...
8;---..
9;----.
.;.-.-.-
,;--..--
:;---...
?;..--..
';.----.
-;-....-
/;-..-.
(;-.--.
);-.--.-
";.-..-.
=;-...-
+;.-.-.
@;.--.-.
