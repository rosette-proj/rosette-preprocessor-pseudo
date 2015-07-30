[![Build Status](https://travis-ci.org/rosette-proj/rosette-preprocessor-pseudo.svg)](https://travis-ci.org/rosette-proj/rosette-preprocessor-pseudo) [![Code Climate](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-pseudo/badges/gpa.svg)](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-pseudo) [![Test Coverage](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-pseudo/badges/coverage.svg)](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-pseudo/coverage)

rosette-preprocessor-pseudo
====================

Pseudo-English translation preprocessor for the Rosette internationalization platform.

## Installation

`gem install rosette-preprocessor-pseudo`

Then, somewhere in your project:

```ruby
require 'rosette/preprocessors/pseudo-preprocessor'
```

### Introduction

This library is generally meant to be used with the Rosette internationalization platform that extracts translatable phrases from git repositories. rosette-preprocessor-pseudo is capable of running a simple algorithm over your English phrases that replaces ASCII characters with accented and other non-ASCII characters. Generally this preprocessor should be used for testing purposes.

### Usage with rosette-server

Let's assume you're configuring an instance of [`Rosette::Server`](https://github.com/rosette-proj/rosette-server). Adding pseudo-English pre-processor support would cause your configuration to look something like this:

```ruby
# config.ru
require 'rosette/core'
require 'rosette/serializer/json-serializer'
require 'rosette/extractors/json-extractor'

rosette_config = Rosette.build_config do |config|
  config.add_repo('my_awesome_repo') do |repo_config|
    repo_config.add_serializer('json/key-value') do |serializer_config|
      serializer_config.add_preprocessor('pseudo')
    end
  end
end

server = Rosette::Server::ApiV1.new(rosette_config)
run server
```

For example, pseudo pre-processing will convert `"I'm a little teapot"` into `"[[ì'м à łıттℓê ƭéáƥôт]]"`.

## Requirements

This project must be run under jRuby. It uses [expert](https://github.com/camertron/expert) to manage java dependencies via Maven. Run `bundle exec expert install` in the project root to download and install java dependencies.

## Running Tests

`bundle exec rake` or `bundle exec rspec` should do the trick.

## Authors

* Cameron C. Dutro: http://github.com/camertron
