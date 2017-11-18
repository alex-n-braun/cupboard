
#declare f_reflective_metal = finish {
 ambient .2 diffuse .2
 specular 1.5 roughness .02 brilliance 2
 reflection { .6 metallic 1 } metallic
}
#declare f_metal_shiny = f_reflective_metal

// basic shiny metal
#declare t_shiny_metal =
texture {
 pigment { rgb .8 }
 finish { f_metal_shiny }
}

/* straight from warp's method from the povray FAQ */
#local BlurAmount = .2; // Amount of blurring
#local BlurSamples = 10*4; // How many rays to shoot

#declare t_metal_glossy_warp =
  texture
  { average texture_map
    { #local Ind = 0;
      #local S = seed(0);
      #while(Ind < BlurSamples)
        [1 // The pigment of the object:
           pigment { rgb .7 }
           // The surface finish:
           finish { f_metal_shiny }
           // This is the actual trick:
           normal
           { bumps BlurAmount
             translate <rand(S),rand(S),rand(S)>*10 //200
             scale 1000
           }
        ]
        #declare Ind = Ind+1;
      #end
    }
  }

#declare t_metal_glossy_warp_lesser =
  texture
  { average texture_map
    { #local Ind = 0;
      #local S = seed(0);
      #while(Ind < BlurSamples)
        [1 // The pigment of the object:
           pigment { rgb .7 }
           // The surface finish:
           finish { f_metal_shiny }
           // This is the actual trick:
           normal
           { bumps BlurAmount
             translate <rand(S),rand(S),rand(S)>*10/200
             scale 1000
           }
        ]
        #declare Ind = Ind+1;
      #end
    }
  }

// *************************
// *** Jaime Vives Piqueres' micronormals ***
// *************************
// + microsurface normal
#local p_jvp_micro2=
pigment{
 crackle turbulence 1
 color_map{
  [0.00 rgb .7]
  [0.01 rgb .7]
  [0.02 rgb 1]
  [1.00 rgb 1]
 }
 scale 5
}
#local p_jvp_micro1=
pigment{
 cells
 turbulence .5
 color_map{
  [0.0 rgb .9]
  [1.0 rgb 1]
 }
 scale .01
}
// + average all the normals
#local p_jvp_brushed_new=
pigment{
 average turbulence 0
 pigment_map{
  [0.0 p_jvp_micro1]
  [0.1 p_jvp_micro1 rotate 45*x]
  [0.2 p_jvp_micro1 rotate -45*x]
  [0.3 p_jvp_micro2]
  [0.4 p_jvp_micro1 rotate 45*y]
  [0.5 p_jvp_micro1 rotate -45*y]
  [0.6 p_jvp_micro1 rotate 90*z]
  [0.7 p_jvp_micro2 rotate 45]
  [0.8 p_jvp_micro1 rotate 45*z]
  [0.9 p_jvp_micro1 rotate 90*y]
  [1.0 p_jvp_micro1 rotate -45*z]
 }
 scale .1
}

#declare n_jvp_micronormals = normal { pigment_pattern{p_jvp_brushed_new} .4
}
#declare t_jvp_micronormal_glossy_metal = texture {
 pigment { rgb .7 }
 normal { n_jvp_micronormals scale .5 }
 finish { f_reflective_metal }
}
#declare t_metal_glossy_jvp = t_jvp_micronormal_glossy_metal


/**
 * a mix of warp's method and Jaime Vives Piqueres micronormals.
 * But with a completely unrelated and surprising pattern...
**/
#macro m_metal_glossy( BlurAmount, BlurSamples )
texture { average
 texture_map {
  #local Ind = 0;
  #local S = seed(0);
  #while(Ind < BlurSamples)
   [1 // The pigment of the object:
      pigment { rgb .78 }
      // The surface finish:
      finish { f_reflective_metal }
      // This is the actual trick:
      normal { wood ramp_wave
    rotate rand(S)*30 turbulence .6
    bump_size -BlurAmount
        translate <rand(S),rand(S),rand(S)>*.02
        scale .002
        //scale 1000
      }
   ]
   #declare Ind = Ind+1;
  #end
 }
}
#end

#declare t_glossy_brushed_metal = m_metal_glossy( .2, 1*4 )
#declare t_metal_brushed_glossy = t_glossy_brushed_metal
#declare t_metal_glossy = t_glossy_brushed_metal
#declare t_metal_glossy_weak = m_metal_glossy( .1, 1*4 )


// test scene
/*
camera { location -5*z look_at y+2*x rotate <20,0,0> angle 40 }

light_source { 4-8*z 1.3 }
light_source { 4-6*x 1.3 }

plane { y, 0 pigment { checker rgb 1 rgb 0 } finish { ambient .3 diffuse .4
} }

sphere { y-7*z, 1 rotate -y*40
 pigment { rgb y }
 finish { ambient 0 diffuse .6 phong .7 brilliance .5 }
}*/

// #local n0 = normal { facets coords .04 bump_size .9 turbulence .0 scale
// 9*(z+x) scale .04 }

// box { -.5,.5 rotate y*20 translate .5*y+1.3*x scale 2 rotate -y*20
//         //texture { t_shiny_metal }
//         texture { t_metal_glossy_warp }
//         //texture { t_metal_glossy_warp_lesser }
//         //texture { t_metal_glossy }
//         //texture { t_metal_glossy_weak }
//         //texture { t_metal_glossy_jvp scale .04 }
// }
//  
