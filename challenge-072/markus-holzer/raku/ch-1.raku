sub MAIN(UInt $N where * > 0) {
	.chars.say with ( [*] 1..$N ) ~~ / 0+ $/ or '' }