## Overview

The `pluralize` Ballerina Connector is designed to assist with the pluralization and singularization of English words. This can be particularly useful when generating dynamic strings based on numerical values.

This module utilizes a predefined list of rules, applied sequentially, to singularize or pluralize a given word. This can be beneficial in many scenarios, such as automating tasks based on user input. For applications where the words are known in advance, a simple ternary (or function) can be used as a lighter alternative.

This module is a migration of the [`pluralize`](https://www.npmjs.com/package/pluralize) library by [`Blake Embrey`](https://github.com/blakeembrey). All credit goes to him.

### Quickstart

To use the `pluralize` connector in your Ballerina application, modify the `.bal` file as follows:

#### Step 1: Import the module

Import the `pluralize` module.

```ballerina
import niveathika/pluralize;
```

#### Step 2: Invoke the connector operation

Now, utilize the available connector operations.

```ballerina
pluralize:pluralize('test'); //=> "tests"
pluralize:pluralize('test', 0); //=> "tests"
pluralize:pluralize('test', 1); //=> "test"
pluralize:pluralize('test', 5); //=> "tests"
pluralize:pluralize('test', 1, true); //=> "1 test"
pluralize:pluralize('test', 5, true); //=> "5 tests"
pluralize:pluralize('蘋果', 2, true); //=> "2 蘋果"

pluralize:isPlural("test"); // false
pluralize:isPlural("tests"); // true
```

#### Step 3: Run the Ballerina application

```bash
bal run
```
