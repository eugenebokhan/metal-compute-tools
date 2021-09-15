// swift-tools-version:5.3

import PackageDescription
let package = Package(
    name: "metal-compute-tools",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "MetalComputeTools",
            targets: ["MetalComputeTools"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/eugenebokhan/metal-tools.git",
            .upToNextMajor(from: "1.0.0")
        ),
        .package(
            url: "https://github.com/SwiftGFX/SwiftMath.git",
            .upToNextMajor(from: "3.3.1")
        )
    ],
    targets: [
        .target(
            name: "MetalComputeToolsSharedTypes",
            publicHeadersPath: "."
        ),
        .target(
            name: "MetalComputeTools",
            dependencies: [
                .target(name: "MetalComputeToolsSharedTypes"),
                .product(
                    name: "MetalTools",
                    package: "metal-tools"
                ),
                .product(
                    name: "SwiftMath",
                    package: "SwiftMath"
                )
            ],
            resources: [
                .process("Kernels/BitonicSort/BitonicSort.metal"),
                .process("Kernels/EuclideanDistance/EuclideanDistance.metal"),
                .process("Kernels/LookUpTable/LookUpTable.metal"),
                .process("Kernels/MaskGuidedBlur/MaskGuidedBlur.metal"),
                .process("Kernels/RGBAToYCbCr/RGBAToYCbCr.metal"),
                .process("Kernels/StdMeanNormalization/StdMeanNormalization.metal"),
                .process("Kernels/TextureAddConstant/TextureAddConstant.metal"),
                .process("Kernels/TextureAffineCrop/TextureAffineCrop.metal"),
                .process("Kernels/TextureCopy/TextureCopy.metal"),
                .process("Kernels/TextureDifferenceHighlight/TextureDifferenceHighlight.metal"),
                .process("Kernels/TextureDivideByConstant/TextureDivideByConstant.metal"),
                .process("Kernels/TextureInterpolation/TextureInterpolation.metal"),
                .process("Kernels/TextureMask/TextureMask.metal"),
                .process("Kernels/TextureMaskedMix/TextureMaskedMix.metal"),
                .process("Kernels/TextureMax/TextureMax.metal"),
                .process("Kernels/TextureMean/TextureMean.metal"),
                .process("Kernels/TextureMin/TextureMin.metal"),
                .process("Kernels/TextureMix/TextureMix.metal"),
                .process("Kernels/TextureMultiplyAdd/TextureMultiplyAdd.metal"),
                .process("Kernels/TextureResize/TextureResize.metal"),
                .process("Kernels/TextureWeightedMix/TextureWeightedMix.metal"),
                .process("Kernels/YCbCrToRGBA/YCbCrToRGBA.metal")
            ]
        ),
        .target(name: "MetalComputeToolsTestsResources",
                path: "Tests/MetalComputeToolsTestsResources",
                resources: [.copy("Shared")]),
        .testTarget(name: "MetalComputeToolsTests",
                    dependencies: [
                        .target(name: "MetalComputeTools"),
                        .target(name: "MetalComputeToolsTestsResources")
                    ],
                    resources: [.process("Shaders/Shaders.metal")])
    ]
)
