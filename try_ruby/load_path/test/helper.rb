require 'minitest/autorun'

## Sinatra
testdir = File.dirname(__FILE__)
$LOAD_PATH.unshift testdir unless $LOAD_PATH.include?(testdir)

libdir = File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift libdir unless $LOAD_PATH.include?(libdir)

# Reddit thread
# Prefer require to require_relative
# make sure 'lib' is in your load_path: ruby -Ilib bin/script.rb
# Gems automattically add their lib to your load_path
#   - Is there a way to do this with a local gem in development?
#   - Like add the 'lib' to your load path like the gem was installed normally?
#   - But then you run into problems when testing locally? Maybe?

# Helper has this at the top:
# $:.unshift File.expand_path("../../lib", __FILE__)
#
# Test files have this at the top
#require File.expand_path("../helper", __FILE__)
#
# Dry-Validation
# # Put these in your spec helper to load in shared/support files
# Dir[SPEC_ROOT.join('shared/**/*.rb')].each(&method(:require))
# Dir[SPEC_ROOT.join('support/**/*.rb')].each(&method(:require))