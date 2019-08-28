//
//  factorial.c
//  CpuSpeed
//
//  Created by Fredrik Sellgren on 2019-08-23.
//  Copyright © 2019 Fredrik Sellgren. All rights reserved.
//

#include "measurements.h"

bool init_c(void) {
    return IntelEnergyLibInitialize();
}

void destroy(void) {
    IntelEnergyLibShutdown();
}

float frequency(void) {
    StartLog("/tmp/PowerGadgetLog.csv"); // causes a sample to be read
    
    int numMsrs = 0;
    GetNumMsrs(&numMsrs);
    
    for (int i = 0; i < 10; i++) {
            ReadSample();
        
        for (int j = 0; j < numMsrs; j++) {
            int funcID;
            GetMsrFunc(j, &funcID);
            
            int nData;
            double data[3];
            GetPowerData(0, j, data, &nData);
            
            // Frequency
            if (funcID == MSR_FUNC_FREQ) {
                StopLog(); // causes a sample to be read();
                return(data[0]/1000);
            }
        }
    }
   
    return 1;
}

float temperature(void) {
    //IntelEnergyLibInitialize();
    StartLog("/tmp/PowerGadgetLog.csv"); // causes a sample to be read
    
    int numMsrs = 0;
    GetNumMsrs(&numMsrs);
    
    for (int i = 0; i < 10; i++) {
        
        ReadSample();
        
        for (int j = 0; j < numMsrs; j++) {
            int funcID;
            GetMsrFunc(j, &funcID);
            
            int nData;
            double data[3];
            GetPowerData(0, j, data, &nData);
            //temperature
            if (funcID == MSR_FUNC_TEMP) {
                StopLog(); // causes a sample to be read();
                return(data[0]);
            }
        }
    }
    StopLog(); // causes a sample to be read
    return 1;
}

float power(void) {
    //IntelEnergyLibInitialize();
    StartLog("/tmp/PowerGadgetLog.csv"); // causes a sample to be read
    
    int numMsrs = 0;
    GetNumMsrs(&numMsrs);
    
    for (int i = 0; i < 10; i++) {
        ReadSample();
        for (int j = 0; j < numMsrs; j++) {
            int funcID;
            GetMsrFunc(j, &funcID);
            
            int nData;
            double data[3];
            GetPowerData(0, j, data, &nData);
            //power
            if (funcID == MSR_FUNC_POWER) {
                if(data[0] > 0) 
                return(ceilf(data[0]));

            }
        }
    }
    StopLog(); // causes a sample to be read
    return 1;
}
