
dio = digitalio('guadaq',1);
hwlines = addline(dio,[0 1 2 3],{'out';'out';'in';'in'});
whos hwlines

hwinfo = daqhwinfo(dio)
for i=1:10
    putvalue(dio.Line(1),0);
    putvalue(dio.Line(2),1);
    in1=getvalue(dio.Line(3))
    in2=getvalue(dio.Line(4))
    pause(1),
    putvalue(dio.Line(1),1);
    putvalue(dio.Line(2),0);
    pause(1)
end
delete(dio);
clear dio
