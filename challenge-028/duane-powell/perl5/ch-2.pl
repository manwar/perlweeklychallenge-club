#!/usr/bin/perl
use Modern::Perl;
use Term::ANSIColor;

# Write a script to display Digital Clock. Feel free to be as creative as you can when displaying digits. 
# We expect bare minimum something like 14:10:11

my $color = shift || 'red';
usage() unless $color =~ m/^(black|red|green|yellow|blue|magenta|cyan|white)$/;

my @ascii_art;
push @ascii_art, sub {
"
 ____ 
|    |
|    |
|    |
|    |
|    |
 ____ 
"
};
push @ascii_art, sub {
"
      
     |
     |
     |
     |
     |
     |
"
};
push @ascii_art, sub {
"
 ____ 
     |
     |
 ____ 
|     
|     
 ____ 
"
};
push @ascii_art, sub {
"
 ____ 
     |
     |
 ____ 
     |
     |
 ____ 
"
};
push @ascii_art, sub {
"
      
|    |
|    |
 ____ 
     |
     |
     |
"
};
push @ascii_art, sub {
"
 ____ 
|     
|     
 ____ 
     |
     |
 ____ 
"
};
push @ascii_art, sub {
"
      
|     
|     
 ____ 
|    |
|    |
 ____ 
"
};
push @ascii_art, sub {
"
 ____ 
     |
     |
     |
     |
     |
     |
"
};
push @ascii_art, sub {
"
 ____ 
|    |
|    |
 ____ 
|    |
|    |
 ____ 
"
};

push @ascii_art, sub {
"
 ____ 
|    |
|    |
 ____ 
     |
     |
     |
"
};

my $COLON = 10;
push @ascii_art, sub {
# @{$ascii_art[$COLON]} returns a colon :
"
  
  
 o
  
  
 o
  
"
};

print color ($color);
while (1) {
	sleep 1;
	my ($s,$m,$h,undef,undef,undef,undef,undef) = localtime(time);
	my ($h1, $h2) = split(//,sprintf("%02d", $h));
	my ($m1, $m2) = split(//,sprintf("%02d", $m)); 
	my ($s1, $s2) = split(//,sprintf("%02d", $s));
	my @out;
	foreach (&{$ascii_art[$h1]},&{$ascii_art[$h2]}, &{$ascii_art[$COLON]}, 
		 &{$ascii_art[$m1]},&{$ascii_art[$m2]}, &{$ascii_art[$COLON]}, 
                 &{$ascii_art[$s1]},&{$ascii_art[$s2]}) {
		push @out, split("\n",$_);
	}
	# Each digit in the clock interface is 8 lines of text
	# 6 digits and 2 colons totals to 64 lines of output, @out, a 1 x 64 array
	# We need to convert to an 8 x 8 array, @clock, to print horizontally
	# From this: 1 x 64
	# 1
	# 2
	# :
	# 0
	# 1
	# :
	# 0
	# 1
	# To this: 8 x 8
	# 12:01:01

	my @clock;
	foreach (0..63) {
		$clock[0] .= $out[$_] if ($_ % 8 == 0);
		$clock[1] .= $out[$_] if ($_ % 8 == 1);
		$clock[2] .= $out[$_] if ($_ % 8 == 2);
		$clock[3] .= $out[$_] if ($_ % 8 == 3);
		$clock[4] .= $out[$_] if ($_ % 8 == 4);
		$clock[5] .= $out[$_] if ($_ % 8 == 5);
		$clock[6] .= $out[$_] if ($_ % 8 == 6);
		$clock[7] .= $out[$_] if ($_ % 8 == 7);
	}

	system("clear");
	say $_ foreach (@clock);
}
print color('reset');
exit;

sub usage {
        print <<EOU;
$0 black|red|green|yellow|blue|magenta|cyan|white
Displays ticking digital clock, make a wish at 11:11:11
EOU
        exit;
}

__END__


./ch-2.pl white

       ____    ____          ____
     |     |       ||    |  |     |    |
     |     | o     ||    | o|     |    |
     | ____    ____  ____    ____  ____
     ||            |     |       |     |
     ||      o     |     | o     |     |
     | ____    ____      |   ____      |


