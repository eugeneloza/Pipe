{$R+}{$Q-}{$S-}
Program Piper;
Uses Crt,Graph,Gr;

const f10  =#68;
const UpL  =#71;
const Up   =#72;
const UpR  =#73;
const Left =#75;
const Right=#77;
const DownL=#79;
const Down =#80;
const DownR=#81;
const enter=#13;

const max=11;{max=15,min=5(maxLot=5)}
      speed=2;
      maxLot=7;
      BuildSpeed=5;
      BuildTime=111;
      flowTime=30;
      income=10;
      cost=3;
{      blockTypes=51;}

type MapArray1=array[1..max,1..max] of byte;
     MapArray2=array[1..max,1..max] of boolean;

var Map,con,con1:mapArray1;
    r:mapArray1;
    b:array[1..7] of byte;
    x,y,lx,ly:byte;

    lot:array[1..maxLot] of Byte;

    x1,y1,x2,y2,x3,y3,x4,y4:integer;

    Fx,Fy,Fc,Fm:byte;
    Fdx,Fdy:shortInt;

    score,money:word;
    bonus:byte;

    fast:boolean;
    game:boolean;

    moves:integer;

    str1,str2:string;
    oMx,oMy:shortInt;

    i,j,k,l:integer;
    flg:boolean;

    key,key1:char;

