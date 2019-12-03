#!/usr/bin/perl
use strict;
use warnings;

my ( $dot, $dash ) = ( '1', '111' );
my ( $i_gap, $ch_gap, $w_gap ) = ( '0', '000', '0000000' );
my ( $text, $code );

my %code_table = &create_code_table;

&load_code( shift );
&decode;
&save_text;

sub decode {
	map{ $code =~  s/$code_table{$_}/$_/g }sort { length( $code_table{$b} ) <=> length( $code_table{$a} ) } keys %code_table;
	$code =~ s/$ch_gap//g;
	$text = $code;
}

sub load_code {
	my ( $file ) = shift;
	open my $fh, '<', $file or die $!;
	
	while ( <$fh> ) {
		chomp;
		$code .= $_;
	}
	
	close $fh;
}

sub save_text {
	open my $fh, '>', 'decoded_text.txt' or die $!;
	print $fh $text;
	close $fh;
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
