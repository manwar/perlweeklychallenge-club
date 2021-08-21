#!/usr/bin/perl
# The Weekly Challenge 126 Task 2 Minesweeper Game
# Usage: $ ch-2.pl --file filename_of_the_map
use List::Util qw/sum/;
use Getopt::Long;
use Data::Dumper;
use IO::Prompter;    # for the game part
use v5.12.0;
use experimental;
no warnings;

my $num_of_mines = 0;
my $map;
my $filename;

GetOptions('file=s' => \$filename,);

(open(FILE, $filename)) || ($map = <<MAP);
    x * * * x * x x x x
    * * * * * * * * * x
    * * * * x * x * x *
    * * * x x * * * * *
    x * * * x * * * * x
MAP

if (!defined($map)) {
    while ( defined($filename) && ($_ = <FILE>) ) {
        chomp($_);
        $map .= ($_."\n") if $_;
    }
    close FILE;
}

$map =~ s/[ \t]//g;

my @rows = split "\n", $map;
my $width = length $rows[0];
my $height = scalar @rows;

push @rows, '*' x $width;
unshift @rows, '*' x $width;

$_ = '*'. $_ . '*' foreach @rows;

for my $r (1..$height) {
    for my $col (1..$width) {
        substr($rows[$r], $col, 1) = countx($r, $col);
    }
}

sub countx {
    my $r_i = $_[0];
    my $c_i = $_[1];

    if (substr($rows[$r_i], $c_i, 1 ) eq 'x') {
        $num_of_mines++;
        return 'x';
    }
    my $ans = 0;
    for my $r (-1, 0, +1) {
        for my $c (-1, 0, +1) {
            $ans += int( substr($rows[$r_i+$r], $c_i+$c,1 ) eq 'x')
               unless ($r == 0 && $c == 0)
        }
    }
    return $ans;
}

for my $r (1..$height) {
    substr($rows[$r], 0, 1) = "";
    substr($rows[$r], -1, 1) = "";
}

my $master_board;
for my $i (0..$height-1) {
    $master_board->[$i] = [split //, $rows[$i+1]];
}

# =============== BEGIN: game (can be removed) ============
# Following Lubos Kolouch's suggestion on the facebook group,
# write a playable interface.

my %b35;
$b35{$_} = $_ for (1..9);
$b35{$_} = chr(ord("A")-10+$_) for (10..35);

my %rb35;
$rb35{$_} = $_ for (1..9);
$rb35{$_} = ord($_)-ord("A")+10 for ("A".."Z");


# initialization
my $explosion = undef;
my $num_of_op_pos = 0;
my $num_of_flags = 0;
my $num_of_digits = $width*$height-$num_of_mines;

my $table;
for my $i (0..$height-1) {
    for my $j (0..$width-1) {
        $table->[$i][$j] = ".";
    }
}


# interactive game
my @data = ("", "", "");
while (   !$explosion 
        && $data[2] ne "q" 
        && $num_of_op_pos < $num_of_digits
      ) 
{
    my ($i, $j);

    print_table();
    say 'action option: (o(open), f(flag/unflag), c(cancel) or q(quit))';
    @data = (
        prompt(' row  :'),
        prompt(' col  :'),
        prompt('action:'),
    );

    last if $data[2] eq "q";
    if ( $data[0] !~ /^[1-9A-Z]$/ || $data[1] !~ /^[1-9A-Z]$/ )  {
         say "Cannot identify your input of row/col.\n";
         next; 
    }
    else
    {     
        $i = $rb35{$data[0]} - 1;  
        $j = $rb35{$data[1]} - 1;  
    }
    if ( 
        ($i > $height-1 || $i < 0)    
           ||
        ($j > $width-1 || $j < 0)  
       )
    {
        say "Cannot identify your input.\n";
        next; 
    }
    

    my $act = $data[2];
    if ($act eq "o" && $master_board->[$i][$j] eq "x") {
        $explosion = 1;
        last; 
    }

    given ($act) {
        when ("o") {
            $table->[$i][$j] = $master_board->[$i][$j];
            $num_of_op_pos++;
        }
        when ("f") {
            if ($table->[$i][$j] !~ /^\d$/) {
                $table->[$i][$j] = $table->[$i][$j] eq "f" ? "." : "f";
            }
            else {
                say "Grid already identified.\n";
            }
        }
        when ("c") {say "Action cancelled.\n";}
        default {say "Cannot identify your action.\n";}
    }
}
print "\n" x 3;
say "BOOOOOOOOOOOOOOOOOOOOOOOOOOOOMB!" if $explosion;
say "Safe, my hero!"
  if $num_of_op_pos == $num_of_digits;

sub print_table {
    say "number of bombs: " , $num_of_mines;
    say "number of flags: " , $num_of_flags;
    say "number of opened positions: " , $num_of_op_pos;
    print " ";
    print sprintf("%2s", $b35{$_}) for (1..$width);
    print "\n";
    for my $i (0..$height-1) {
        print $b35{$i+1}," ";
        for my $j (0..$width-1) {
            print $table->[$i][$j], " ";
        }
        print "\n";
    }
    print "\n" x 3;
}


# ================= END: game ===========================

print_mine();

sub print_mine {
    for my $i (0..$height-1) {
        print "  ";
        for my $j (0..$width-1) {
            print " ",$master_board->[$i][$j];
        }
        print "\n";
    }
}
