perl -MList::Util=uniq -E 'for (100..1000) { say "$_ -> ", $_**2 and last if uniq (split //, $_**2) >= 5}'
