{$R-}{$Q-}{$I-}{$S-}{$E-}{$N+}{$G+}{$A+}
unit Gr;
interface
uses graph;

Procedure SetGraficMode(gm:byte);far;
procedure FLine(x1:integer;y1:byte;x2:integer;y2,color:byte);
procedure fhLine(sx:integer;sy:byte;ex:integer;cc:byte);{horizontal line minimum:2}
procedure FRec(x1:integer;y1:byte;x2:integer;y2,cc:byte); {minimum:2x2}

var adress,adress0,
    color         :word;
    iii:integer;

implementation
{-------------------------------------------------------------------}
procedure fhLine(sx:integer;sy:byte;ex:integer;cc:byte);
begin
 adress:=$A000+20*sy;
 color:=cc+word(cc) shl 8;
 iii:=sx;
 repeat
  memW[adress:iii]:=color;
  inc(iii,2);
 until iii>ex-1;
 if iii-2>ex then mem[adress:ex]:=cc;
end;
{-----------------------------------------------------------------------}
procedure FRec(x1:integer;y1:byte;x2:integer;y2,cc:byte); {minimum:2x2}
begin
 adress:=$A000+20*y1;
 adress0:=$A000+20*y2;
 color:=cc+word(cc) shl 8;
 iii:=x1;
 repeat
   memW[adress :iii]:=color;
   memW[adress0:iii]:=color;
   inc(iii,2)
 until iii>x2-1;
 if iii=x2 then begin
   mem[adress :x2]:=cc;
   mem[adress0:x2]:=cc
 end;

 adress:=320*y1+x1;
 adress0:=320*y1+x2;
 repeat
   inc(adress ,320);
   inc(adress0,320);
   mem[$A000:adress ]:=cc;
   mem[$A000:adress0]:=cc
 until adress=320*(y2-1)+x1
end;
{-------------------BREZENHAM----------------------------------------}
procedure FLine(x1:integer;y1:byte;x2:integer;y2,color:byte);
label m1,m2,m3;
var scrInc1,ScrInc2:integer;

      deltaX,deltaY,NumPixels,
    d,dinc1,dinc2,
    x,xinc1,xinc2,
    y,yinc1,yinc2:integer;
begin
 if x1>x2 then begin
   d:=x1;
   x1:=x2;
   x2:=d
 end;
 if y1>y2 then begin
   d:=y1;
   y1:=y2;
   y2:=d
 end;

 deltaX:=abs(x2-x1);
 deltaY:=abs(y2-y1);
 if deltaX>=deltaY then begin
   numPixels:=deltaX+1;
   d:=deltaY shl 1 - deltax;
   dinc1:=deltaY shl 1;
   dinc2:=(deltaY-deltaX)shl 1;
   xinc1:=1;
   xinc2:=1;
   yinc1:=0;
   yinc2:=1;
 end else begin
   numPixels:=deltaY+1;
   d:=deltaX shl 1 - deltay;
   dinc1:=deltaX shl 1;
   dinc2:=(deltaX-deltaY)shl 1;
   xinc1:=0;
   xinc2:=1;
   yinc1:=1;
   yinc2:=1;
 end;

 adress:=word(y1)*320+x1;
 scrinc1:=yinc1*320+xinc1;
 scrinc2:=yinc2*320+xinc2;

 asm
  push $A000
  pop es
  mov di, adress
  mov dx, d
  mov al, color
  mov cx, numPixels
  mov bx, dinc1

M1:
  mov es:[di], al
  cmp dx, 0
  jnl m2

  add dx,bx
  add di,scrInc1
  jmp m3

M2:
  add dx, dinc2
  add di, ScrInc2

M3:
  loop m1
 end;
end;
{---------------------------------------------------------------}
Procedure SetGraficMode(gm:byte);
var GraphDriver : integer;
    GraphMode   : integer;
    ErrorCode   : integer;
begin
  Graphdriver :=installUserDriver('svga256',nil);
  Graphdriver :=16;
  GraphMode:=gm;
  InitGraph(GraphDriver,GraphMode,'c:\tp7\bgi\');
{  ErrorCode := GraphResult;
  if ErrorCode <> grOk then
    begin
      Writeln ('Graph error: ', GraphErrorMsg(ErrorCode));
      Writeln ('Program halted');
      Halt(1)
    end;}
end;

BEGIN

END.