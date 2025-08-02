#!/usr/bin/perl
use 5.030;
use warnings;
use English;
use Getopt::Std;

sub decrypt {
    my ($table, $rtable, $m) = @_;

    my @message = grep { /[a-ik-z]/ } (split //, lc $m);
    
    if (scalar @message % 2) {
        push @message, 'x';
    }

    my $decrypted;

    for (my $i = 0; $i < scalar @message; $i += 2) {
        $decrypted .= transformDigraph($table, $rtable, $message[$i], $message[$i + 1], -1);
    }

    return $decrypted;
}

sub encrypt {
    my ($table, $rtable, $m) = @_;

    $m =~ s/(.)\1/$1x$1/g;
   
    my @message = grep { /[a-ik-z]/ } (split //, lc $m);
    if (scalar @message % 2) {
        push @message, 'x';
    }

    my $encrypted;

    for (my $i = 0; $i < scalar @message; $i += 2) {
        $encrypted .= transformDigraph($table, $rtable, $message[$i], $message[$i + 1], 1);
    }

    return $encrypted;
}

sub makeTable {
    my ($key) = @_;
    my @table = ();

    for my $letter ( grep { /[a-z]/ } (split //, lc $key)) {
        if ($letter eq 'j') {
            $letter = 'i';
        }

        if (! grep { $_ eq $letter} @table) {
            push @table, $letter;
        }
    }

    for my $letter ('a' .. 'i', 'k' .. 'z') {

        if (! grep { $_ eq $letter} @table) {
            push @table, $letter;
        }
    }

    my $n = 0;

    return map { $_ => $n++ } @table;
}

sub reverseTable {
    my ($table) = @_;
    return map { $table->{$_} => $_ } keys %{$table};
}

sub transformDigraph {
    my ($table, $rtable, $a, $b, $dir) = @_;

    my $aRow = int ($table->{$a} / 5);
    my $aCol = $table->{$a} % 5;
    my $bRow = int ($table->{$b} / 5);
    my $bCol = $table->{$b} % 5;
    if ($aRow == $bRow) {
        return $rtable->{$aRow * 5 + (($aCol + $dir) % 5)} . $rtable->{$bRow * 5 + (($bCol + $dir) % 5)};
    } elsif ($aCol == $bCol) {
        return $rtable->{(($aRow + $dir) % 5) * 5 + $aCol} . $rtable->{(($bRow + $dir) % 5) * 5 + $bCol};
    } else {
        return $rtable->{$aRow * 5 + $bCol} . $rtable->{$bRow * 5 + $aCol};
    }
}

sub usage {
    print<<"-USAGE-";
  $PROGRAM_NAME -d -k <Str> -m <Str>
  $PROGRAM_NAME -e -k <Str> -m <Str>

    -d          decrypt a message
    -e          encrypt a message
    -k <Str>    key for encryption/decryption
    -m <Str>    message to encrypt/decrypt
-USAGE-
    exit 0;
}

my %opts;
getopts('dek:m:', \%opts);

my $message = $opts{m} // usage();
my $key = $opts{k} // usage();

my %table = makeTable($key);
my %rtable = reverseTable(\%table);

if (defined $opts{'d'}) {
    say decrypt(\%table, \%rtable, $message);
} elsif (defined $opts{'e'}) {
    say encrypt(\%table, \%rtable, $message);
} else {
    usage();
}