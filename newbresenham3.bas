!-better bresenham
!-https://github.com/HNE74/cbmprogs/blob/master/Bresenham/bresenham.bas
!-3d cube code from:
!-https://retro64.altervista.org/blog/3d-graphics-rotating-cube-with-freebasic-pc-and-simons-basic-c64/
!-
!-try to implement a z-buffer, since lines that are behind will overlap
!-done! -- looks much better
!-
1 rem ********************************
2 rem *** bresenham line algorithm
3 rem ********************************
10 dim v(999):sc=1024:ch=160:rem v array is z buffer
15 rem open2,8,2,"cubedata,s,w":rem save frames to disk
20 xs=10:ys=10:xt=15:yt=3
25 xp=0:yp=0:rl=40
30 dx=0:dy=0:fe=0
40 goto 2000
100 a=sc+yp*rl+xp:ifa<1024ora>2023thenreturn
102 rem check z buffer
103 ifv(a-1024)<wthenreturn
104 v(a-1024)=w
105 pokea,ch:poke54272+a,cl
110 return
200 rem print "{clear}":print "bresenham line algorithm demo":print "*****************************"
205 rem input "x start";xs:input "y start";ys:input "x end";xt:input "y end";yt
208 rem print "{clear}"
210 dx=abs(xt-xs):dy=abs(yt-ys)
215 rem printw;
220 if xt>=xs and ys=>yt then gosub 310:return:rem goto 250
230 if xt>=xs and ys<yt then gosub 710:return:rem goto 250
235 if xt<xs and ys<yt then gosub 910:return:rem goto 250
240 gosub 510
250 return:rem poke 198,0:wait 198,1:goto 200
300 rem *** sector 1
305 rem print "sector 1"
310 if dy>dx then gosub 400:return
320 fe=dx/2
330 xp=xs:yp=ys:gosub100
340 for xp=xs+1 to xt
350 fe=fe-dy
360 if fe<0 then yp=yp-1:fe=fe+dx
370 gosub 100
380 next
390 return
400 fe=dy/2
410 xp=xs:yp=ys:gosub 100
420 for yp=ys-1 to yt step-1
430 fe=fe-dx
440 if fe<0 then xp=xp+1:fe=fe+dy
450 gosub 100
460 next
470 return
500 rem *** sector 4
505 rem print "sector 4"
510 if dy>dx then gosub 600:return
520 fe=dx/2
530 xp=xs:yp=ys:gosub100
540 for xp=xs-1 to xt step-1
550 fe=fe-dy
560 if fe<0 then yp=yp-1:fe=fe+dx
570 gosub 100
580 next
590 return
600 fe=dy/2
610 xp=xs:yp=ys:gosub 100
620 for yp=ys-1 to yt step-1
630 fe=fe-dx
640 if fe<0 then xp=xp-1:fe=fe+dy
650 gosub 100
660 next
670 return
700 rem *** sector 2
705 rem print "sector 2"
710 if dy>dx then gosub 800:return
720 fe=dx/2
730 xp=xs:yp=ys:gosub100
740 for xp=xs+1 to xt
750 fe=fe-dy
760 if fe<0 then yp=yp+1:fe=fe+dx
770 gosub 100
780 next 
790 return
800 fe=dy/2
810 xp=xs:yp=ys:gosub 100
820 for yp=ys+1 to yt
830 fe=fe-dx
840 if fe<0 then xp=xp+1:fe=fe+dy
850 gosub 100
860 next
870 return
900 rem *** sector 3
905 rem print "sector 3"
910 if dy>dx then gosub 1000:return
920 fe=dx/2
930 xp=xs:yp=ys:gosub100
940 for xp=xs-1 to xt step-1
950 fe=fe-dy
960 if fe<0 then yp=yp+1:fe=fe+dx
970 gosub 100
980 next
990 return
1000 fe=dy/2
1010 xp=xs:yp=ys:gosub 100
1020 for yp=ys+1 to yt
1030 fe=fe-dx
1040 if fe<0 then xp=xp-1:fe=fe+dy
1050 gosub 100
1060 next
1070 return
2000 rx=0:l=80:fs=200:l=l/2
2005 ra=(2*{pi})/100:rem set 100 frames
2010 rem *** edges ***
2020 x(1)=-l:y(1)=-l:z(1)=-l
2030 x(2)=-l:y(2)=l:z(2)=-l
2040 x(3)=l:y(3)=l:z(3)=-l
2050 x(4)=l:y(4)=-l:z(4)=-l
2060 x(5)=-l:y(5)=-l:z(5)=l
2070 x(6)=-l:y(6)=l:z(6)=l
2080 x(7)=l:y(7)=l:z(7)=l
2090 x(8)=l:y(8)=-l:z(8)=l
2100 c=cos(rx):s=sin(rx):rem rotate
2110 fornp=1to8
2120 yt=y(np):y(np)=c*yt-s*z(np):z(np)=s*yt+c*z(np):rem D ation on x axes
2130 xt=x(np):x(np)=c*xt+s*z(np):z(np)=-s*xt+c*z(np):rem D ation on y axes
2140 xt=x(np):x(np)=xt*c-y(np)*s:y(np)=xt*s+y(np)*c:rem D ation on z axes
2150 rem projections and translations
2160 vx(np)=(120+(x(np)*fs)/(z(np)+fs))/6
2170 vy(np)=(75+(y(np)*fs)/(z(np)+fs))/6
2175 vz(np)=z(np):rem for the z-buffer
2180 next
2190 rx=rx+ra:rem advance rotation
2200 gosub2400:print"{clear}"fr;:cl=0:rem color
2205 xs=int(vx(1)):ys=int(vy(1)):xt=int(vx(2)):yt=int(vy(2)):w=vz(1):gosub210:cl=cl+1
2220 xs=int(vx(2)):ys=int(vy(2)):xt=int(vx(3)):yt=int(vy(3)):w=vz(2):gosub210:cl=cl+1
2230 xs=int(vx(3)):ys=int(vy(3)):xt=int(vx(4)):yt=int(vy(4)):w=vz(3):gosub210:cl=cl+1
2240 xs=int(vx(4)):ys=int(vy(4)):xt=int(vx(1)):yt=int(vy(1)):w=vz(4):gosub210:cl=cl+1
2250 xs=int(vx(5)):ys=int(vy(5)):xt=int(vx(6)):yt=int(vy(6)):w=vz(5):gosub210:cl=cl+1
2260 xs=int(vx(6)):ys=int(vy(6)):xt=int(vx(7)):yt=int(vy(7)):w=vz(6):gosub210:cl=cl+2
2270 xs=int(vx(7)):ys=int(vy(7)):xt=int(vx(8)):yt=int(vy(8)):w=vz(7):gosub210:cl=cl+1
2280 xs=int(vx(8)):ys=int(vy(8)):xt=int(vx(5)):yt=int(vy(5)):w=vz(8):gosub210:cl=cl+1
2290 xs=int(vx(1)):ys=int(vy(1)):xt=int(vx(5)):yt=int(vy(5)):w=vz(1):gosub210:cl=cl+1
2300 xs=int(vx(4)):ys=int(vy(4)):xt=int(vx(8)):yt=int(vy(8)):w=vz(4):gosub210:cl=cl+1
2310 xs=int(vx(2)):ys=int(vy(2)):xt=int(vx(6)):yt=int(vy(6)):w=vz(2):gosub210:cl=cl+1
2320 xs=int(vx(3)):ys=int(vy(3)):xt=int(vx(7)):yt=int(vy(7)):w=vz(3):gosub210:rem cl=cl+1
2325 rem gosub 2500:rem save frame
2328 fr=fr+1:if fr>100 then goto 2600
2330 goto2020
2399 rem clear z-buffer
2400 fora=0to999:v(a)=200:next
2410 return
2499 rem save frame
2500 for a=0to999step2:d=(peek(55296+a)and15)*16+(peek(55297+a)and15)
2510 rem print"{home}"peek(55296+a)and15,peek(55297+a)and15,d;:ifd>255 thenprint"ups!"
2520 print#2,chr$(d);
2530 next
2540 print"{home}frame "fr" saved"
2550 return
2599 rem close file and finish
2600 print"closing file":close2:print"complete"