# ARMv8 Style Guide
by danlliu

## File Naming
All assembly files that are compiled into an object file should follow the `*.s` pattern.

## Indentation
Every line should follow these indentation guidelines:
- Labels are left-aligned to column 0
- The `.` of directives and organizational macros are left-aligned to column 16
- Operands of directives are left-aligned to column 32
- All instructions and instruction-like macros are left-aligned to column 32
- The first operand of instructions is left-aligned to column 48
  - If the operand has a symbol preceding the value (ex. `#` in `#8`, `[` in `[sp]`), the **value** is left-aligned to column 48. (ex. `#` would be placed on column 47)
  - If multiple symbols precede the value (ex. `[\xd]`), the **value** is again left-aligned (ex. `[` would be placed on column 46)
- All following operands are spaced 8 columns away (columns 56, 64, 72, etc.), following the same rules as above
- Trailing comments are aligned to column 96
