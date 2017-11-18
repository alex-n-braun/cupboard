

#declare test_object = object {
    #local test_val = 0.1;
    box{<0,0,0>,<1,1,1>}
};

#warning str(test_object.test_val,1,1)