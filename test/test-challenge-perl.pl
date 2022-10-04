#!/usr/bin/env perl

# Requirements:
# - contribution must be named `ch-1.pl`, `ch-2.pl`, `ch-1-variant.pl` ...
# - contribution must define one of functions
#   - challenge_XXX_1
#   - challenge_XXX_2

# Usage:
#   test-challenge-perl.pl
#   test-challenge-perl.pl FILE(S) | DIR(S)

# script walks through specified files / directories (`.` unless specified otherwise)
# and test contribution using challenge data

use v5.10;
use strict;
use warnings;

use Path::Tiny;
use Test::YAFT;
use YAML::Syck qw[ LoadFile ];

my $path = Path::Tiny->new (__FILE__)->parent;

sub parse_challenge {
	$_[0] =~ m(/challenge-(\d+)/([^/]+)/perl/ch-([1-2])(?:-([^/]+))?\.pl$);
}

sub find_perl_contributions {
	my (@source) = map { Path::Tiny->new ($_)->realpath } (@_ ? @_ : ('.'));

	my @contributions;
	while (my $candidate = shift @source) {
		if (-d $candidate) {
			push @source, $candidate->children;
			next;
		}

		next
			unless $candidate =~ m(/perl/ch-[12](?:-[^/]+)?\.pl$);

		push @contributions, $candidate;
	}

	return sort @contributions;
}

sub test_contributions {
	my $stash = \%::;

	my %test_plan;

	my $coderef;
	act { [ $coderef->(@{ $_[0] }) ] } 'input';

	for my $contribution (find_perl_contributions @_) {
		my ($challenge, $author, $number, $variant) = parse_challenge $contribution;

		my $message = "challenge $challenge/$number; contribution by $author";
		$message .= "; " . ($variant =~ s(\W+)( )gr) if $variant;

		my $code_name = "challenge_${challenge}_${number}";
		{
			no warnings 'redefine';
			do $contribution;
		}

		if ($@) {
			fail $message
				=> diag => sub { "Contribution load failed: $@" }
				;
			next;
		}

		unless (exists $stash->{$code_name}) {
			fail $message
				=> diag => sub { "Contribution doesn't contain expected function: $code_name" }
				;
			next;
		}

		$coderef = $stash->{$code_name};

		my $plan_file = Path::Tiny->new (__FILE__)
			->parent
			->child ("challenge-$challenge")
			->child ("ch-$number.yaml")
			;

		unless (-e $plan_file) {
			fail $message
				=> diag => sub { "test plan not found: $plan_file" }
				;
			next;
		}

		my $plan = $test_plan{$plan_file} = LoadFile $plan_file;
		subtest $message => sub {
			for my $message (sort keys %$plan) {
				it $message
					=> with_input => $plan->{$message}{input},
					=> expect     => $plan->{$message}{expect},
					;
			}
		};

		delete $stash->{$code_name};
	}

	done_testing;
}

test_contributions;


