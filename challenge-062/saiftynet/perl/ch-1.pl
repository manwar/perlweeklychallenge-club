#!/usr/env/perl
# Task 1 Challenge 062 Solution by saiftynet
#  › Sort Email AddressesSubmitted by: Neil BowersReviewed by: Ryan 
# ThompsonWrite a script that takes a list of email addresses (one 
# per line) and sorts them first by the domain part of the email 
# address, and then by the part to the left of the @ (known as the 
# mailbox).
# Note that the domain is case-insensitive, while the mailbox part 
# is case sensitive. (Some email providers choose to ignore case, 
# but that&rsquo;s another matter entirely.)
# If your script is invoked with arguments, it should treat them 
# as file names and read them in order, otherwise your script should 
# read email addresses from standard input.
# BonusAdd a -u option which only includes unique email addresses 
# in the output, just like sort -u.


# this iextended to provide a couple of other options
# including saving output to file and chhoding another separator and 
# also allowing for case insensitive user portion of the email

use strict;use warnings;
use 5.10.0;
my @list=();
my %option=(
   unique=>0,
   separator=>"\n",
   caseInsensitive=>0,
);

# example input to demo if no input supplied
my @plist=("name\@example.org","rjt\@cpan.org","Name\@example.org",
          "rjt\@CPAN.org","user\@alpha.example.org","data","-U");
# or use provided input
@plist=@ARGV if @ARGV; 

while (@plist){
  my $next=shift @plist; 
  if ($next=~/^(.+@[^@]+)$/){ # collect email-looking arguments
    push @list, $next 
    }
    # options -u unique as defined in task,
    #         -U username case insensitive
    #         -o output to file (follwed by filename
    #         -s choose a different separator
    elsif   ($next=~/^-[Uuos]$/){ 
      if    ($next=~/^-u$/) {$option{unique}=1}
      elsif ($next=~/^-o$/) {$option{outputFile}=shift @plist}
      elsif ($next=~/^-U$/) {$option{caseInsensitive}=1;$option{unique}=1}
      elsif ($next=~/^-s$/) {$option{separator}=shift @plist}
      
    }
    # uses the __DATA__ segment for demo purposes if "data" is one of the parameters
    elsif ($next=~/^data$/i){ 
      while(<DATA>){
        my @found=(m/([^\s"']+@[\w\.]+)/g);
        push @list, @found;
      }
    }
    elsif (-f $next){
      open my $fh, "$next" or next; 
      while(<$fh>){
        my @found=(m/([^\s"']+@[^\w\b]+)/g);
        push @list, @found;
      }
      close $fh;
    }
}

sortEmail();

sub sortEmail{
  my @splitList=map {m/^(.+)@([^@]+)$/;[$1,$2]} map{$option{caseInsensitive}?lc $_:$_} @list;
  my @sorted=sort { lc ($$a[1]) cmp lc($$b[1])? lc $$a[1] cmp lc $$b[1]:$$a[0] cmp $$b[0]       } @splitList;
  my @filtered=();
  if ($option{unique}){
    foreach (0..$#sorted){
      push @filtered,$sorted[$_] unless (${$sorted[$_]}[0] eq ${$sorted[$_-1]}[0]) and (lc ${$sorted[$_]}[1] eq lc ${$sorted[$_-1]}[1])
    }
  }
  else {
    @filtered=@sorted;
  }
  
  if ($option{outputFile}){
    open (my $fh,">",$option{outputFile}) or die "unable to create outputFile $option{outputFile}:$!";
    print $fh "$$_[0]\@$$_[1]$option{separator}" foreach @filtered;
    close $fh;
    
  }
  else{
    print "$$_[0]\@$$_[1]$option{separator}" foreach @filtered;
  }
}


__DATA__
fred@flintstone.com, wilma@flintstone.com lorem ipsum etc rubbish barney@rubble.org
more rubbish BETTY@rubble.com 
;
