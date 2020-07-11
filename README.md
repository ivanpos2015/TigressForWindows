# TigressForWindows
A set of scripts attempting to make tigress more stable when cross compiling for windows x64.
 
## Guideline
### GCC
This is the coding guideline I follow to produce mostly stable code.

1) Do not use any includes, define the prototypes for any external functions you need in the same file.
2) Avoid using primitive data types, typedef everything to UINT8, etc.

### Clang

1) Do not use any includes, define the prototypes for any external functions you need in the same file.

## Stability
Everything is stable in clang, GCC not so much.

## Tigress?
https://tigress.wtf/
