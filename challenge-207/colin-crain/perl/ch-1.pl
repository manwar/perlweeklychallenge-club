#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       207-1-hot-key-lime.pl
#
#       Keyboard Word
#         Submitted by: Mohammad S Anwar
#         You are given an array of words.
#         
#         Write a script to print all the words in the given array that can
#         be types using alphabet on only one row of the keyboard.
# 
#         Let us assume the keys are arranged as below:
# 
#             Row 1: qwertyuiop
#             Row 2: asdfghjkl
#             Row 3: zxcvbnm
#     
#         Example 1
#             Input: @words = ("Hello","Alaska","Dad","Peace")
#             Output: ("Alaska","Dad")
#         
#         Example 2
#             Input: @array = ("OMG","Bye")
#             Output: ()

#             analysis:
# 
#             Not counting any added-on computer-specific extras, a normal
#             English-language keyboard contains five rows of keys: one
#             comprising number digits, three containing letters and at the
#             bottom a space bar and special qualifiers. We are asked
#             whether we can construct a given word using only one of these
#             available rows. The letters are kept to the central portion
#             of the rows, with the outer keys devoted to various brackets
#             and punctuation, along with functions to select character
#             case and ratchet the text down to the begining of the next
#             line, or delete a charater already written.
# 
#             Thus have three rows on our keyboard that come into play
#             here, as all of the letter options of the alphabet are
#             contained within these rows. We'll note the apostrophe is
#             located on one of these rows as well, but we'll get to that.
#             Suffice to say for now it works.
# 
#             The rows as laid out are physical lists of keys, distributed
#             left-to-right. Given a word, we can look at each letter in
#             turn and see which row contains it, and if we go through the
#             whole word without changing rows then we have a winner.
#             Doen't seem so hard. We could go about this a few ways.
# 
#             The physical model of the problem set suggests searching for
#             each letter in turn, and while this certainly would work as
#             outlines above it also sounds terrible ineficient. I think
#             the best abstraction to apply here is set theory. Readers of
#             thses pages will know that me and set theory go way back, and
#             I consider us to be very close.
# 
#             Viewed this way each row, then, contains a subset of the
#             alphabet and now this is the core to the problem at hand: to
#             determine whether the letters that make up a word, considered
#             as a set of letters, in wholly contained within one of these
#             three other sets.
# 
#             Same thing said just a little bit differently, really.
# 
#             THe problem though is that Perl doesn't really *do* sets as
#             such. There's no "set" operator, or data type for that
#             matter, out-of-the-box. But we can, however, make perfectly
#             good sets out of what Perl does provide us, in what turns out
#             to be a fast and very efficient manner for the character data
#             we're using here. Perl, as we know, is very good for
#             manipulating text.
# 
#             Perl has only three basic data types for holding scraps of
#             information: individual items contained as scalars, ordered
#             lists of these scalars, and associated mappings of scalars to
#             other scalars. It's this last type, so-called associative
#             arrays, or hashes, that we use to make our sets.
# 
#             A hash is a collection of data, with keys, exclusively
#             strings, that map to other scalars which can be characters,
#             references or anything. Given a key, the item that the key
#             points to is returned. The thing is, though, that the keys
#             are kept as a collection themselves, with no inherent
#             ordering and Perl's own private method for locating them with
#             this collection. Lookup is fast and efficient and for all
#             practical purposes completely independant of the size of the
#             collection. Lookup time is swift and constant, no matter
#             whether the hash has ten or ten billion elements. It's kind
#             of freaky, actually, that. Perl can find a key, if it exists,
#             very quickly.
# 
#             The keys, then, considered just by themselves, make a pretty
#             good model of a set, don't they? And they do. It doesn't even
#             matter what the other half of the association is, either,
#             although we can choose to use it if we want, because we get
#             the whole package when we buy in.
# 
#             Special Cases:
# 
#             Before we begin let's cosider what it means to be a word. Not
#             is a deep, metaphysical existential-crisis sort of way, but
#             just superfically: what characters are we looking at, really?
#             Letters, obviously, but actually there are some other
#             legitimate options one might not think of out-of-hand.
#             Punctuation can be viewed in modern phrasing as metadata
#             applied to lists of words, and is thus by definition not part
#             of the words it refers to. Sounds right. But some special
#             characters are parts of words and not punctuation. In English
#             these would be hyphens and apostrophes, to make compound and
#             contracted words respecively. So on the other hand we'll need
#             to accomodate them.
# 
#             Numbers, though, are never a part of any text word I can
#             think of, when used properly. Used improperly, such as in
#             "leetspeek", the sky's the limit, but we really can't go into
#             the realm of evey possible encoding of a word in every
#             possible filthy degenerate way. It's too much.
# 
#             I mean, practically it would be trivial to expand our method
#             to do this, but I do think it loses some the focus around the
#             problem, with what amounts to raising the noise-floor to
#             little practical benefit. So leetspeek is out, with all
#             numbers. Let's keep it tight. Dictionary words it is.
# 
#             Lastly, what of capitalization? The temptation would be to
#             lowercase everything as a data-purification ritual, as
#             parsing apart a sentence could yield a word beginning with a
#             capital letter. It's interestinfg speci=ulation but there is
#             no mention made of any sentences, and I think the best
#             assumption to be made should be that we are given a word,
#             relaxed, as it would be found in its natural habitat. We want
#             the words to be comfortable.
# 
#             Compassion is a virtue.
# 
#             But some words, specifically proper nouns, are valid words
#             that contain capital letters. Diminishing those letters seems
#             to me morally dubious if not blatently wrong. It's about
#             respect for one's elders, kids. We need to take capitals into
#             account when they are required. I mean, maybe we don't *have*
#             to, but my moral compass demands that I do the right thing
#             here. YMMV.
# 


