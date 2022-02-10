#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1], 1 ],
  [ [2,1], 2 ],
  [ [1,2], 2 ],
  [ [2,4,5], 7 ],
  [ [4,2,3,6,5,3], 13 ],
  [ [2,4,3,6,5,3], 13 ],
  [ [0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0], 4 ],
  [ [map {ord$_} split //,'In a hole in the ground there lived a hobbit. Not a nasty, dirty, wet hole, filled with the ends of worms and an oozy smell, nor yet a dry, bare, sandy hole with nothing in it to sit down on or to eat: it was a hobbit-hole, and that means comfort.'], 11946 ],
  [ [map {ord$_} split //,long()], 668_385 ],
);

is( rob(     @{$_->[0]}), $_->[1] ) foreach @TESTS;
is( rob2(    @{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

timethis( 2_000, sub { rob( @{$_->[0]} ) foreach @TESTS; } );

sub rob {
    ## Line 1 - Trip finishing at the first house the value is the
    ##          points for the first house
    ## Line 2 - If there is more than one house we set the value
    ##          for the second house to be the points for the house
    ##          itself, unless the first house has a better value
    ## Line 3 - We repeat this for the remaining houses.... It is the
    ##          points for this house + the value for two houses before
    ##          or the value for the previous house if it is greater
    ## Line 4 - When we get to the end the result is just the value
    ##          for the last house!
    ##
    ## Comments this way so they don't hide the symmetry of the code
  my @b = shift;
  (push @b,shift    ), $b[-1]<$b[-2] && ($b[-1]=$b[-2]) if  @_;
  (push @b,$_+$b[-2]), $b[-1]<$b[-2] && ($b[-1]=$b[-2]) for @_;
  $b[-1];
}

sub long {
return 'In a hole in the ground there lived a hobbit. Not a nasty, dirty, wet hole, filled with the ends of worms and an oozy smell, nor yet a dry, bare, sandy hole with nothing in it to sit down on or to eat: it was a hobbit-hole, and that means comfort.

It had a perfectly round door like a porthole, painted green, with a shiny yellow brass knob in the exact middle. The door opened on to a tube-shaped hall like a tunnel: a very comfortable tunnel without smoke, with panelled walls, and floors tiled and carpeted, provided with polished chairs, and lots and lots of pegs for hats and coats—the hobbit was fond of visitors. The tunnel wound on and on, going fairly but not quite straight into the side of the hill—The Hill, as all the people for many miles round called it—and many little round doors opened out of it, first on one side and then on another. No going upstairs for the hobbit: bedrooms, bathrooms, cellars, pantries (lots of these), wardrobes (he had whole rooms devoted to clothes), kitchens, dining-rooms, all were on the same floor, and indeed on the same passage. The best rooms were all on the left-hand side (going in), for these were the only ones to have windows, deep-set round windows looking over his garden, and meadows beyond, sloping down to the river.

This hobbit was a very well-to-do hobbit, and his name was Baggins. The Bagginses had lived in the neighbourhood of The Hill for time out of mind, and people considered them very respectable, not only because most of them were rich, but also because they never had any adventures or did anything unexpected: you could tell what a Baggins would say on any question without the bother of asking him. This is a story of how a Baggins had an adventure, and found himself doing and saying things altogether unexpected. He may have lost the neighbours’ respect, but he gained—well, you will see whether he gained anything in the end.

The mother of our particular hobbit—what is a hobbit? I suppose hobbits need some description nowadays, since they have become rare and shy of the Big People, as they call us. They are (or were) a little people, about half our height, and smaller than the bearded dwarves. Hobbits have no beards. There is little or no magic about them, except the ordinary everyday sort which helps them to disappear quietly and quickly when large stupid folk like you and me come blundering along, making a noise like elephants which they can hear a mile off. They are inclined to be fat in the stomach; they dress in bright colours (chiefly green and yellow); wear no shoes, because their feet grow natural leathery soles and thick warm brown hair like the stuff on their heads (which is curly); have long clever brown fingers, good-natured faces, and laugh deep fruity laughs (especially after dinner, which they have twice a day when they can get it). Now you know enough to go on with. As I was saying, the mother of this hobbit—of Bilbo Baggins, that is—was the famous Belladonna Took, one of the three remarkable daughters of the Old Took, head of the hobbits who lived across The Water, the small river that ran at the foot of The Hill. It was often said (in other families) that long ago one of the Took ancestors must have taken a fairy wife. That was, of course, absurd, but certainly there was still something not entirely hobbitlike about them, and once in a while members of the Took-clan would go and have adventures. They discreetly disappeared, and the family hushed it up; but the fact remained that the Tooks were not as respectable as the Bagginses, though they were undoubtedly richer.

Not that Belladonna Took ever had any adventures after she became Mrs. Bungo Baggins. Bungo, that was Bilbo’s father, built the most luxurious hobbit-hole for her (and partly with her money) that was to be found either under The Hill or over The Hill or across The Water, and there they remained to the end of their days. Still it is probable that Bilbo, her only son, although he looked and behaved exactly like a second edition of his solid and comfortable father, got something a bit queer in his make-up from the Took side, something that only waited for a chance to come out. The chance never arrived, until Bilbo Baggins was grown up, being about fifty years old or so, and living in the beautiful hobbit-hole built by his father, which I have just described for you, until he had in fact apparently settled down immovably.

By some curious chance one morning long ago in the quiet of the world, when there was less noise and more green, and the hobbits were still numerous and prosperous, and Bilbo Baggins was standing at his door after breakfast smoking an enormous long wooden pipe that reached nearly down to his woolly toes (neatly brushed)—Gandalf came by. Gandalf! If you had heard only a quarter of what I have heard about him, and I have only heard very little of all there is to hear, you would be prepared for any sort of remarkable tale. Tales and adventures sprouted up all over the place wherever he went, in the most extraordinary fashion. He had not been down that way under The Hill for ages and ages, not since his friend the Old Took died, in fact, and the hobbits had almost forgotten what he looked like. He had been away over The Hill and across The Water on businesses of his own since they were all small hobbit-boys and hobbit-girls.

All that the unsuspecting Bilbo saw that morning was an old man with a staff. He had a tall pointed blue hat, a long grey cloak, a silver scarf over which his long white beard hung down below his waist, and immense black boots.

“Good Morning!” said Bilbo, and he meant it. The sun was shining, and the grass was very green. But Gandalf looked at him from under long bushy eyebrows that stuck out further than the brim of his shady hat.

“What do you mean?” he said. “Do you wish me a good morning, or mean that it is a good morning whether I want it or not; or that you feel good this morning; or that it is a morning to be good on?”

“All of them at once,” said Bilbo. “And a very fine morning for a pipe of tobacco out of doors, into the bargain. If you have a pipe about you, sit down and have a fill of mine! There’s no hurry, we have all the day before us!” Then Bilbo sat down on a seat by his door, crossed his legs, and blew out a beautiful grey ring of smoke that sailed up into the air without breaking and floated away over The Hill.

“Very pretty!” said Gandalf. “But I have no time to blow smoke-rings this morning. I am looking for someone to share in an adventure that I am arranging, and it’s very difficult to find anyone.”

“I should think so—in these parts! We are plain quiet folk and have no use for adventures. Nasty disturbing uncomfortable things! Make you late for dinner! I can’t think what anybody sees in them,” said our Mr. Baggins, and stuck one thumb behind his braces, and blew out another even bigger smoke-ring. Then he took out his morning letters, and began to read, pretending to take no more notice of the old man. He had decided that he was not quite his sort, and wanted him to go away. But the old man did not move. He stood leaning on his stick and gazing at the hobbit without saying anything, till Bilbo got quite uncomfortable and even a little cross.

“Good morning!” he said at last. “We don’t want any adventures here, thank you! You might try over The Hill or across The Water.” By this he meant that the conversation was at an end.

“What a lot of things you do use Good morning for!” said Gandalf. “Now you mean that you want to get rid of me, and that it won’t be good till I move off.”

“Not at all, not at all, my dear sir! Let me see, I don’t think I know your name?”

“Yes, yes, my dear sir—and I do know your name, Mr. Bilbo Baggins. And you do know my name, though you don’t remember that I belong to it. I am Gandalf, and Gandalf means me! To think that I should have lived to be good-morninged by Belladonna Took’s son, as if I was selling buttons at the door!”

“Gandalf, Gandalf! Good gracious me! Not the wandering wizard that gave Old Took a pair of magic diamond studs that fastened themselves and never came undone till ordered? Not the fellow who used to tell such wonderful tales at parties, about dragons and goblins and giants and the rescue of princesses and the unexpected luck of widows’ sons? Not the man that used to make such particularly excellent fireworks! I remember those! Old Took used to have them on Midsummer’s Eve. Splendid! They used to go up like great lilies and snapdragons and laburnums of fire and hang in the twilight all evening!” You will notice already that Mr. Baggins was not quite so prosy as he liked to believe, also that he was very fond of flowers. “Dear me!” he went on. “Not the Gandalf who was responsible for so many quiet lads and lasses going off into the Blue for mad adventures? Anything from climbing trees to visiting elves—or sailing in ships, sailing to other shores! Bless me, life used to be quite inter—I mean, you used to upset things badly in these parts once upon a time. I beg your pardon, but I had no idea you were still in business.”

“Where else should I be?” said the wizard. “All the same I am pleased to find you remember something about me. You seem to remember my fireworks kindly, at any rate, and that is not without hope. Indeed for your old grandfather Took’s sake, and for the sake of poor Belladonna, I will give you what you asked for.”

“I beg your pardon, I haven’t asked for anything!”

“Yes, you have! Twice now. My pardon. I give it you. In fact I will go so far as to send you on this adventure. Very amusing for me, very good for you—and profitable too, very likely, if you ever get over it.”

“Sorry! I don’t want any adventures, thank you. Not today. Good morning! But please come to tea—any time you like! Why not tomorrow? Come tomorrow! Good bye!” With that the hobbit turned and scuttled inside his round green door, and shut it as quickly as he dared, not to seem rude. Wizards after all are wizards.

“What on earth did I ask him to tea for!” he said to himself, as he went to the pantry. He had only just had breakfast, but he thought a cake or two and a drink of something would do him good after his fright.

Gandalf in the meantime was still standing outside the door, and laughing long but quietly. After a while he stepped up, and with the spike on his staff scratched a queer sign on the hobbit’s beautiful green front-door. Then he strode away, just about the time when Bilbo was finishing his second cake and beginning to think that he had escaped adventures very well.

The next day he had almost forgotten about Gandalf. He did not remember things very well, unless he put them down on his Engagement Tablet: like this: Gandalf Tea Wednesday. Yesterday he had been too flustered to do anything of the kind.

Just before tea-time there came a tremendous ring on the front-door bell, and then he remembered! He rushed and put on the kettle, and put out another cup and saucer, and an extra cake or two, and ran to the door.

“I am so sorry to keep you waiting!” he was going to say, when he saw that it was not Gandalf at all. It was a dwarf with a blue beard tucked into a golden belt, and very bright eyes under his dark-green hood. As soon as the door was opened, he pushed inside, just as if he had been expected.

He hung his hooded cloak on the nearest peg, and “Dwalin at your service!” he said with a low bow.

“Bilbo Baggins at yours!” said the hobbit, too surprised to ask any questions for the moment. When the silence that followed had become uncomfortable, he added: “I am just about to take tea; pray come and have some with me.” A little stiff perhaps, but he meant it kindly. And what would you do, if an uninvited dwarf came and hung his things up in your hall without a word of explanation?

They had not been at table long, in fact they had hardly reached the third cake, when there came another even louder ring at the bell.

“Excuse me!” said the hobbit, and off he went to the door.

“So you have got here at last!” That was what he was going to say to Gandalf this time. But it was not Gandalf. Instead there was a very old-looking dwarf on the step with a white beard and a scarlet hood; and he too hopped inside as soon as the door was open, just as if he had been invited.

“I see they have begun to arrive already,” he said when he caught sight of Dwalin’s green hood hanging up. He hung his red one next to it, and “Balin at your service!” he said with his hand on his breast.

“Thank you!” said Bilbo with a gasp. It was not the correct thing to say, but they have begun to arrive had flustered him badly. He liked visitors, but he liked to know them before they arrived, and he preferred to ask them himself. He had a horrible thought that the cakes might run short, and then he—as the host: he knew his duty and stuck to it however painful—he might have to go without.

“Come along in, and have some tea!” he managed to say after taking a deep breath.

“A little beer would suit me better, if it is all the same to you, my good sir,” said Balin with the white beard. “But I don’t mind some cake—seed-cake, if you have any.”';
}
