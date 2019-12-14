# Date Finder
#
# Create a script to accept a 7 digits number, where the first number can only
# be 1 or 2. The second and third digits can be anything 0-9. The fourth and
# fifth digits corresponds to the month i.e. 01,02,03…,11,12. And the last 2
# digits respresents the days in the month i.e. 01,02,03….29,30,31. Your script
# should validate if the given number is valid as per the rule and then convert
# into human readable format date.
#
# RULES
#
# 1) If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd and 3rd digits
#    to make it 4-digits year.
# 2) The 4th and 5th digits together should be a valid month.
# 3) The 6th and 7th digits together should be a valid day for the above month.
#
# For example, the given number is 2230120, it should print 1923-01-20.

grammar DATE {
    token TOP { <century> <year> <month> <day> }
    regex century { 1 | 2 }
    regex year { <digit>**2 }
    regex month { <digit>**2 }
    regex day { <digit>**2 }
}

class ConvDate {
    method TOP ($/) { make (if ($<century> == 1) { 20 } else { 19 }) ~ $<year>
                      ~ '-' ~ $<month> ~ '-' ~ $<day>; }
}

say DATE.parse(2230120, actions => ConvDate).made;
