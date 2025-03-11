// sinus signal generator

#define n	1000
#define frecventa	500

.extern sin;

.section/dm  data1;

.var/circ    output[n];
.var         frec;
.var         sum;

//frecventa de esantionare 8kHz

.section/pm  IVreset;

jump start;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;

.section/pm program;
start:

i0=output;l0=length(output);m0=1;
si=0;
dm(sum)=si;
si=frecventa;
dm(frec)=si;

cntr=n;
do bucla until ce;

ay0=dm(sum);
si=dm(frec);
sr=ashift si by 3 (hi);
my0=0x4189;
mr=sr1*my0 (rnd);
sr=ashift mr1 by 1 (hi);
ar=sr1+ay0;
dm(sum)=ar;
ax0=ar;
m3=1;l3=0;
call sin;
dm(i0,m0)=ar;
bucla:nop;

stop:jump stop;


