#!/usr/bin/perl
# The Weekly Challenge 131
# TasK 2 Find Pairs
# Usage: $ ch-2.pl delimiters_string search_string
# Example: $ ch-2.pl '()**{}[]' '({Hello *World*})'
no warnings;
use v5.24.0;
use List::Util qw/any pairmap/;
use Data::Dumper;

my @open_uni  = qw/ ( [ { < /;
my @close_uni = qw/ ) ] } > /;
my %partner = ( ')'=>'(', ']'=>'[', '}'=>'{', '>' => '<' );
my @neutral_uni = qw{ , . ? ! / \ };
push @neutral_uni, qw{ @ # $ & + - ^ * % " ' }; # dangerous zone

my $d = '()**';
my $str = '(*Hello*)(*World*)';

if (defined($ARGV[1])) {
    $d = $ARGV[0];
    $str = $ARGV[1];
}

find_pair( [pairmap {$a.$b} (split //, $d)] , $str);

say "=========================================";

say "Example 1";
find_pair(
  [qw' "" [] () '], 
  '"I like (parens) and the Apple ][+" they said.' 
);

say "Example 2";
find_pair( 
  [qw' ** // <> '], 
  '/* This is a comment (in some languages) */ <could be a tag>'
);


say "Test Case 1a";
find_pair(
  [qw' () {} '], 
  'for ($a..$b) {do_sth;}' 
);

say "Test Case 1b";
find_pair(
  [qw' () {} '], 
  'for ($a..$b} (cannot_do_sth;}'
);

say "Test Case 2a";
find_pair(
  [qw' () {} ** '], 
  '( ilovePerl()*) {bad;}'
);

say "Test Case 2b";
find_pair(
  [qw' () {} ** '], 
  '(*ilovePerl()*) {good;}'
);

say "Test Case 3";
find_pair(
  ["<>"],
  '<html><head><title>HELLO</title></head></html>'
);


say "Test Case 4a";
find_pair(
  [qw{ ** // \\\\ }],
  '*/layer/*'
);

say "Test Case 4b";
find_pair(
  [qw{ ** // \\\\ }],
  '*/wrong layer*/'
);



sub find_pair {
    my %open_found; 
    my %close_found; 
    my %neutral_found;
    my @char = split //, $_[1];
    my @delimiters = split //, (join "", $_[0]->@*);

    for my $pair (@{$_[0]}) {
        my $s_head = substr($pair, 0, 1); 
        my $s_tail = substr($pair, 1, 1);
        $open_found{$s_head} = []
            if any { $_ eq $s_head } (map {substr($_, 0, 1)} @open_uni);
        $close_found{$s_tail} = []
            if any { $_ eq $s_tail } (map {substr($_, -1, 1)} @close_uni);
        $neutral_found{$s_head} = []
            if any { $_ eq $s_head } (map {substr($_, 0, 1)} @neutral_uni);
    }

    for my $i (0..$#char) {
        my $c = $char[$i];
        push $open_found{$c}->@*, $i if defined($open_found{$c});
        push $close_found{$c}->@*, $i if defined($close_found{$c});
        push $neutral_found{$c}->@*, $i if defined($neutral_found{$c}); 
    }

    my @open_positions;
    my @close_positions;
    my @all_positions;

    for (values %open_found, values %neutral_found) {
        push @open_positions, $_->@*;
    }
    for (values %close_found, values %neutral_found) {
        push @close_positions, $_->@*;
    }
    for (values %open_found, values %close_found, values %neutral_found) {
        push @all_positions, $_->@*;
    }

    say "Delimiters   : ", @delimiters;
    say "Search String: ", $_[1];
    @open_positions = sort {$a<=>$b} @open_positions;
    @close_positions = sort {$a<=>$b} @close_positions;
    say "    ", join "", map {$char[$_]} @open_positions;
    say "    ", join "", map {$char[$_]} @close_positions;
    

    @all_positions = sort {$a<=>$b} @all_positions;
    my @stack;
    my @waiting_to_be_closed;   # variable for warning message
    my $early_warn;   # variable for warning message
    for my $p (@all_positions) {
        my $c = $char[$p];
        if (defined($open_found{$c})) {
            push @stack, $c;
            push @waiting_to_be_closed, $p;
        }    
        if (defined($close_found{$c})) {
            if (scalar @stack > 0 && $stack[-1] eq $partner{$c}) {
                pop @stack;
                pop @waiting_to_be_closed;
            }
            elsif (!defined($neutral_found{$c})) {
                say("Warning: $stack[-1] at position ", 
                    $waiting_to_be_closed[-1],
                    " may not close appropriately."); 
                say("Warning: $c at position ", $p,
                    " may not be corresponding to an opening delimiter.");
                $early_warn = 1;
                last;
            }
            else {
                say("Warning: $stack[-1] at position ", 
                    $waiting_to_be_closed[-1],
                    " does not open or close appropriately.");
                $early_warn = 1;
                last;
            }
        }
        if (defined($neutral_found{$c})) {
            if (scalar @stack == 0 || $stack[-1] ne $c) {
                push @stack, $c;
                push @waiting_to_be_closed, $p;
            }
            elsif (scalar @stack != 0 && $stack[-1] eq $c) {
                pop @stack;
                pop @waiting_to_be_closed;
            }
            else {
                say("Warning: $stack[-1] at position ", $p,
                    " does not open or close appropriately." );
                $early_warn = 1;
                last;
            }
        }
    }
    if (!$early_warn && scalar @stack != 0 
        && !defined($close_found{$stack[-1]}) 
       ) {
        say "Warning: delimiter(s) do not open or close appropriately:";
        say "Delimiters: @stack";
        say "Positions: ", "@waiting_to_be_closed";
    }
    if ($early_warn) {
        say "Feedback: It is recommended that you check other ",
            "delimiters as well.";
    }
    
    say "";
}
