#!/usr/bin/env ruby

=begin
I found these routines in an article written by Joe McCann
  joe-mccann.dev
  and also Module: Roman Numerals
  Paul M. Winkler
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-26
Challenge 227 Task 2 Roman Maths ( Ruby )
----------------------------------------------
=end
def numerals
  {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }
end

def special_numerals
  {
    'IV' => 4,
    'IX' => 9,
    'XL' => 40,
    'XC' => 90,
    'CD' => 400,
    'CM' => 900
  }
end

ROMAN_NUMBERS = {
    1000 => "M",
     900 => "CM",
     500 => "D",
     400 => "CD",
     100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
        9 => "IX",
        5 => "V",
        4 => "IV",
        1 => "I",
}

def roman_to_int(s)
  special_matches = s.scan(/IV|IX|XL|XC|CD|CM/)
  if special_matches
    special_sum = special_matches.map { |m| special_numerals[m]}.sum
    special_matches.each { |m| s.gsub!(m, '') }
  end
  normal_sum = s.each_char.map { |c| numerals[c] }.sum
  return (special_sum + normal_sum) if special_sum

  normal_sum
end

def int_to_roman(n)
    #n = self
    roman = ""
    ROMAN_NUMBERS.each do |value, letter|
      roman << letter*(n / value)
      n = n % value
    end
    return roman
end

def main()
    input_array = ARGV
    if input_array.length != 1
        puts("Please enter a math problem using Roman numerals")
        exit

    end

    problem = ARGV[0]
    parts = problem.split
    left = parts[0]
    lft = roman_to_int(left)
#333    puts("#{left} = #{lft}")
    op = parts[1]
    right = parts[2]
    rt = roman_to_int(right)

    if ( op == '-' and lft - rt == 0)
        puts("#{problem} est nulla")
        exit(1)
    elsif (op == '/' and (lft % rt) > 0 )
        puts("#{problem} non potest")
        exit(1)
    elsif (op == '+' and lft + rt > 3999)
        puts("#{problem} non potest")
        exit(1)
    elsif (op == '-' and (lft - rt < 0))
        puts("#{problem} non potest")
        exit(1)
    elsif (op == '/' and (lft % rt != 0))
        puts("#{problem} non potest")
        exit(1)
    end

    if ( op == '+')
        val = int_to_roman(lft + rt)
    elsif ( op == '-')
        val = int_to_roman(lft - rt)
    elsif ( op == '/')
        val = int_to_roman((lft / rt))
    elsif ( op == '*')
        val = int_to_roman((lft * rt))
    elsif ( op == '**')
        val = int_to_roman(lft ** rt)
    end

    puts("#{problem} => #{val}")
end

main()

=begin
----------------------------------------------
ruby .\RomanMath.rb "IV + V"
IV + V => IX

ruby .\RomanMath.rb "M - I"
M - I => CMXCIX

ruby .\RomanMath.rb "X / II"
X / II => V

ruby .\RomanMath.rb "XI * VI"
XI * VI => LXVI

ruby .\RomanMath.rb "XII ** III"
XII ** III => MDCCXXVIII

ruby .\RomanMath.rb "V - V"
V - V est nulla

ruby .\RomanMath.rb "V / II"
V / II non potest

ruby .\RomanMath.rb "MMM + M"
MMM + M non potest

ruby .\RomanMath.rb "V - X"
V - X non potest
----------------------------------------------
=end




