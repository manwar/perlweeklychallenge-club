perl -E '$_ = shift; ++$i %2 and say for /(.*?(.))(?!\2)/g' AABBBCDDE
