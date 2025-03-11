//Sin_Approximation;

/*
        Sine Approximation
                Y = Sin(x)

        Calling Parameters
                AX0 = x in scaled 1.15 format 
                M3 = 1
                L3 = 0

        Return Values
                AR = y in 1.15 format

        Altered Registers
                AY0,AF,AR,MY1,MX1,MF,MR,SR,I3

        Computation Time
                25 cycles

*/

.section/dm  data1;

.var sin_coeff[5]={0x3240,0x0053, 0xAACC, 0x08B7, 0x1CCE};


.section/pm program;
.global sin;

sin:    I3=sin_coeff;                          // Pointer to coeff. buffer
        AY0=0x4000;
        AR=AX0, AF=AX0 AND AY0;                // Check 2nd or 4th quad.
        IF NE AR=-AX0;                         // If yes, negate input
        AY0=0x7FFF;
        AR=AR AND AY0;                         // Remove sign bit
        MY1=AR;
        MF=AR*MY1 (RND), MX1=DM(I3,M3);        // MF = x**2
        MR=MX1*MY1 (SS), MX1=DM(I3,M3);        // MR = C1*x
        CNTR=3;
        DO approx UNTIL CE;
                MR=MR+MX1*MF (SS);
approx:         MF=AR*MF (RND), MX1=DM(I3,M3);
        MR=MR+MX1*MF (SS);
        SR=ASHIFT MR1 BY 3 (HI);
        SR=SR OR LSHIFT MR0 BY 3 (LO);         // Convert to 1.15 format
        AR=PASS SR1;
        IF LT AR=PASS AY0;                     // Saturate if needed
        AF=PASS AX0;
        IF LT AR=-AR;                          // Negate output if needed
        RTS;