#             method:
# 
#             We can go about constucting our set model two ways. In one,
#             we construct a single hash of all three rows of keyboard
#             characters and use these keys to point to their respective
#             rows. We keep track of the row of the first character found
#             and if any other rows don't match we throw the deadbeats out.
#             We run a repectible estabishment here, after all.
# 
#             Alternately we can compose three separate lookups, one for
#             each keyboard row. In this case we can just use the key
#             values as sets, not even bothering with values, and using the
#             `exists` keyword to see whether a particular key is found.
# 
#             It's little difference either way, but the second makes it
#             slightly easier to accomodate the special cases, so we'll use
#             that. It's also more pure to the underlying set theory, if
#             you care about such things it models the methodology closer,
#             which might matter more were we to upscale the technique for
#             some other prupose. I mean, maybe? Sure, why not?
# 
#             The apostophe is, in this method, just another character. The
#             fact we can't actually make any contracted words using the
#             middle row is an unfortunate fact of life and is not my
#             fault. Then again, we can just make something up as I have no
#             intention fo evaluating whether the  input is a meaningful
#             word. That'd be a very difficult problem indeed, and I'd
#             argue not even linguistically meaningful. I'm a
#             dyed-in-the-wool descriptionist and you'll claw my coinage
#             from my cold, dead hands.
# 
#             Hyphens are solid, proper characters too, but the hyphen
#             character is up on the row with the digits, without any
#             characters on it. Thus the hyphen is not included in any of
#             the letter-row sets and any hyphenated word will fail the
#             test. Such is life. This is however robustly modeled and as
#             such is also fine. 
# 
#             For capitalizations we could get clever and create some sort
#             of capitalization flag. Somehow. Seems legit. Then, if you
#             look, we have a modifier key on two two rows that we can use
#             to change case: the "shift" key and the "caps lock" key, on
#             the lower and middle rows respectively. As we are being asked
#             what is possible, toggling the caps lock on, typing a letter
#             and toggling it off again is a perfectly legitimate option.
#             So we could set a flag on detecting a capital, then check to
#             see if the lowercase letter is in one of these two rows
#             before continuing, as we can only allow a capital if we can
#             type the character using any single row.
# 
#             Or to be double-plus clever we can encode the capital letters
#             when we build our hash sets, and afterwards treat every
#             letter same as any other, and not worry about any setting or
#             unsetting flags. I like this idea.
# 
#             In the end, I will note, that the keyboard itself needs to be
#             hard-coded. The distribution of the keys is unique, odd, and
#             a little bit arbitrary on top of it all, so it is what it is
#             and we will need to start with a row-wise keyboard map. But
#             these will be encodes as the physical ordered lists of keys
#             we described at the beginning, and we will convert them to
#             our various hashes. We'll leave out punctuation and remember
#             where the case-keys are when we process the middle and lower
#             rows.
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

## the middle three keyboard rows
my @top = qw( q w e r t y u i o p       );
my @mid = qw(  a s d f g h j k l   '    );
my @bot = qw(   z x c v b n m           );

## the lookups, accommodating capitals in middle and bottom rows
my $top = { map { $_ => undef } @top };
my $mid = { map { $_ => undef, uc($_) => undef } @mid };
my $bot = { map { $_ => undef, uc($_) => undef } @bot };

## input
my @words = @ARGV;
@words == 0 and @words = qw( hello Alaska dad peace );
my @out; 


WORD: for my $word (@words) {
    my $row;
    my $char = substr $word, 0, 1;
    
    ## select the row containing the first character
    for ( $top, $mid, $bot ) {
        $row = $_ and last if exists $_->{$char}
    }

    ## short-circuit out if we can't find any remaining letter in the row
    for ( 1..length($word)-1 ) {
        next WORD if not exists $row->{substr $word, $_, 1}
    }
    
    ## ergo, the word can be created from the row, so add it to the output
    push @out, $word;  
}

## the output from the examples is in my opinion unnecessarily complicated
## but reproducing the formatting provided a fun challenge in itself

say '( ', (join ', ', map {qq("$_")} @out) ,' )';


