#include <graphics.h>
#include <math.h>
#include <bios.h>
#include <stdio.h>
#include <conio.h>
#include <alloc.h>
#include <stdlib.h>
#include "defs.h"

long
double lq,cq,rq,cc,c0,qq,q0,
       wq,w0,dw,w[310],fq,f0,df,aq,a0,
       mz[310],fz[310],rs[310],xs[310],rp[310],xp[310],
       aq2,a02,aq0,zcc,twopi,sc;

int    i,j,k,l,mode,n,o,y[7][310];

void calc (void);
int change (void);
void grid (void);
void image (void);
void lop (void);

void main ()
{ int gdriver = DETECT, gmode, errorcode;

  twopi=6.283185;

  lq=5.e-1; cq=5.e-15; rq=100; cc=1e-11;
  n=60; sc=rq; o=0; mode=F2;

  nq: c0=cq*cc/(cq+cc); wq=1/sqrt(lq*cq); w0=1/sqrt(lq*c0);
  fq=wq/twopi; f0=w0/twopi; qq=sqrt(lq/cq)/rq; q0=sqrt(lq/c0)/rq;

  lf: dw=(w0-wq)/n; df=dw/twopi;
  lo: switch (o)
      { case 0: w[0]=wq-120*dw; break;
	case 1: w[0]=w0-180*dw; break;
      }
  lm: for (i=1;i<301;i++) w[i]=w[i-1]+dw;

  lsc: lop(); calc();
  initgraph(&gdriver, &gmode, ""); setcolor(WHITE); image();

  label: l=bioskey(0);
  nl: switch (l)
  { case  F1: closegraph(); lop(); l=bioskey(0);
	      initgraph(&gdriver, &gmode, ""); goto nl;
    case  F2: mode=l; image(); break;
    case  F3: mode=l; image(); break;
    case  F4: mode=l; image(); break;
    case  F5: if (n>60) n=n/2; closegraph(); goto lf;
    case  F6: n=2*n; closegraph(); goto lf;
    case  F7: sc=sc/2; closegraph(); goto lsc;
    case  F8: sc=2*sc; closegraph(); goto lsc;
    case  F9: o=1-o; closegraph(); goto lo;
    case F10: goto out;
    case Esc: l=mode; goto nl;
    case Ins: if (change()==0) goto nq; else { l=bioskey(0);
	      initgraph(&gdriver, &gmode, ""); goto nl; }
  }
  goto label;
  out: l=l;
}

void calc (void)
{ for (i=0;i<301;i++)
  { aq=qq*(w[i]/wq-wq/w[i]); a0=q0*(w[i]/w0-w0/w[i]);
    aq2=1+aq*aq; a02=1+a0*a0; aq0=1+aq*a0; zcc=1/(w[i]*cc);
    mz[i]=zcc*sqrt(aq2)/sqrt(a02);
    rs[i]=zcc*(aq-a0)/a02; xs[i]=-zcc*aq0/a02;
    fz[i]=atan2(xs[i],rs[i]);
    rp[i]=zcc*aq2/(aq-a0); xp[i]=-zcc*aq2/aq0;
    y[0][i]=150-(int)floor(mz[i]/sc+.5); y[1][i]=150-(int)floor(400*fz[i]/twopi+.5);
    y[2][i]=150-(int)floor(rs[i]/sc+.5); y[3][i]=150-(int)floor(xs[i]/sc+.5);
    y[4][i]=150-(int)floor(rp[i]/sc+.5); y[5][i]=150-(int)floor(xp[i]/sc+.5);
    gotoxy (41,20); cprintf ("i = %u",i);
  }
}

int change (void)
{ char buf[13],cv[13],nv[]="Input new value:";
  closegraph(); lop();
  gotoxy (41,16); cprintf ("Input the value's name");
  gotoxy (41,17); cprintf ("to change: ");
  cscanf ("%s",cv); gotoxy (41,19);
  if ( strcmp(cv,"lq")==0 )
  { cprintf ("%s %2s [Hn] = ",nv,cv); gets(buf); lq=atof(buf); return 0; }
  if ( strcmp(cv,"cq")==0 )
  { cprintf ("%s %2s [F] = ",nv,cv); gets(buf); cq=atof(buf); return 0; }
  if ( strcmp(cv,"rq")==0 )
  { cprintf ("%s %2s [Ohm] = ",nv,cv); gets(buf); rq=atof(buf); return 0; }
  if ( strcmp(cv,"cc")==0 )
  { cprintf ("%s %2s [F] = ",nv,cv); gets(buf); cc=atof(buf); return 0; }
  cprintf ("I can't change \"%s\"!?",cv); return 1;
}

