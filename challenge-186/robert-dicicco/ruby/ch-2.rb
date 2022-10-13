#!/usr/bin/env ruby

# AUTHOR: Robert DiCicco
# DATE: 2022-10-11
# Challenge 186 Unicode Makeover ( Ruby )

myarr = ["ÃÊÍÒÙ", "âÊíÒÙ"]

for x in myarr

    for i in 0..(x.length-1)

      str = x[i]

      o = str.ord

      case o

      # CAPITAL A family

      when 192..197

        print "A"

      when 200..203

      # CAPITAL E family

        print 'E'

      when 204..207

      # CAPITAL I family

        print 'I'

      when 210..214

      # CAPITAL O family

        print 'O'

      when 217..219

      # CAPITAL U family

        print 'U'

      when 224..229

      # SMALL LETTER a family

        print 'a'

      when 232..235

      # SMALL LETTER e family

        print 'e'

      when 236..239

      # SMALL LETTER i family

        print 'i'

      when 242..246

      # SMALL LETTER o family

        print 'o'

      when 249..252

      # SMALL LETTER u family

        print 'u'

      else

        prints '?'

      end

    end

    puts " "

end
