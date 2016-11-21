float smoothbump(float center, float width, float x) {
  float w2 = width/2.0;
  float cp = center+w2;
  float cm = center-w2;
  float c = smoothstep(cm, center, x) * (1.0-smoothstep(center, cp, x));
  return c;
}

void main(void)
{
    vec2  uv     = gl_FragCoord.xy/iResolution.xy;
    uv.y         = 1.0 - uv.y; // +Y is now "up"
    float freq   = 0.25*texture2D(iChannel0,vec2(uv.x,0.25)).x;
    float wave   = texture2D(iChannel0,vec2(uv.x,0.75)).x;
    float freqc  = smoothstep(0.0,(12.0/iResolution.y), freq + uv.y - 0.95);
    float wavec  = smoothbump(0.0,(14.0/iResolution.y), wave + uv.y - 0.5);
    gl_FragColor = vec4(freqc, wavec, 0.25,1.0);
}

/* void main() */
/* { */
/*     // create pixel coordinates */
/*   vec2  uv     = gl_FragCoord.xy/iResolution.xy; */
/*   uv.y         = 0.5 - uv.y; // +Y is now "up" */

/* 	// first texture row is frequency data */
/* 	float fft  = texture2D( iChannel0, vec2(uv.x,0.25) ).x; */ 
	
/*     // second texture row is the sound wave */
/* 	float wave = texture2D( iChannel0, vec2(uv.x,0.75) ).x; */
	
/* 	// convert frequency to colors */
/* 	vec3 col = vec3( fft, 0.0*fft*(0.5-fft), 0.5-fft ) * fft; */

/*     // add wave form on top */	
/*   col += 1.0 -  smoothstep( 0.0, 0.01, abs(wave - uv.y) ); */
	
/* 	// output final color */
/* 	gl_FragColor = vec4(col,1.0); */
/* } */
