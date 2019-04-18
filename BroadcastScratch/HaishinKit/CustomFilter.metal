#include <metal_stdlib>
using namespace metal;
#include <CoreImage/CoreImage.h>

extern "C" { namespace coreimage {
    // This is just a RGB comparison, but enough for expected.
    float4 chromakey(sampler s, sampler back_s) {
        float4 color = s.sample(s.coord());
        if (color.g > 0.3 && color.r < 0.3 && color.b < 0.3) {
            float4 back_color = back_s.sample(s.coord());
            return back_color;
        } else {
            return color;
        }
    }
    
    float4 monochrome(sampler s) {
        float4 color = s.sample(s.coord());
        float max_color = fmax3(color.r, color.g, color.b);
        return float4(float3(max_color), 1.0f);
    }
}}