{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
procedure DrawBlock(xx,yy:byte);
var rr,c0,c1,color,color1:byte;
begin
{*} x1:=trunc((470/max)*(xx-1));
    y1:=trunc((470/max)*(yy-1));
    x2:=trunc((470/max)*xx-1);
    y2:=trunc((470/max)*yy-1);

    if xx=max+2 then begin
      l:=lot[maxLot-yy+1];
      rr:=2;
      c1:=0;
    end
    else begin
      l:=map[xx,yy];
      rr:=r[xx,yy];
      c0:=con[xx,yy];
      c1:=con1[xx,yy];
    end;

    if rr=2 then begin
      if l=0 then setFillStyle(1,5);
      if l>0 then begin
        if c1>0 then setFillStyle(1,round(130+30*(con[j,i]/con1[j,i])))
        else setFillStyle(1,160);
      end;

      bar(x1,y1,x2,y2);
    end;

    if (x=xx) and (y=yy) then begin
      SetColor(126);
      recTangle(x1+1,y1+1,x2-1,y2-1);
    end;

    if (yy=MaxLot) and (xx=max+2) then begin
      for c0:=0 to round((x2-x1)/2) do begin
        SetColor(126-round(82*(c0)/((x2-x1)/2)));
        recTangle(x1+c0,y1+c0,x2-c0,y2-c0);
      end;
    end else begin
      SetColor(15);
      recTangle(x1,y1,x2,y2);
    end;

    if l>0 then begin
      x3:=trunc((470/max)*(xx-1/3));
      y3:=trunc((470/max)*(yy-1/3));
      x4:=trunc((470/max)*(xx-2/3));
      y4:=trunc((470/max)*(yy-2/3));

      if c1>0 then
        k:=round(63*(c0/c1))
      else k:=63;

      color:=0;
      if game=true then color1:=126 else color1:=220;
      if l>100 then begin
        dec(l,100);
        if game=true then color:=126 else color:=220
      end{ else color:=0};

      omx:=0;
      omy:=0;

      if (l=11) or (l=13) or (l=14) or (l=15) or (l=16) or (l= 9) then omx:=+1;
      if (l=17) or (l=19) or (l=20) or (l=21) or (l=22) or (l= 7) then omx:=-1;
      if (l=14) or (l=16) or (l=18) or (l=19) or (l=21) or (l=10) then omy:=+1;
      if (l=12) or (l=13) or (l=15) or (l=20) or (l=22) or (l= 8) then omy:=-1;
      if (l>=11) and (l<=16) then dec(l,10);
      if (l>=17) and (l<=22) then dec(l,16);


      if (fx=xx) and (fy=yy) then color:=round(64+62*(fc/fm));

{      if l<15 then} begin
        setFillStyle(1,color);
        if (l=54) or (l=55) then setFillStyle(1,color1);
        setColor(k);
        if (l=23) or (l=24) then begin
            recTangle((x3+x2)div 2+2,(y3+y2)div 2+2,(x4+x1)div 2-2,(y4+y1)div 2-2);
            bar      ((x3+x2)div 2+1,(y3+y2)div 2+1,(x4+x1)div 2-1,(y4+y1)div 2-1)
          end
          else
            bar(x3,y3,x4,y4);
        if (l=1) or (l=3) or (l=4) or (l= 7) or (l=23) or (l>50) then begin{left}
          if l=52 then setFillStyle(1,0) else
          setFillStyle(1,color);
          if l=54 then setFillStyle(1,color1);
          bar(x1,y3,x4,y4);
          line(x1,y3+1,x4+1,y3+1);
          line(x1,y4-1,x4+1,y4-1);
          if omx<>0 then begin
            line(x1,(y3+y2) div 2,x4+1,(y3+y2) div 2);
            if omx<0 then k:=x1 else k:=x4;
            line(k,(y3+y2) div 2,(x1+x4) div 2,(y3+y2) div 2+(y3-y2) div 3);
            line(k,(y3+y2) div 2,(x1+x4) div 2,(y3+y2) div 2-(y3-y2) div 3);
          end;
        end;
        if (l=1) or (l=5) or (l=6) or (l= 9) or (l=23) or (l>50) then begin{right}
          if l=52 then setFillStyle(1,0) else
          setFillStyle(1,color);
          if l=54 then setFillStyle(1,color1);
          bar(x2,y3,x3,y4);
          line(x2,y3+1,x3-1,y3+1);
          line(x2,y4-1,x3-1,y4-1);
          if omx<>0 then begin
            line(x2,(y4+y1) div 2,x3+1,(y4+y1) div 2);
            if omx>0 then k:=x2 else k:=x3;
            line(k,(y4+y1) div 2,(x2+x3) div 2,(y4+y1) div 2+(y4-y1) div 3);
            line(k,(y4+y1) div 2,(x2+x3) div 2,(y4+y1) div 2-(y4-y1) div 3);
          end;
        end;
        if (l=2) or (l=3) or (l=6) or (l= 8) or (l=24) or (l>50) then begin{up}
          if l=53 then setFillStyle(1,0) else
          setFillStyle(1,color);
          if l=55 then setFillStyle(1,color1);
          bar(x3,y1,x4,y4);
          line(x3+1,y1,x3+1,y4-1);
          line(x4-1,y1,x4-1,y4-1);
          if omy<>0 then begin
            line((x4+x1)div 2,y1,(x4+x1)div 2,y4);
            if omy<0 then k:=y1 else k:=y4;
            line((x4+x1)div 2,k,(x4+x1)div 2+(x4-x1) div 3,(y4+y1)div 2);
            line((x4+x1)div 2,k,(x4+x1)div 2-(x4-x1) div 3,(y4+y1)div 2);
          end;
        end;
        if (l=2) or (l=4) or (l=5) or (l=10) or (l=24) or (l>50) then begin{down}
          if l=53 then setFillStyle(1,0) else
          setFillStyle(1,color);
          if l=55 then setFillStyle(1,color1);
          bar(x3,y2,x4,y3);
          line(x3+1,y2,x3+1,y3+1);
          line(x4-1,y2,x4-1,y3+1);
          if omy<>0 then begin
            line((x3+x2)div 2,y2,(x3+x2)div 2,y3);
            if omy>0 then k:=y2 else k:=y3;
            line((x3+x2)div 2,k,(x3+x2)div 2+(x3-x2) div 3,(y3+y2)div 2);
            line((x3+x2)div 2,k,(x3+x2)div 2-(x3-x2) div 3,(y3+y2)div 2);
          end;
        end;

        if (l=1) or (l=3) or (l=6) or ((l= 7) or (l= 9) or (l= 8)) then line(x3  ,y3+1,x4  ,y3+1);{down}
        if (l=1) or (l=4) or (l=5) or ((l= 7) or (l= 9) or (l=10)) then line(x3  ,y4-1,x4  ,y4-1);{up}
        if (l=2) or (l=3) or (l=4) or ((l= 7) or (l= 8) or (l=10)) then line(x3+1,y3  ,x3+1,y4  );{right}
        if (l=2) or (l=5) or (l=6) or ((l= 8) or (l= 9) or (l=10)) then line(x4-1,y3  ,x4-1,y4  );{left}
     end;
    end;
    if c1>0 then begin
      str(round(100*(c0/c1)):3,str1);
      if c1>buildTime then
        setColor(189+63)
      else
        setColor(189);
      outTextXY(round((x1+x2)/2-16),round((y1+y2)/2-4),str1+'%');
    end

{     else begin
       setColor(63);
       str(l,str1);
       outTextXY(round((x1+x2)/2-16),round((y1+y2)/2-4),str1);
     end;}
end;
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
procedure DrawMap;
begin
for i:=1 to max do
  for j:=1 to max do if r[j,i]>0 then begin
    drawBlock(j,i);
    r[j,i]:=0;
end;
end;
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
procedure Flow;
var mx,my:shortInt;
begin
 case map[fx,fy] of
   7:fdx:=-1;
   8:fdy:=-1;
   9:fdx:=+1;
  10:fdy:=+1;
 end;

 case map[fx,fy] of
    1.. 6:fm:=FlowTime;
    7..10:fm:=255;
   11..22:fm:=FlowTime+Speed;
   23..24:fm:=FlowTime*5;
   51..55:fm:=FlowTime;
 end;

 if R[fx,fy]=0 then R[fx,fy]:=1;
 if (fc+speed<fm) then inc(fc,Speed) else begin
   case map[fx,fy] of
     1,2,7..10,51,52,53,54,55, 11,12,17,18,23,24:begin
          mx:=fdx;
          my:=fdy;
         end;
     3,5, 13,15,19,21:begin
          mx:=-fdy;
          my:=-fdx;
         end;
     4,6, 14,16,20,22:begin
          mx:=fdy;
          my:=fdx;
         end;
   end;
   if score mod 25=0 then inc(bonus);
   inc(score);
   inc(money,income);

   if (map[fx,fy]>=152) then map[fx,fy]:=151;

   if (map[fx,fy]<100) then
     inc(map[fx,fy],100);
   inc(fx,mx);
   inc(fy,my);
   fdx:=mx;
   fdy:=my;
   Fc:=0;

  if (fx>0) and (fy>0) and (fx<=max) and (fy<=max) then begin
    if (map[fx,fy]=51) then begin
      if mx<>0 then map[fx,fy]:=53 else map[fx,fy]:=52;
    end;
    if (map[fx,fy]=152) then map[fx,fy]:=55;
    if (map[fx,fy]=153) then map[fx,fy]:=54;
    l:=map[fx,fy];

      omx:=0;
      omy:=0;
      if (l=11) or (l=13) or (l=14) or (l=15) or (l=16) then omx:=+1;
      if (l=17) or (l=19) or (l=20) or (l=21) or (l=22) then omx:=-1;
      if (l=14) or (l=16) or (l=18) or (l=19) or (l=21) then omy:=+1;
      if (l=12) or (l=13) or (l=15) or (l=20) or (l=22) then omy:=-1;
      if (omx<>0) or (omy<>0) then
        if (omx<>mx) and (omy<>my) then game:=false;

      if (l>=11) and (l<=16) then dec(l,10);
      if (l>=17) and (l<=22) then dec(l,16);

    if con1[fx,fy]>0 then game:=false;
  end else l:=0;
   if ((l>=107) and (l<=110)) then game:=false;
   if (l=0) or ((l>100)and(l<150)) then game:=false;
   if ((l=1) or (l=4) or (l=5) or (l=23)) and (my= 1) then game:=false;
   if ((l=1) or (l=3) or (l=6) or (l=23)) and (my=-1) then game:=false;
   if ((l=2) or (l=5) or (l=6) or (l=24)) and (mx= 1) then game:=false;
   if ((l=2) or (l=3) or (l=4) or (l=24)) and (mx=-1) then game:=false;

   if game=false then begin
     fx:=0;
     fy:=0;
   end;
 end;

 if game=false then begin
   for i:=1 to max do
     for j:=1 to max do r[j,i]:=1;
   fast:=false;
 end;
end;
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
procedure build;
begin
for i:=1 to max do
  for j:=1 to max do if con1[j,i]>0 then begin
    inc(con[j,i],buildSpeed);
    if con[j,i]>con1[j,i] then con1[j,i]:=0;
    r[j,i]:=2;
  end;
end;
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
procedure CycleLot;
begin
for i:=1 to maxLot do begin
  if i<maxLot then
    lot[i]:=lot[i+1]
  else begin
    repeat
      k:=round(random*100);
      case k of
         0..  0:lot[i]:=23+round(random);
         0.. 10:lot[i]:=51;
        10.. 30:lot[i]:=1+round(random);
        30.. 35:lot[i]:=11+round(random);
        35.. 40:lot[i]:=17+round(random);
        40.. 88:lot[i]:=3+round(random*3);
        88.. 94:lot[i]:=13+round(random*3);
        94..100:lot[i]:=19+round(random*3);
      end;
      if (lot[i]= 1) or (lot[i]= 2) or (lot[i]=17) or (lot[i]=18) or
         (lot[i]=11) or (lot[i]=12) then k:=1;
      if (lot[i]= 3) or (lot[i]=13) or (lot[i]=19) then k:=2;
      if (lot[i]= 4) or (lot[i]=14) or (lot[i]=20) then k:=3;
      if (lot[i]= 5) or (lot[i]=15) or (lot[i]=21) then k:=4;
      if (lot[i]= 6) or (lot[i]=16) or (lot[i]=22) then k:=5;
      if (lot[i]=51) then k:=6;
      if (lot[i]=24) or (lot[i]=23) then k:=7;

    until b[k]<2;
    inc(b[k]);

    flg:=true;
    for l:=1 to 6 do if b[l]=0 then flg:=false;
    if flg=true then
      for l:=1 to 6 do b[l]:=0;


{    if bonus>0 then begin
      dec(bonus);
      lot[i]:=23+round(random);
    end;}
  end;

  if game=true then drawBlock(max+2,maxLot-i+1);
end;
end;
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
{-------------------------------------------------------------------}
BEGIN
SetGraficMode(2);
randomize;
for i:=1 to 63 do setRgbPalette(    i,i,i,i);
for i:=1 to 63 do setRgbPalette( 63+i,0,0,i);
for i:=1 to 63 do setRgbPalette(126+i,0,i,0);
for i:=1 to 63 do setRgbPalette(189+i,i,0,0);
for i:=1 to max do
  for j:=1 to max do begin
    map[j,i]:=0;
    r[j,i]:=2;
  end;

{for i:=1 to 3 do map[2+round(random*(max-4)),2+round(random*(max-4))]:=23+round(random);}

fdx:=0;
fdy:=0;
fx:=2+round(random*(max-4));
fy:=2+round(random*(max-4));
map[fx,fy]:=7+round(random*3);

fc:=0;

{fx:=2;
fy:=3;}


lx:=fx;
ly:=fy;

score:=0;
money:=75;
x:=fx;
y:=fy;

for j:=1 to maxLot-1 do cycleLot;
game:=true;
cycleLot;
fast:=false;
moves:=0;
repeat
if moves=0 then begin
 setFillStyle(1,0);
 bar(475,400,640,420);
 setColor(63);
 str(score:4,str1);
{ str(1000*(score/sqr(max)):4:0,str2);}
 outTextXY(475,400,'Score:'+str1{+'('+str2+')'});
 str(money:4,str1);
 outTextXY(475,410,'Money:'+str1+'$');
end;
 if game=true then begin
   build;
   flow;
 end;
  if (lx<>x) or (ly<>y) or (r[x,y]=2) then begin
    r[lx,ly]:=2;
    if r[x,y]=0 then r[x,y]:=1;
  end;

 DrawMap;

 key:='|';
 if (fast=false) and (moves=0) then begin
   key:=readKey;
   if key=#0 then key1:=readKey;
   case key of
     '1'..'9':begin
              val(key,moves,k);
              moves:=moves*2+1;
             end;
     'f','F':fast:=true;
     enter:if (map[x,y]<100) and ((fx<>x)or(fy<>y)) then begin
             r[x,y]:=2;

            if map[x,y]=0 then l:=cost else l:=2*cost;

           if money>=l then begin
            dec(money,l);
            if map[x,y]=0 then
              con1[x,y]:=buildTime
             else
              con1[x,y]:=2*buildTime;

            if (lot[1]=23) or (lot[1]=24) then inc(con1[x,y],32);
            if (lot[1]>=11) and (lot[1]<=22) then dec(con1[x,y],BuildSpeed*2-buildSpeed div 2);
            con[x,y]:=0;
            map[x,y]:=lot[1];
            cycleLot;

           end;
          end;
   end;
 end
 else delay(1);

 if moves>0 then dec(moves,1);

 lx:=x;
 ly:=y;
 if key=#0 then
  case key1 of
   up  :if y>1   then dec(y);
   down:if y<max then inc(y);
   left:if x>1   then dec(x);
  right:if x<max then inc(x);
  end;

until (key=#0) and (key1=f10);

END.
{135 Genia}