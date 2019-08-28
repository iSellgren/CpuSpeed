//
//  factorial.h
//  CpuSpeed
//
//  Created by Fredrik Sellgren on 2019-08-23.
//  Copyright © 2019 Fredrik Sellgren. All rights reserved.
//

#ifndef factorial_h
#define factorial_h

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <IntelPowerGadget/EnergyLib.h>

bool init_c(void);
void destroy(void);
float frequency(void);
float temperature(void);
float power(void);

#endif /* factorial_h */
