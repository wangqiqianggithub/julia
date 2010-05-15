echo "# This file is autogenerated using gen_mathfunctions.sh"

echo "libm = dlopen(\"libm\")"
echo

for func in sin cos tan sinh cosh tanh asin acos atan log log2 log10 log1p logb exp exp2 expm1 erf erfc sqrt cbrt ceil floor nearbyint round rint trunc; do
    echo "# $func"
    echo "$func(x::Float64) = ccall(dlsym(libm,\"$func\"), Float64, (Float64,), x)"
    echo "$func(x::Float32) = ccall(dlsym(libm,\"${func}f\"), Float32, (Float32,), x)"
    echo "$func(x::Vector) = [ $func(x[i]) | i=1:length(x) ]"
    echo "$func(x::Matrix) = [ $func(x[i,j]) | i=1:size(x,1), j=1:size(x,2) ]"
    echo
done

echo "# abs"
echo "abs(x::Float64) = ccall(dlsym(libm,\"fabs\"), Float64, (Float64,), x)"
echo "abs(x::Float32) = ccall(dlsym(libm,\"fabsf\"), Float32, (Float32,), x)"
echo "abs(x::Vector) = [ abs(x[i]) | i=1:length(x) ]"
echo "abs(x::Matrix) = [ abs(x[i,j]) | i=1:size(x,1), j=1:size(x,2) ]"
echo

echo "# ldexp"
echo "ldexp(x::Float64,e::Int32) = ccall(dlsym(libm,\"ldexp\"), Float64, (Float64,Int32), x, e)"
echo "ldexp(x::Float32,e::Int32) = ccall(dlsym(libm,\"ldexpf\"), Float32, (Float32,Int32), x, e)"
echo

for func in atan2 pow remainder fmod copysign hypot fmin fmax fdim; do
    echo "# $func"
    echo "$func(x::Float64, y::Float64) = ccall(dlsym(libm,\"$func\"), Float64, (Float64, Float64,), x, y)"
    echo "$func(x::Float32, y::Float32) = ccall(dlsym(libm,\"${func}f\"), Float32, (Float32, Float32), x, y)"
    echo
done

for func in isinf isnan; do
    echo "# $func"
    echo "$func(x::Float64) = ccall(dlsym(libm,\"$func\"), Int32, (Float64,), x)!=0"
    echo "$func(x::Float32) = ccall(dlsym(libm,\"${func}f\"), Int32, (Float32,), x)!=0"
    echo "$func(x::Vector) = [ $func(x[i]) | i=1:length(x) ]"
    echo "$func(x::Matrix) = [ $func(x[i,j]) | i=1:size(x,1), j=1:size(x,2) ]"
    echo
done

for func in lrint lround ilogb; do
    echo "# $func"
    echo "$func(x::Float64) = ccall(dlsym(libm,\"$func\"), Int32, (Float64,), x)"
    echo "$func(x::Float32) = ccall(dlsym(libm,\"${func}f\"), Int32, (Float32,), x)"
    echo "$func(x::Vector) = [ $func(x[i]) | i=1:length(x) ]"
    echo "$func(x::Matrix) = [ $func(x[i,j]) | i=1:size(x,1), j=1:size(x,2) ]"
    echo
done

echo "# rand"
echo "rand() = ccall(dlsym(JuliaDLHandle,\"rand_double\"), Float64, ())"
echo "randf() = ccall(dlsym(JuliaDLHandle,\"rand_float\"), Float32, ())"
echo "randint() = ccall(dlsym(JuliaDLHandle,\"genrand_int32\"), Uint32, ())"
echo

