# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge.  This template is a barebones guide to get you started.  Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions
Clone Repository
```console
git clone https://github.com/lewis785/code-test-freeagent.git
``` 

#### Use with Docker
This project was developed using docker, it is the preferred way to use it

Requires `Docker`, `docker-compose`, and `Make` 

```console
# cd into repo
cd code-test-freeagent

# run test
make tests

# generate documentation
make generate_documentation

# access ruby console
make console

# run conversion
CurrencyExchange.rate(Date.new(2020, 1, 1), "GBP", "USD")
```

#### Use without Docker
Requires Ruby and Bundle

```console
# cd into project
cd code-test-freeagent/exchange-rate

# bundle install
bundle install

# run tests
bundle exec ruby test/run_tests.rb

# generate documentation
yard doc --plugin yard-tomdoc

# acces ruby console
bundle exec irb -I lib -r ./lib/currency_exchange.rb

# run conversion
CurrencyExchange.rate(Date.new(2020, 1, 1), "GBP", "USD")
```

#### Documentation
After running `make generate_documentation` documents can be found:
```console
/code-test-freeagent/exchange-rate/doc
```

## Your Design Decisions

#### Environment
##### Docker
The reason I decided to use docker is that it meant that I did not need to install anything onto my machine.
It also means that I can be confident that it will run on any machine that had docker installed.

##### Makefile
I added a makefile to make it simpler to run the few commands required to use the application. It also helps anyone else
who wanted to use the application to run it without having to know long commands off by heart.

##### CI Pipeline
This helps me be confident that the final application I send to you is working, and that I haven't accidently
broken something while refactoring.

#### Application
##### Test Directory
I decided to break the test directory down into two folders `unit` for unit tests, and `functional` for functional tests.
I am not use to writing tests in ruby so I do not know what the correct structure should be, I implemented it this
way to provide a logical structure. I felt `currency_exchange_test.rb` was a functional test so I moved it into
the functional directory.

##### File Converters
I decided to implement file converter so that variable file structures could be converted into a standard format.
This means that we can pass the converted structure around the application without having to add checks for different
data structures.

##### Converter Factory
I decided to implement the convert factory to make it easier move from one file type (csv, xml, json, etc...) to another.
It reduces the time required to implementing a new file type by requiring the creation of a new convert and adding,
it to the case statement. Additionally it means that multiple file types can be supported at the same without any work.

##### BaseConverter
I created this to act like an interface, it provides only one method `convert` and it only raises an exception.
This forces any classes that implement `BaseConverter` to implement the method, this means that all converters will have
the `convert` method. So you are able to return converters from the `ConverterFactory` knowing that they 
have the methods needed.

##### Validator
I had originally planned to have the `Validator` be used before using the `RateCalculator`. However I decided to pass
it into the `RateCalculator` so that every time a rate is calculated it must be validated. This was because I thought
that in the future `RateCalculator` might be used somewhere else and without validation could raise unuseful exceptions.

#### Additional Work
There are a few things that I either realised too late, or did not have time to implement.

* Create a class to contain the converted file hash, that has functionality for retrieving exchange rate values.
 This would move all the functionality for retrieving rates out of the RateCalculator.
 
* Convert the hash keys for currencies to lower case, and implement changing input into lower case. The reason for this
is at the moment the case must exactly match, however different datafiles could have the keys in a different case.
This would improve the flexibility of the application.

* Create a class which takes in the filename and provides methods to get the file type, and read the file.
This would move file reading away from the `Converter` classes meaning all exception handling can be done here.
It would also allow for passing structure object to the `ConverterFactory` instead of a string object.

* Additional functional tests. I would like to have created some smaller functional tests for classes 
like `ConverterFactory` and `RateCalculator`.
