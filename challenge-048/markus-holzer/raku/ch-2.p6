my $formatter = sub { sprintf '%02d%02d%04d', .month, .day, .year given $^date }; 

#.say for (1300..1399)
.say for (2000..2999)
    # filter out most of the impossible years
    .grep({ 
        0 < .substr(2,2).flip < 13 &&
        0 < .substr(0,2).flip < 32 })
    # Try making a date, this fails sometimes, eg for the year 1311 -> 11311311
    # which is not a valid date
    .map({  
        try Date.new($_, |.flip.comb(2), :$formatter ) })
    # So we need to filter these out
    .grep({ 
        .so });

# 36 solutions in total
# 10022001
# 01022010
# 11022011
# 02022020
# 12022021
# 03022030
# 04022040
# 05022050
# 06022060
# 07022070
# 08022080
# 09022090
# 10122101
# 01122110
# 11122111
# 02122120
# 12122121
# 03122130
# 04122140
# 05122150
# 06122160
# 07122170
# 08122180
# 09122190
# 10222201
# 01222210
# 11222211
# 02222220
# 12222221
# 03222230
# 04222240
# 05222250
# 06222260
# 07222270
# 08222280
# 09222290

