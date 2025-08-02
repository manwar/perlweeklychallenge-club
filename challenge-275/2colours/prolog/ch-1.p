match_collector(Match, [Match.get(0) | Remaining], Remaining).

split_word(String, Words) :- re_foldl(match_collector, "\\S+", String, Words, [], []).

create_matcher(Keys, Matcher) :- format(string(Regex), "^[^~s]+$", [Keys]), Matcher = [Word]>>re_match(Regex/i, Word).
% create_matcher(Keys, Matcher) :- format(string(Regex), "^[^~s]+$", [Keys]), Matcher = re_match(Regex/i). % without the explicit lambda

task1(Sentence, Keys, Nr_Typable_Words) :- split_word(Sentence, Words), create_matcher(Keys, Matcher), include(Matcher, Words, Allowed_Words), length(Allowed_Words, Nr_Typable_Words).
