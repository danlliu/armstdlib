# Test Cases

Along with the standard library, this repository provides a large suite of test cases in the [tst](/tst) directory.

## Test Case Formatting

Test cases should follow the style guidelines outlined in [STYLE.MD](STYLE.MD).

## Test Case Output Formatting

Test case outputs are specified in the [tst/correct_output](tst/correct_output) directory. For output checking to take place successfully, the test case output file should be in the following format. Text enclosed by `<>` should be replaced by program-specific output.

```
[[[EXIT STATUS]]] <exit status>
[[[STDOUT]]]
<stdout>
[[[END]]]
```

Note that this does **not** check the contents of files! Maybe I'll update this in the future.

