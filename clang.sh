export TIGRESS_HOME=~/Desktop/tigress-unstable;

./tigress --Environment=x86_64:Darwin:Clang:5.1 \
      --gcc="clang" \
      --Transform=Virtualize \
         --Functions=Main \
      --Transform=Jit \
         --Functions=Main \
      --out=App_Protected.c App.c 

# tigress inserts main no matter what, but we're compiling to a lib..
sed -i 's/main(/mainx(/g' App_Protected.c

# we have to compile it ourself
echo "Compiling"

# first we have to convert it to LLVM IR, to bypass LLP64 ABI
clang -O0 -S -emit-llvm App_Protected.c -o App.ll

# then we have to convert it to assembly
llc -mtriple=x86_64-pc-win32 App.ll

# finally, we can make our object
clang -O0 -target x86_64-pc-win32 -c App.s -o App.o

# create the library
llvm-lib /machine:X64 App.o
