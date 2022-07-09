#!/bin/zsh

# Compares the output of the test case called $1 (assembly file $1.s, output file correct_output/$1.out)

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cd tst

CORRECT_EXIT_STATUS=$(head -n 1 correct_output/$1.out | awk -F' ' '{print $3}')
./$1 > /dev/null 2>&1
ACTUAL_EXIT_STATUS=$?
diff <(./$1) <(cat correct_output/$1.out | awk '/[[[STDOUT]]]/{flag=1;next}/[[[END]]]/{flag=0}flag')
DIFF_STATUS=$?

if [ $CORRECT_EXIT_STATUS -eq $ACTUAL_EXIT_STATUS ]; then
   if [ $DIFF_STATUS -eq 0 ]; then
       echo "$1: PASS"
       cd $SCRIPT_DIR
       exit 0
   else
       echo "$1: FAIL (wrong output)"
       diff -y <(./$1) <(cat correct_output/$1.out | awk '/[[[STDOUT]]]/{flag=1;next}/[[[END]]]/{flag=0}flag')
   fi
fi

echo "$1: FAIL (wrong exit status)"
cd $SCRIPT_DIR
exit 1

