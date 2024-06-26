# Pluralize Ballerina Connector

[![Build](https://github.com/niveathika/module-niveathika-pluralize/actions/workflows/ci.yml/badge.svg)](https://github.com/niveathika/module-niveathika-pluralize/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/niveathika/module-niveathika-pluralize/branch/main/graph/badge.svg)](https://codecov.io/gh/niveathika/module-niveathika-pluralize)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/niveathika/module-niveathika-pluralize.svg)](https://github.com/niveathika/module-niveathika-pluralize/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/niveathika/module-niveathika-pluralize.svg?label=Open%20Issues)](https://github.com/niveathika/module-niveathika-pluralize/issues)

The `pluralize` Ballerina Connector is designed to assist with the pluralization and singularization of English words. This can be particularly useful when generating dynamic strings based on numerical values.

This module utilizes a predefined list of rules, applied sequentially, to singularize or pluralize a given word. This can be beneficial in many scenarios, such as automating tasks based on user input. For applications where the words are known in advance, a simple ternary (or function) can be used as a lighter alternative.

This module is a migration of the [`pluralize`](https://www.npmjs.com/package/pluralize) library by [`Blake Embrey`](https://github.com/blakeembrey). All credit goes to him.

## Quickstart

To use the `pluralize` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the module

Import the `pluralize` module.

```ballerina
import niveathika/pluralize;
```

### Step 2: Invoke the connector operation

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

### Step 3: Run the Ballerina application

```bash
bal run
```

## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

   * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
   * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To debug package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

5. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

6. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```
