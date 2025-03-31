program p1ej1;
const
	corte = 30000;
type
	ArchivoNum =file of integer;
var
	numeros : ArchivoNum;
	num :integer;
begin
	assign (numeros,'archivoDeEnteros.dat');
	rewrite(numeros);
	writeln('--- INGRESE UN NUMERO ---');
	readln(num);
	while (num<>corte)do begin
		write(numeros,num);
		writeln('--- INGRESE UN NUMERO ---');
		readln(num);
	end;
	close(numeros);
	writeln('--- FINALIZO LA CARGA ---');
end.
	
	
	
	

