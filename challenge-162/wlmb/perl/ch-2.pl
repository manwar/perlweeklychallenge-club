#!/usr/bin/env perl
# Perl weekly challenge 162
# Task 2: Wheatstone-Playfair
#
# See https://wlmb.github.io/2022/04/25/PWC162/#task-2-wheatstone-playfair
use v5.12;
use warnings;
use Try::Tiny; # Use try/catch to manage errors.
use POSIX qw(floor);
my %commands=(encrypt=>\&encrypt, decrypt=>\&decrypt);
die "Usage: ch-2.pl C1 K1 S1 [C2 K2 S2]...\n",
    "to run command Ci (encrypt or decrypt) on string Si with key Ki\n"
    unless @ARGV and @ARGV%3==0;
while(1){
    my ($command, $key, $string)=splice @ARGV, 0, 3;
    last unless $command;
    my ($l_command, $l_key, $l_string)=map {lc} ($command, $key, $string); # normalize
    try {
        die "Wrong command: $command\n" unless defined $commands{$l_command};
        my $result=$commands{$l_command}->($l_key, $l_string); # encrypt or decrypt
        say "$command($key, $string)=\n\t", join " ", split /(.....)/,$result;
    }
    catch {
        say $_;
    }
}
sub encrypt {
    my ($key, $message)=@_;
    map {s/[^a-z]//g; s/j/i/g;} ($key, $message); # only letters, j=i
    my ($table_a, $table_h)=make_tables($key); # map coordinates to letters and viceversa
    my @message=split '', $message;
    my @encrypted;
    while(@message){
        my $first=shift @message;
        my $second;
        $second=@message && $message[0] ne $first # check availability, repetitions
            ?shift @message
            :'x'; # dummy x to avoid repetitions
        my ($row1, $col1)=@{$table_h->{$first}}; # get coordinates
        my ($row2, $col2)=@{$table_h->{$second}};
        push(@encrypted, $table_a->[$row1][$col2],
             $table_a->[$row2][$col1]), next # exchange corners
            if $row1!=$row2 && $col1 != $col2; # rectangle
        push(@encrypted, $table_a->[$row1][($col1+1)%5],
             $table_a->[$row2][($col2+1)%5]), next # rotate right
            if $row1==$row2 && $col1 != $col2; # single row
        push(@encrypted, $table_a->[($row1+1)%5][$col1],
             $table_a->[($row2+1)%5][$col2]), next # rotate down
            if $row1!=$row2 && $col1 == $col2; # single column
        # I can only arrive here if there are two consequtive x's. Not
        # sure what to do, so I'll just return them
        push @encrypted, 'x', 'x'; # repeated x
    }
    return join '', @encrypted;
}
sub decrypt { # similar to encrypt but with opposite rotations.
    my ($key, $message)=@_;
    map {s/[^a-z]//g; s/j/i/g;} ($key, $message); # only letters, j=i
    my ($table_a, $table_h)=make_tables($key);
    my @message=split '', $message;
    die "Encrypted string should have even length\n" if @message%2;
    my @decrypted;
    while(@message){
        my ($first, $second)=splice @message,0,2;
        my ($row1, $col1)=@{$table_h->{$first}};
        my ($row2, $col2)=@{$table_h->{$second}};
        push(@decrypted, $table_a->[$row1][$col2],
             $table_a->[$row2][$col1]), next # exchange corners
            if $row1!=$row2 && $col1 != $col2;
        push(@decrypted, $table_a->[$row1][($col1-1)%5],
             $table_a->[$row2][($col2-1)%5]), next # rotate left
            if $row1==$row2 && $col1 != $col2;
        push(@decrypted, $table_a->[($row1-1)%5][$col1],
             $table_a->[($row2-1)%5][$col2]), next # rotate up
            if $row1!=$row2 && $col1 == $col2;
        # I arrive here for the case xx
        push @decrypted, 'x'; # remove repetition
    }
    return join '', @decrypted;
}

sub make_tables {
    my $key=shift; # only letters a-z and without j's and
    my @letters=((split '', $key),('a'..'i', 'k'..'z')); # complete alphabet
    my (@table, %table);
    my $i=0;
    foreach(@letters){
        my ($row, $col)=(floor($i/5), $i%5);
        $table[$row][$col]=$_, $table{$_}=[$row,$col], ++$i unless defined $table{$_};
    }
    return (\@table, \%table);
}
