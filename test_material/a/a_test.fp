#version 140

in mediump vec2 var_texcoord0;

out vec4 out_fragColor;

uniform mediump sampler2D texture_sampler;
uniform fs_uniforms
{
    mediump vec4 target_color;
};

void main()
{
    mediump vec4 color = texture(texture_sampler, var_texcoord0.xy);
    
    if (color == target_color) {
        color = vec4(1.0, 0.0, 0.0, 1.0);
    }

    out_fragColor = color;
}
