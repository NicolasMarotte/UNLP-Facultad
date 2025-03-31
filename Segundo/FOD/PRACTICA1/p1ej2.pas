program p1ej2;
type
	Archivo = file of integer;
var
	arch:Archivo;
	num:integer;
begin
	assign (arch,'archivoDeEnteros.dat');
	reset (arch);
	while (not eof(arch))do begin
		read(arch,num);
		writeln('---> ',num);
	end;
	close(arch)
end.
		
	
