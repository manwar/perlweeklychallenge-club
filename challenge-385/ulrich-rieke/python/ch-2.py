#!/usr/bin/env python3

def remove_outermost( parens ):
   after_removal = ""
   current_number = 0
   for c in parens:
      if c == '(':
         current_number += 1
      else:
         current_number -= 1
      if c == '(' and current_number != 1:
         after_removal += "("
      if c == ')' and current_number != 0:
         after_removal += ")"
   if len(after_removal) == 0:
      return "\"\""
   else:
      return after_removal

parenstring = input( "Enter a valid parentheses string!\n" ) 
print( remove_outermost( parenstring ))
