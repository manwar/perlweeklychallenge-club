OutermostParentheses←{⍵/⍨1<c++\¯1*c←⍵=')'}

⎕←OutermostParentheses '()()()'
⎕←OutermostParentheses '(((())))'
⎕←OutermostParentheses '(()())(())'
⎕←OutermostParentheses '()((()))()'
⎕←OutermostParentheses '(()(()))(()())'
