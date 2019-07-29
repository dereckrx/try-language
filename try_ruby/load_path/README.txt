## Tue May 28 2019 9:56 PM

So many require options. 
Generally avoid require relative
Everything should be on the LOAD_PATH, then you can use require.

However, this makes it more difficult to run test from intellij.
Can't find the helper file for example because the -Ilib:test 
has not been added to the command.

Test 0:
rake test
Works great if lib and test dirs are added

Test 1:
Can I run tests in intellij if I use a template with -Ilib:test
no because the curr dir is now in the test dir so -Ilib:test is not relative
but that can be fixed by changing your working-dir in the template to the project root

Test 2: 
Can I run tests from the command line? Yes
$ bundle exec ruby -Ilib:test test/foo/bar_test.rb

## Scenario 2
What if we manipulate the load path from test files directly?

In helper file:
testdir = File.dirname(__FILE__)
$LOAD_PATH.unshift testdir unless $LOAD_PATH.include?(testdir)

libdir = File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift libdir unless $LOAD_PATH.include?(libdir)

In test files:
require File.expand_path('../../helper', __FILE__)

Test 0: 
rake test
Works, probably because rake is auto -Ilib dir

Test 1: 
Running from IntelliJ
Wow, yes, works fine with no adjustments to the run configuration needed

Test 2:
Command line
Works like a charm with no extra -Ilib:test
