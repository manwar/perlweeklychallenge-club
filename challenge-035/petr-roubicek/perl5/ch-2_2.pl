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
	my @arr = split //, $code;
	my ( $c ,$g, $morse ) = ( '', '', '' );
	foreach ( keys @arr ) {
		if ( $arr[$_] eq '1' ) {
			$c .= $arr[$_];
			$g = '';
		}
		$g .= $arr[$_] if $arr[$_] eq '0';
		
		if ( ( $g eq $i_gap || $_ == $#arr ) && $c ne '' ) {
			$morse .= $c eq '1' ? '.' : $c eq '111' ? '-' : 'E' ;
			$c = '';
		}
		if ( $g eq $ch_gap && defined $arr[$_+1] && $arr[$_+1] eq '1' ) {
			$text .= $code_table{$morse} if defined $code_table{$morse};
			$text .= '[ERR]' if !defined $code_table{$morse};
			$morse = '';
			$g = '';
		}
		if ( $g eq $w_gap && defined( $arr[$_+1] ) && $arr[$_+1] eq '1' ) {
			$text .= "$code_table{$morse} " if defined $code_table{$morse};
			$text .= '[ERR] ' if !defined $code_table{$morse};
			$morse = '';
			$g = '';
		}
		if ( $_ == $#arr ) {
			$text .= $code_table{$morse};
			$morse = '';
			$g = '';
		}
	}
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

	my %table;

	while ( <DATA> ) {
		chomp;
		my ( $char, $code ) = split /;/;
		$table{$code} = $char;
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
