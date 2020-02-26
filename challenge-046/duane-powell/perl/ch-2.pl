#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/ Task #2
# Solution: Iterate over doors and employees until we reach the final state

my $EMPLOYEE = shift || 500; # pass in $EMPLOYEE if you want to step thru the solution
use constant {
	ROOM     => 500,
	OPEN     => 0,
	CLOSED   => 1,
};

# Rule: toggle door (close door if open, open if closed) 
# if the modulus of employee and the room number is 0

# Initialize hotel with all room doors closed
my @room;
$room[$_] = CLOSED foreach(1 .. ROOM);

# Toggle doors up to nth $EMPLOYEE
foreach my $employee (1 .. $EMPLOYEE) {
	foreach my $room (1 .. ROOM) {
		if ( $room % $employee == 0) {
			$room[$room] = ($room[$room] == OPEN) ? CLOSED : OPEN;
		}
	}
}

# Report results
print "These doors are open after employee turn $EMPLOYEE:\n";
foreach my $room (1 .. ROOM) {
	print "$room " if ($room[$room] == OPEN);
} 
print "\n";

__END__

./ch-2.pl 500
These doors are open after employee turn 500:
1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400 441 484

./ch-2.pl 499
These doors are open after employee turn 499:
1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400 441 484 500

./ch-2.pl 2
These doors are open after employee turn 2:
1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 89 91 93 95 97 99 101 103 105 107 109 111 113 115 117 119 121 123 125 127 129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167 169 171 173 175 177 179 181 183 185 187 189 191 193 195 197 199 201 203 205 207 209 211 213 215 217 219 221 223 225 227 229 231 233 235 237 239 241 243 245 247 249 251 253 255 257 259 261 263 265 267 269 271 273 275 277 279 281 283 285 287 289 291 293 295 297 299 301 303 305 307 309 311 313 315 317 319 321 323 325 327 329 331 333 335 337 339 341 343 345 347 349 351 353 355 357 359 361 363 365 367 369 371 373 375 377 379 381 383 385 387 389 391 393 395 397 399 401 403 405 407 409 411 413 415 417 419 421 423 425 427 429 431 433 435 437 439 441 443 445 447 449 451 453 455 457 459 461 463 465 467 469 471 473 475 477 479 481 483 485 487 489 491 493 495 497 499

