#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 10001.awk
#
#        USAGE: ./10001.awk < INFILE
#
#  DESCRIPTION: Analyses each line of standard input to determine if it is
#               12 or 24 hour clock and converts to the other.
#
# REQUIREMENTS: A gawk-compatible awk
#        NOTES: The leading zero pad comes from the spec examples.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 19/02/21
#===============================================================================

/[01][0-9]:[0-5][0-9]\s*[ap]m/ {
	match ($0, /([01][0-9])(:[0-5][0-9])\s*([ap]m)/, a)
	hh = a[1]
	if (a[3] == "am") {
		if (hh == "12") {
			hh = "00"
		}
	} else if (hh < 12) {
		hh += 12
	}
	print hh a[2]
	next
}

/[012][0-9]:[0-5][0-9]/ {
	match ($0, /([012][0-9])(:[0-5][0-9])/, a)
	hh = a[1]
	if (hh > 11) {
		post = "pm"
	} else {
		post = "am"
	}
	if (hh > 12) {
		hh = hh % 12
	}
	if (hh < 1) {
		hh = 12
	}
	print hh a[2] post
	next
}

{ next }
