import ballerina/lang.regexp;

# Pluralize a word based on the passed in count.
#
# + word - The word to pluralize
# + count - How many of the word exist
# + inclusive - Whether to prefix with the number (e.g. 3 ducks)
# + return - return value
public function pluralize(string word, int count = 2, boolean inclusive = false) returns string|InvalidCount {
    if (count < 2) {
        return error InvalidCount("Count should be greater than 1");
    }
    return (inclusive ? count.toBalString().concat(" ") : "") + plural(word);
}

# Singularize a word based on the passed in count.
#
# + word - The word to singularize
# + return - return value
public function singularize(string word) returns string {
    return singular(word);
}

function plural(string word) returns string {
    return replaceWord(word, IRREGULAR_PLURAL_RULES, IRREGULAR_SINGULAR_RULES, REGULAR_PLURALIZATION_RULES);
}

# Whether the word is plural.
#
# + word - The word to check
# + return - return value
public function isPlural(string word) returns boolean {
    return checkWord(word, IRREGULAR_PLURAL_RULES, IRREGULAR_SINGULAR_RULES, REGULAR_PLURALIZATION_RULES);
}

function singular(string word) returns string {
    return replaceWord(word, IRREGULAR_SINGULAR_RULES, IRREGULAR_PLURAL_RULES, SINGULARIZATION_RULES);
}

# Whether the word is singular.
#
# + word - The word to check
# + return - return value
public function isSingular(string word) returns boolean {
    return checkWord(word, IRREGULAR_SINGULAR_RULES, IRREGULAR_PLURAL_RULES, SINGULARIZATION_RULES);
}

function checkWord(string word, map<string> replaceMap, map<string> keepMap, [regexp:RegExp, CaptureGroup, string][] rules) returns boolean {
    if word.length() == 0 {
        return true;
    }
    string token = word.toLowerAscii();

    if keepMap.hasKey(token) {
        return true;
    }

    if replaceMap.hasKey(token) {
        return false;
    }

    if UNCOUNTABLE_RULES.indexOf(token) !is () {
        return true;
    }

    foreach regexp:RegExp rule in UNCOUNTABLE_RULES_REGEXP {
        if rule.find(word) !is () {
            return true;
        }
    }

    return replaceWordWithRules(token, token, rules) == token;
}

function replaceWord(string word, map<string> replaceMap, map<string> keepMap, [regexp:RegExp, CaptureGroup, string][] rules) returns string {

    if word.length() == 0 {
        return word;
    }

    string token = word.toLowerAscii();

    if keepMap.hasKey(token) {
        return word;
    }

    if replaceMap.hasKey(token) {
        return restoreCase(word, replaceMap[token] ?: "");
    }

    if UNCOUNTABLE_RULES.indexOf(token) !is () {
        return word;
    }

    foreach regexp:RegExp rule in UNCOUNTABLE_RULES_REGEXP {
        if rule.find(word) !is () {
            return word;
        }
    }

    return replaceWordWithRules(word, token, rules);
}

function replaceWordWithRules(string word, string token, [regexp:RegExp, CaptureGroup, string][] rules) returns string {
    foreach [regexp:RegExp, CaptureGroup, string] [rule, capture, postfix] in rules {
        regexp:Groups? matchGroups = rule.findGroups(word);
        if matchGroups is regexp:Groups {
            match capture {
                NO_MATCH => {
                    return restoreCase(word, postfix);
                }
                FULL_MATCH => {
                    return restoreCase(word, rule.replace(word, matchGroups[0].substring().concat(postfix)));
                }
                FIRST_GROUP_MATCH => {
                    return restoreCase(word, rule.replace(word, (<regexp:Span>matchGroups[1]).substring().concat(postfix)));
                }
            }
        }
    }
    return word;
}

function restoreCase(string word, string token) returns string {
    if !tryToRestoreCase {
        return token;
    }

    if word == token {
        return token;
    }

    if word == word.toLowerAscii() {
        return token.toLowerAscii();
    }

    if word == word.toUpperAscii() {
        return token.toUpperAscii();
    }

    if word[0] == word[0].toUpperAscii() {
        return token[0].toUpperAscii().concat(token.substring(1).toLowerAscii());
    }

    return token.toLowerAscii();
}
