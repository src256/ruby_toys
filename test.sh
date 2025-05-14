#!/bin/sh

# 以下のように実行  
# ./test.sh test/unit/checker_test.rb
#bundle exec rake test TEST=test/models/entry_test.rb TESTOPTS="--name=test_sample_2"    
#bundle exec rake test TESTOPTS="-v"
bundle exec rake test $*




