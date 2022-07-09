#!/bin/zsh

set -Eeuo pipefail
set -x

echo -n "Enter a test name (without .s) > "
read testname
echo -n "\nCreating files tst/$testname.s and tst/correct_output/$testname.out, confirm? (y/n) > "
if read -q "choice"; then
    cp tst/test_template.s tst/${testname}.s
    cp tst/correct_output/test_template.out tst/correct_output/${testname}.out
fi

