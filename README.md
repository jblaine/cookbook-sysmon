# sysmon

Installs and configures Sysmon, part of the Sysinternals suite.

## Platforms

* Windows 7+, Windows Server 2008+

## Requirements

* The `windows` cookbook

## Attributes

* `default['sysmon']['url']` : A string defining the URL for the Sysmon
  zip file. Defaults to https://download.sysinternals.com/files/Sysmon.zip
* `default['sysmon']['accepteula']` : Default `false`. You must set this to
  `true` in order to acknowledge that you accept the Sysmon EULA.

There are far too many possible configuration options for Sysmon to try to
encapsulate all of them with attributes. Instead, use a configuration file
as described in Usage.

## Recipes

* `default` : Installs and configures Sysmon.

## Usage

Wrap `sysmon::default` with your own cookbook and provide your own Sysmon
configuration file in your cookbook's `files` directory tree as you see
fit. The file must be named `sysmon-config.xml`. A default blank config
file is provided and used by this (sysmon) cookbook.

Though this is a very common pattern, here's an example anyway:

    my-sysmon/
          |
          |------ attributes/
          |            |
          |            |-- default.rb
          |
          |------ files/
          |         |
          |         |-- windows/
          |         |       |
          |         |       |-- sysmon-config.xml
          |         |
          |         |-- host-noodle.example.com
          |                 |
          |                 |-- sysmon-config.xml
          |
          |------ recipes/
          |            |
          |            |-- default.rb

Where `my-sysmon/recipes/attributes/default.rb` may have
`default['sysmon']['accepteula'] = true` (or perhaps you've addressed that
through a different attribute setting location) and
`my-sysmon/recipes/default.rb` has an `include_recipe 'sysmon::default'` at
some point.