void grid (void)
{ line (0,0,300,0); line (320,0,620,0);
  line (0,50,300,50); line (320,50,620,50);
  line (0,100,300,100); line (320,100,620,100);
  line (0,150,300,150); line (320,150,620,150);
  line (320,200,620,200); line (320,250,620,250);
  line (320,300,620,300);
  line (0,0,0,150); line (60,0,60,150); line (120,0,120,150);
  line (180,0,180,150); line (240,0,240,150); line (300,0,300,150);
  line (320,0,320,300); line (380,0,380,300); line (440,0,440,300);
  line (500,0,500,300); line (560,0,560,300); line (620,0,620,300);
}

void image(void)
{ char buf[12]; cleardevice(); grid();
  for (j=0;j<=300;j++)
  { switch (mode)
    { case F2: putpixel(j,y[0][j],WHITE); putpixel(j+320,y[1][j],WHITE); break;
      case F3: putpixel(j,y[2][j],WHITE); putpixel(j+320,y[3][j],WHITE); break;
      case F4: putpixel(j,y[4][j],WHITE); putpixel(j+320,y[5][j],WHITE); break;
    }
  }
  switch (mode)
  { case F2: outtextxy(0,220,"Module & Phase"); break;
    case F3: outtextxy(0,220,"Sequential"); break;
    case F4: outtextxy(0,220,"Parallel"); break;
  }
  switch (o)
  { case 0: outtextxy(0,236,"f[120] = fq"); break;
    case 1: outtextxy(0,236,"f[180] = f0"); break;
  }
  outtextxy(0,252,"OX: n ="); outtextxy(64,252,gcvt(n,6,buf));
  outtextxy(0,268,"OY: sc ="); outtextxy(72,268,gcvt(sc/rq,6,buf));
  outtextxy(0,292,"Help & Values: F1");
}

void lop(void)
{ clrscr();

  gotoxy(41, 1); cprintf(" F1  Help & Values");
  gotoxy(41, 2); cprintf(" F2  Module & Phase");
  gotoxy(41, 3); cprintf(" F3  Sequential");
  gotoxy(41, 4); cprintf(" F4  Parallel");
  gotoxy(41, 5); cprintf(" F5  OX: n = n/2");
  gotoxy(41, 6); cprintf(" F6  OX: n = 2*n");
  gotoxy(41, 7); cprintf(" F7  OY: sc = sc/2");
  gotoxy(41, 8); cprintf(" F8  OY: sc = 2*sc");
  gotoxy(41, 9); cprintf(" F9  f[120]=fq / f[180]=f0 (toggle)");
  gotoxy(41,10); cprintf("F10  Exit");
  gotoxy(41,11); cprintf("Esc  Return to Graphics");
  gotoxy(41,12); cprintf("Ins  To change a parameter");

  switch (o)
  { case 0: gotoxy(41,23); cprintf("f[120] = fq"); break;
    case 1: gotoxy(41,23); cprintf("f[180] = f0"); break;
  }
  gotoxy(41,24); cprintf("OX: n = %.u",n);
  gotoxy(41,25); cprintf("OY: sc = %.Lg",sc/rq);

  gotoxy( 1, 1); cprintf("lq = %.3Lg",lq);
  gotoxy( 1, 2); cprintf("cq = %.3Lg",cq);
  gotoxy( 1, 3); cprintf("rq = %.3Lg",rq);
  gotoxy( 1, 4); cprintf("cc = %.3Lg",cc);
  gotoxy( 1, 5); cprintf("fq = %.8Lg",fq);
  gotoxy( 1, 6); cprintf("f0 = %.8Lg",f0);
  gotoxy( 1, 7); cprintf("df = %.3Lg",df);
  gotoxy( 1, 8); cprintf("qq = %.6Lg",qq);
  gotoxy( 1, 9); cprintf("q0 = %.6Lg",q0);

  gotoxy( 1,11); cprintf("w[120]/twopi = %.8Lg",w[120]/twopi);
  gotoxy( 1,12); cprintf("mz[120] = %.5Lg",mz[120]);
  gotoxy( 1,13); cprintf("fz[120] = %.5Lg",fz[120]);
  gotoxy( 1,14); cprintf("rs[120] = %.5Lg",rs[120]);
  gotoxy( 1,15); cprintf("xs[120] = %.5Lg",xs[120]);
  gotoxy( 1,16); cprintf("rp[120] = %.5Lg",rp[120]);
  gotoxy( 1,17); cprintf("xp[120] = %.5Lg",xp[120]);

  gotoxy( 1,19); cprintf("w[180]/twopi = %.8Lg",w[180]/twopi);
  gotoxy( 1,20); cprintf("mz[180] = %.5Lg",mz[180]);
  gotoxy( 1,21); cprintf("fz[180] = %.5Lg",fz[180]);
  gotoxy( 1,22); cprintf("rs[180] = %.5Lg",rs[180]);
  gotoxy( 1,23); cprintf("xs[180] = %.5Lg",xs[180]);
  gotoxy( 1,24); cprintf("rp[180] = %.5Lg",rp[180]);
  gotoxy( 1,25); cprintf("xp[180] = %.5Lg",xp[180]);
}