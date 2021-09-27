#include "../../../MetalComputeToolsSharedTypes/Definitions.h"

kernel void quantizeDistanceField(texture2d<float, access::read> source [[ texture(0) ]],
                                  texture2d<float, access::write> destination [[ texture(1) ]],
                                  constant float& normalizationFactor [[buffer(0)]],
                                  uint2 position [[thread_position_in_grid]]) {
    const uint2 textureSize = {
        destination.get_width(),
        destination.get_height()
    };
    checkPosition(position, textureSize, deviceSupportsNonuniformThreadgroups);

    const float distance = source.read(position).r;
    const float clampDist = fmax(-normalizationFactor, fmin(distance, normalizationFactor));
    const float scaledDist = clampDist / normalizationFactor;
    const float resultValue = ((scaledDist + 1.0f) / 2.0f);
    destination.write(resultValue, position);
}
