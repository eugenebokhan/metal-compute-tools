#ifndef Definitions_h
#define Definitions_h

#if __METAL_MACOS__ || __METAL_IOS__

#include <metal_stdlib>

using namespace metal;

constant bool deviceSupportsNonuniformThreadgroups [[ function_constant(0) ]];
constant bool deviceDoesntSupportNonuniformThreadgroups = !deviceSupportsNonuniformThreadgroups;
constant float multiplierFC [[ function_constant(1) ]];
constant bool halfSizedCbCr [[ function_constant(2) ]];

// MARK: - Generate Template Kernels

#define generateKernel(functionName, scalarType, outerArgs, innerArgs) \
kernel void functionName##_##scalarType outerArgs {                    \
        functionName innerArgs;                                        \
}

#define generateKernels(functionName)                                        \
generateKernel(functionName, float, outerArguments(float), innerArguments);  \
generateKernel(functionName, half, outerArguments(half), innerArguments);    \
generateKernel(functionName, int, outerArguments(int), innerArguments);      \
generateKernel(functionName, short, outerArguments(short), innerArguments);  \
generateKernel(functionName, uint, outerArguments(uint), innerArguments);    \
generateKernel(functionName, ushort, outerArguments(ushort), innerArguments);

// MARK: - Check Position

#define checkPosition(position, textureSize, deviceSupportsNonuniformThreadgroups) \
if (!deviceSupportsNonuniformThreadgroups) {                                       \
    if (position.x >= textureSize.x || position.y >= textureSize.y) {              \
        return;                                                                    \
    }                                                                              \
}

#endif /* __METAL_MACOS__ || __METAL_IOS__ */

#endif /* Definitions_h */
