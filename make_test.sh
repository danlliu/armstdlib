#!/bin/zsh

echo -n "Enter a test name (without .s) > "
read testname
echo -n "\nExisting test cases:\n"
ls tst/*.s
if [[ -f tst/$testname.s || -f tst/correct_output/$testname.out ]]; then
    echo -n "\nFiles tst/$testname.s and/or tst/correct_output/$testname.out already exist! Do you want to overwrite them? (y/n) > "
else
    echo -n "\nCreating files tst/$testname.s and tst/correct_output/$testname.out, confirm? (y/n) > "
fi
if read -q "choice"; then
    cp tst/test_template.s tst/${testname}.s
    cp tst/correct_output/test_template.out tst/correct_output/${testname}.out
fi

