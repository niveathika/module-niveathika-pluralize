import ballerina/test;

[string, string][] pluralDataset = [
    ["them", "they"],
    ["myself", "ourselves"],
    ["yourself", "yourselves"],
    ["themself", "themselves"],
    ["is", "are"],
    ["was", "were"],
    ["has", "have"],
    ["this", "these"],
    ["that", "those"],
    ["echo", "echoes"],
    ["dingo", "dingoes"],
    ["volcano", "volcanoes"],
    ["tornado", "tornadoes"],
    ["torpedo", "torpedoes"],
    ["genus", "genera"],
    ["viscus", "viscera"],
    ["stigma", "stigmata"],
    ["stoma", "stomata"],
    ["dogma", "dogmata"],
    ["lemma", "lemmata"],
    ["schema", "schemata"],
    ["anathema", "anathemata"],
    ["ox", "oxen"],
    ["axe", "axes"],
    ["die", "dice"],
    ["yes", "yeses"],
    ["foot", "feet"],
    ["eave", "eaves"],
    ["goose", "geese"],
    ["tooth", "teeth"],
    ["quiz", "quizzes"],
    ["human", "humans"],
    ["proof", "proofs"],
    ["carve", "carves"],
    ["valve", "valves"],
    ["looey", "looies"],
    ["thief", "thieves"],
    ["groove", "grooves"],
    ["pickaxe", "pickaxes"],
    ["passerby", "passersby"],
    ["quiz", "quizzes"],
    ["ox", "oxen"],
    ["child", "children"],
    ["man", "men"],
    ["tooth", "teeth"],
    ["goose", "geese"],
    ["foot", "feet"],
    ["radius", "radii"],
    ["stimulus", "stimuli"],
    ["syllabus", "syllabi"],
    ["focus", "foci"],
    ["fungus", "fungi"],
    ["cactus", "cacti"],
    ["phenomenon", "phenomena"],
    ["criterion", "criteria"],
    ["datum", "data"],
    ["cherub", "cherubim"],
    ["seraph", "seraphim"],
    ["alumnus", "alumni"],
    ["alga", "algae"],
    ["vertebra", "vertebrae"],
    ["mouse", "mice"],
    ["louse", "lice"],
    ["woman", "women"],
    ["person", "people"],
    ["child", "children"],
    ["titmouse", "titmice"],
    ["child", "children"]
];

[string, string][] pluralDatasetExceptions = [
    ["box", "boxes"],
    ["Octopus", "Octopuses"],
    ["KNIfe", "KNIves"],
    ["loaf", "loaves"],
    ["index", "indices"],
    ["sheep", "sheep"],
    ["matrix", "matrices"],
    ["vertex", "vertices"],
    ["", ""],
    ["bus", "buses"],
    ["Chinese", "Chinese"]
];

[string, string][] singularDataSetException = [
    ["me", "us"],
    ["he", "they"],
    ["she", "they"],
    ["itself", "themselves"],
    ["herself", "themselves"],
    ["himself", "themselves"],
    ["Mouse", "Mice"]
];

function pluralizeDataProvider() returns [string, string][]|error {
    [string, string][] localPluralDataset = pluralDataset.clone();
    localPluralDataset.push(...pluralDatasetExceptions);
    localPluralDataset.push(...singularDataSetException);
    return localPluralDataset;
}

function isPluralDataProvider() returns [string, string][]|error {
    [string, string][] localPluralDataset = pluralDataset.clone();
    localPluralDataset.push(...singularDataSetException);
    return localPluralDataset;
}

function singularizeDataProvider() returns [string, string][]|error {
    [string, string][] localSingularDataset = from var entry in pluralDataset
        select [entry[1], entry[0]];
    from var entry in pluralDatasetExceptions
    do {
        localSingularDataset.push([entry[1], entry[0]]);
    };
    return localSingularDataset;
}

function isSingularDataProvider() returns [string, string][]|error {
    [string, string][] localSingularDataset = from var entry in pluralDataset
        select [entry[1], entry[0]];
    from var entry in singularDataSetException
    do {
        localSingularDataset.push([entry[1], entry[0]]);
    };
    return localSingularDataset;
}

@test:Config
    {
    dataProvider: pluralizeDataProvider
}
function testPluralizeFunction(string input, string expectedPluralizedInput) returns error? {
    string actualPluralizedInput = check pluralize(input);
    test:assertEquals(actualPluralizedInput, expectedPluralizedInput,
            string `Invalid pluralized output for input: ${input}. Expected: ${expectedPluralizedInput}, but found: ${actualPluralizedInput}`);
}

@test:Config
    {
    dataProvider: isPluralDataProvider
}
function testIsPluralFunction(string input, string expectedPluralizedInput) returns error? {
    boolean isPluralWord = isPlural(input);
    test:assertFalse(isPluralWord, string `Invalid isPlural output for input: ${input}. Expected: 'false', but found: 'true'`);

    isPluralWord = isPlural(expectedPluralizedInput);
    test:assertTrue(isPluralWord, string `Invalid isPlural output for input: ${expectedPluralizedInput}. Expected: 'true', but found: 'false'`);
}

@test:Config
    {
    dataProvider: singularizeDataProvider
}
function testSingularizeFunction(string input, string expectedSingularizedInput) returns error? {
    string actualSingularizeInput = singularize(input);
    test:assertEquals(actualSingularizeInput, expectedSingularizedInput,
            string `Invalid singularize output for input: ${input}. Expected: ${expectedSingularizedInput}, but found: ${actualSingularizeInput}`);
}

@test:Config
    {
    dataProvider: isSingularDataProvider
}
function testIsSingleFunction(string input, string expectedSingularizedInput) returns error? {
    boolean isSingleWord = isSingular(input);
    test:assertFalse(isSingleWord, string `Invalid isSingleWord output for input: ${input}. Expected: 'false', but found: 'true'`);

    isSingleWord = isSingular(expectedSingularizedInput);
    test:assertTrue(isSingleWord, string `Invalid isPlural output for input: ${expectedSingularizedInput}. Expected: 'true', but found: 'false'`);
}

