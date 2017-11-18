
#macro Register(pos)
    #local thk_Paper = 0.0002;
    #local rnd_edges = 0.00008;
    #local dist_y = 0.0048;
    union{
        // Papier
        union{
            object{
                Element(0.3195, 0.239, thk_Paper, rnd_edges)
            }
            object{
                Element(0.3195, 0.239, thk_Paper, rnd_edges)
                translate y*(dist_y+thk_Paper)
            }
            object{
                difference {
                    Rounded_Tube_AB(
                        <0,0.5*(dist_y+2*thk_Paper),0>, <0.3195,0.5*(dist_y+2*thk_Paper),0>,
                        0.5*(dist_y+2*thk_Paper), 0.5*(dist_y),
                        rnd_edges, 0)
                    box{<-0.01, -0.01,0>,<0.323+0.01,(dist_y+2*thk_Paper)+0.01,2*(dist_y+2*thk_Paper)>}
                }
            }
            texture { 
                    pigment{ color rgb<0.9,0.8,0.4>*0.8
                    }
                    finish { ambient 0.4 diffuse 0.6 }
            }
        }
        // Aufhaengung
        #local suspension=object{
            difference {
                Element(0.3195+0.028, 0.01, 0.001, 0.0001)
                object{
                    Element(0.008, 0.0065, 0.002, 0.0001)
                    translate x*0.0045-y*0.00005-z*0.001
                }
                object{
                    Element(0.008, 0.0065, 0.002, 0.0001)
                    translate x*(0.3195+0.028-0.008-0.0045)-y*0.00005-z*0.001
                }
            }
            texture { 
                    pigment{ color rgb<1,1,1>*0.4
                    }
                    finish { 
                        ambient 0.4 
                        diffuse 0.6 
                        reflection 0.3
                    }
            }
            translate -x*0.014+z*(0.239-0.0105)
        };
        object{
            suspension
            translate y*0.5*thk_Paper
        }
        object{ 
            suspension
            translate y*(-0.001+thk_Paper*1.5+dist_y)
        }
        // Beschriftung
        object{
            Element(0.06,0.04, 0.002, 0.0005)
            translate x*(0.018+pos*0.057)+z*0.224+y*(-0.001) // (dist_y+2*thk_Paper-0.001)
            pigment { color rgbf<0.9,0.9,0.9,0.85> }
            material{
                interior{
                    ior 1.4
                }
            }
            finish {
                ambient 0.2
                diffuse 0.0
                reflection 0.1
                specular 0.0
                roughness 0.00001
            }
        }
        rotate -x*90
        translate -y*(0.239-0.005)+x*0.005
    }
#end
/*
object{
    Round_Box(<-0.001,0.0,-0.1>,<0.001,0.01,0.1>,0.0009,0)
    texture { 
            pigment{ color rgb<1,1,1>*0.1
            }
            finish { 
                ambient 0.4 
                diffuse 0.6 
                reflection 0.04
            }
    }        
}
object{
    Register()
//     rotate -z*90
//    rotate -z*0
    translate y*0.01
}
 */
