#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       who-took-my-cheese.pl
#
#       Missing Permutation
#         Submitted by: Mohammad S Anwar
#         You are given possible permutations of the string 'PERL'.
# 
#         PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
#         ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
#         LPER, LPRE, LEPR, LRPE, LREP
#         Write a script to find any permutations missing from the list.
# 
#       analysis:
#
#         This is a good exercise for a data-analysis problem that one
#         could reasonabliy come across in the wild: given a data set, to
#         find the point that *isn't* there.
# 
#         To look for the missing piece of the puzzle isn't generally an
#         easy task. First you need to find out what you're looking for. If
#         you can't explicitly do that, the next-best thing would be to
#         find out all the possible things that could be.
# 
#         You can't find Waldo if you have no idea what he looks like, and
#         if he slips out the back whilst you're looking for God-knows-who
#         then he's a ghost in the night.
# 
#         The idea is to make a systematic examination of what you have
#         against what you expect, and spot the diffference. We could do
#         this by making two pools of data and removing common items from
#         each until something is left over.
# 
#         This is tedious and will work. The task, then, becomes to do this
#         as efficiently as possible.

#       method:
# 
#         Hashes in Perl are very fast, and constant in their lookup time.
#         For all intents and purposes, the size of the hash being accessed
#         does not matter. So if we hash the input as keys, we can check
#         those keys for existence in constant time. Furthemore, there is
#         no advantage to winnowing the lookup pool as we go, as this won't
#         shortent the access time in any meaningful way.
# 
#         So the next step is to generate the permutations. I toyed briefly
#         with the idea of creating a routine for this task, and almost
#         reached for some old code to blow the dust off. But then I
#         decided if I was jut going to use my own implementation of
#         Knuth's Algorithm L then what's the reasoning not to use someone
#         else's compiled function? So I did the proper thing snd pulled in
#         a combinatorics module to provide the means.
# 
#         This I think was in the spirit of the task: here is a specific
#         data set with some unknown element missing. It's large enough
#         that performing the task manually would be a bother. So hard-code
#         a quick tool to find the answer.
# 
#         This, then, I what I did.
# 
# 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use Algorithm::Combinatorics qw( permutations );

my @pool = qw(  PELR  PREL  PERL  PRLE  PLER  
                PLRE  EPRL  EPLR  ERPL  ERLP  
                ELPR  ELRP  RPEL  RPLE  REPL  
                RELP  RLPE  RLEP  LPER  LPRE  
                LEPR  LRPE  LREP    );
                
my %pool = map { $_ => undef } @pool;

my $iter = permutations( [split //, 'PERL'] );

while ( my $p = $iter->next ) {
    my $perm = join '', $p->@*;
    next if exists $pool{$perm};
    say $perm;
    last;
}






