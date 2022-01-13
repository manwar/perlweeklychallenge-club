#!/usr/bin/env perl
# Perl weekly challenge 145
# Task 2: Palindromic tree. Object based
#
# See https://wlmb.github.io/2021/12/27/PWC145/#task-1-palindromic-tree
use v5.26;
use warnings;
use utf8;
use Object::Pad;

class PNode {
    has %edges;
    has $size :param :reader;
    has $suffix :param :accessor =undef;
    method edge {
	my $label=shift;
	return $edges{$label};
    }
    method edges {
	return keys %edges;
    }
    method add_edge {
	my ($label, $target)=@_;
	die "Duplicate edge" if defined $edges{$label};
	$edges{$label}=$target;
    }
    BUILD {
	%edges=();
    }
};
class PTree {
    use Encode qw(decode_utf8);
    use Text::Unidecode;
    has $string :param :reader;
    has $imaginary_root :reader;
    has $root :reader;
    has $current :reader;

    has @letters;
    method $add_letter {
	my $index=shift;
	my $letter=$letters[$index];
	$current=$current->suffix
	    while $index-$current->size-1<0
                || $letters[$index-$current->size-1] ne $letter;
	$current=$current->edge($letter), return
	    if defined $current->edge($letter);
	my $suffix=$current->suffix;
	my $found=$current;
	$found->add_edge(
	    $letter,
            $current=PNode->new(size=>$current->size+2, suffix=>$root));
	return if $current->size==1;
	$suffix=$suffix->suffix
            while $letters[$index-$suffix->size-1] ne $letter;
	$current->suffix($suffix->edge($letter));
    }
    method iterator {
	my @queue=((map {[$imaginary_root->edge($_), $_]} $imaginary_root->edges), [$root, ""]);
	sub {
                {
		    return undef unless @queue;
		    my $element=shift @queue;
		    my ($node, $center)=$element->@*;
		    push @queue, (map {[$node->edge($_), $_.$center.$_]} $node->edges);
		    redo unless $center;
		    return $center;
		}
        }
    }
    BUILD {
	$imaginary_root=PNode->new(size=>-1);
	$imaginary_root->suffix($imaginary_root);
	$root=PNode->new(size=>0, suffix=>$imaginary_root);
	$current=$root;
	my $s=decode_utf8($string,9);
	$s=~s/\p{Punct}//g; #remove punctuation
	$s=~s/\s*//g; #remove spaces
	@letters=split '', unidecode(lc $s); #ignore case, remove accents
	foreach(0..@letters-1){
	    $self->$add_letter($_);
	}
    }
};
foreach(@ARGV){
    my $tree=PTree->new(string=>$_);
    my $next=$tree->iterator;
    while(my $p=$next->()){
        say $p;
    }
}
