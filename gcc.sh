export TIGRESS_HOME=~/Desktop/tigress-unstable;
CIL_MACHINE="short=2,8 int=4,8 long=8,8 long_long=8,8 pointer=8,8 \
             alignof_enum=8 float=4,8 double=8,8 long_double=16,16 \
             void=1 bool=1,1 fun=1,1 alignof_string=1 max_alignment=16 \
             size_t=unsigned_long wchar_t=int char_signed=true \
             const_string_literals=true big_endian=false \
             __thread_is_keyword=true __builtin_va_list=true \
             underscore_name=true"; export CIL_MACHINE;

./tigress --Environment=x86_64:Windows:Gcc:4.6 \
      --gcc=x86_64-w64-mingw32-gcc \
      --envmachine \
      --Transform=Virtualize \
         --VirtualizeAddOpaqueToVPC=true \
         --VirtualizeBogusLoopKinds=* \
         --VirtualizeEncodeByteArray=true \
         --VirtualizeObfuscateDecodeByteArray=true \
         --Functions=Main \
      --Transform=Virtualize \
         --Functions=Main \
      --out=App_Protected.c App.c 

# tigress inserts main no matter what, but we're compiling to a lib..
sed -i 's/main(/mainx(/g' App_Protected.c

# tigress uses a movq if obfuscating branch instructions, which is invalid..
sed -i 's/movq /mov /g' App_Protected.c

# tigress expects longs to be 64 bit because of linux..
# DO NOT USE 32 BIT LONGS IN YOUR CODE, DEFINE THEM AS INTEGERS
sed -i 's/long _long ;/long long _long ;/g' App_Protected.c
sed -i 's/unsigned long _unsigned_long ;/unsigned long long _unsigned_long ;/g' App_Protected.c
sed -i 's/(unsigned long *)/(unsigned long long *)/g' App_Protected.c
sed -i 's/(long *)/(long long *)/g' App_Protected.c
sed -i 's/  unsigned long control/  unsigned long long control/g' App_Protected.c
sed -i 's/  unsigned long min/  unsigned long long min/g' App_Protected.c
sed -i 's/  unsigned long max/  unsigned long long max/g' App_Protected.c

# we have to compile it ourself
echo "Compiling"
x86_64-w64-mingw32-gcc -c App_Protected.c -o App.o

# and convert it for MSVC linking
ar rcs App.lib App.o
