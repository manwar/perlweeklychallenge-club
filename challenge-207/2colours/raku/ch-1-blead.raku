#!/usr/bin/env raku
# WARNING: this solution only works with recent "nightly" builds of Rakudo! Not released yet, not even as 6.e preview! 
use v6.*;

sub either-char-class(@classes) {
    my @word-choices = @classes.map: {
        RakuAST::Regex::Group.new(
          RakuAST::Regex::QuantifiedAtom.new(
            atom               => .&to-char-class,
            quantifier         => RakuAST::Regex::Quantifier::ZeroOrMore.new(
              backtrack => RakuAST::Regex::Backtrack
            ),
            trailing-separator => False
          )
        )
    };    
    RakuAST::QuotedRegex.new(
        match-immediately => False,
        body =>
            RakuAST::Regex::Sequence.new(
                RakuAST::Regex::InternalModifier::IgnoreCase.new,
                RakuAST::Regex::Anchor::BeginningOfString.new,
                RakuAST::Regex::Alternation.new(|@word-choices),
                RakuAST::Regex::Anchor::EndOfString.new
            )
    ).EVAL
}

sub to-char-class(Str:D $input) {
    my @elements = $input.comb.map: {
        RakuAST::Regex::CharClassEnumerationElement::Character.new($_)
    }
    RakuAST::Regex::Assertion::CharClass.new(
        RakuAST::Regex::CharClassElement::Enumeration.new(:@elements)
    )

}

constant @rows = <qwertyuiop asdfghjkl zxcvbnm>;
subset StrList of Str where /^ '(' ['"' $<str-content>=[.*?]  '"']* % ',' ')' $/;

sub MAIN(Str $input) {
  die 'Please provide a valid list of double-quoted (constant) strings.' unless $input.subst(/\s/, '', :g) ~~ StrList;
  my Str() @words = $<str-content>;
  @words.grep(either-char-class(@rows)).say;
}