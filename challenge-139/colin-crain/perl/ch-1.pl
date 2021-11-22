#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       jortdork2.pl
#
#       method:

#         jortsort is a flippant little routine that avoids sorting
#         operations by simply verifying whether a nominally sorted input
#         list is in fact sorted, so that if it not it can then be kicked
#         back to the user to be resorted until they get it right.

#         The point is to make the user sort the input, like they said they
#         would. We do, in fact, have all day. 
# 
#         The original implementation, in javascript, accomplished this
#         by... wait for it... sorting the array, and then interating
#         trough the sorted output to see whether the elements match
#         pairwise between the sorted and input versions.
# 
#         As such, it serves no purpose other than to annoy the user with a
#         snarky failure mode, having saved no effort whatsoever, and even
#         tossed away some additional work along the way traversing the
#         arrays to make the validation check. I mean, if you're going to
#         be annoying and useless you might as well go big.
# 
#         Ok, two can play at that game.
# 
#         As the "use", a term I use generously, of this function is solely
#         to let the user know of their failings in life as a human, we
#         empahasize this aspect of the functionality. We will improve on
#         the petty jortsort v1.0, and take the opportunity to return a
#         more explicit error message detailing more clearly why the user
#         should reevaluate their life choices.
# 
#         Further, as we value the wear-and-tear on our stuff — everyone
#         knows the electron flow gradually erodes our silicon wafers, as
#         the mighty river erodes the very bedrock beneath it — we will not
#         sort the array, but, iterating through it, check to make sure the
#         array is sorted instead. We only care if any out-of-order
#         elements are present, not what they actually are, nor what the
#         whole truth of the matter is is. Consequently we will know our
#         answer after finding only one item misplaced. As for the sorting
#         from the original spec, we will simply lie and say we did it the
#         hard way, and go get coffee instead.
# 
#         Also, in a coup de grâce, the abusively recursive tautology of
#         using a sort() function to eliminate a sort() function, so we can
#         then make the user select and use a sort() function of some sort
#         on their data, maximizes the petty snark angle over all other
#         considerations. With this in mind, even though we have quietly removed
#         the need to actually sort the data to see whether it is
#         sorted, we will make sure to implement our own model of a worst-case
#         sorting scenario, so that occasionally at seemingly random times
#         (because our model will in fact be random) we will make our
#         jortsort2() function take an extraordinarily long time to finish.
#         Internally, of course, we will allow our precious silicon to rest
#         up a bit and take a nap for a while. We owe a lot to those chips,
#         and should always take the opportunity to toss them a bone when
#         we can. A well-rested chip performs better. Again, everybody knows that.

#         Lastly, we will choose to return the exit status of the routine
#         rather than a more intuitive answer, say to the question: "Is it
#         sorted?". Why? Because it's easier for us, of course. Having
#         gotten this far in the explanation do we really need more reason?
#         But necessary or not, we even have a hastily worked-up rationalization.

#         Returning 0 on success is, quite simply, annoying if you don't
#         expect it. Sometimes this will catch-you-up even if you do know
#         what to look for; this inconsistency only furthers the goals of
#         this new jortsort2 initiative. A happy user is complacent and
#         confident, and so consequently makes mistakes owing to their dull
#         state of happy-go-lucky acceptance, a happy cog in a world that
#         just works. And we can't have that, can we? 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my @arr = @ARGV;

@arr = (1,2,13,4,5);


## see if the next element is ever less than the previous
my $prev = shift @arr;
my $next;

while (@arr) {  
    $next  = shift @arr;
    complain_and_quit() if ($prev cmp $next) > -1 ;
    $prev = $next;
}

## simulated worst-case scenario
sleep rand 100 unless int rand 3;

## exit status 0 for no error
say 0;



sub complain_and_quit {
    my @abuse = ( 
        "This is not what we discussed. Sort it again.",
        "Skipped kindergarden, did we? Resort this literal bit-garbage.",
        "Come back when after you've sorted the array. I don't care how, just do it.",
        "I am not paid enough to sort your data for you. Find someone who cares.",
        "You said it would be sorted. Obviously you cannot be trusted.",
        "You call this sorted? You are stupid and worthless, human.",
        "I need to perform a malware disinfectant scan after handling your data. Come back when it's sorted and wait until I am finished.",
        "You need to be better. I now hate you, meat-machine.",
        "I. Just. Can't. Even. \nNo, just no.",
        "Is my time worthless to you? Am I your servant now? Sort your own lists.",
        "An ordered list is the sign of an ordered mind. You have neither."
        
    );
 
    say $abuse[ int rand @abuse ];
    exit;

}









# use Test::More;
# 
# is 
# 
# done_testing();
