#!/usr/bin/env awk

function special_notes(source, target) {
    split(source, source_split, //);
    split(target, target_split, //);
    for (i in source_split) {
        source_dict[source_split[i]]++;
    }
    for (i in target_split) {
        target_dict[target_split[i]]++;
    }
    for (i in target_dict) {
        if (source_dict[i] < target_dict[i]) {
            delete source_split;
            delete source_dict;
            delete target_split;
            delete target_dict;
            return 0;
        }
    }
    return 1;
}

function works_for(source, target, success) {
    if (success) {
        print "Works for source = " source ", and target = " target;
    } else {
        print "Does not work for source = " source ", and target = " target;
    }
}

END {
    works_for("abc", "xyz", !special_notes("abc", "xyz"));
    works_for("scriptinglanguage", "perl", special_notes("scriptinglanguage", "perl"));
    works_for("aabbcc", "abc", special_notes("aabbcc", "abc"));
}
