#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-09
use utf8;     # Week 286 - task 1 - Self spammer
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use File::Spec;

my ($script_path, @words, $rand);

# find location of source script
$script_path = File::Spec->rel2abs(__FILE__);

# split it into 'words'
@words = split(/\s+/, `cat $script_path`);

# select a random 'word'
$rand = int(rand(@words));	
say qq[\nOutput: word $rand of ] . (scalar(@words) - 1) . qq[ is '$words[$rand]'];
