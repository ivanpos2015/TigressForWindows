# TigressForWindows
A set of scripts attempting to make tigress more stable when cross compiling for windows x64. While the result is acceptable, it is a bit messy. I would appreciate 
any insight into dealing with this in a better fashion.
 
## Guideline
This is the coding guideline I follow to produce mostly stable code.

1) Do not use any includes, define the prototypes for any external functions you need in the same file.
2) Avoid using primitive data types, typedef everything to UINT8, etc.

## Stability
Anything not labled here should be assumed as non-notable, and stable.

- [x] Stacked VMs
- [ ] JIT compiler

## Tigress?
https://tigress.wtf/
