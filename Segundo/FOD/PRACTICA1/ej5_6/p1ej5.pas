program p1e5;
type
	str20 = string[20];
	celular = record
		codigo:integer;
		nombre:str20;
		desc:string;
		marca:str20;
		precio:real;
		stockMin:integer;
		stockAct:integer;
		end;
		
	celtxt = text;
	
	
procedure leerCel (var c:celular);
begin
	writeln('Ingrese el codigo de celular');
	readln(c.codigo);
	if (c.codigo <> -1) then
	begin
		writeln('Ingrese la marca');
		readln(c.marca);
		writeln('Ingrese el nombre');
		readln(c.nombre);
		writeln('Ingrese la descripcion');
		readln(c.desc);
		writeln('Ingrese el precio');
		readln(c.precio);
		writeln('Ingrese el stock minimo');
		readln(c.stockMin);
		writeln('Ingrese el stock disponible');
		readln(c.stockAct);
	end;
end;
var
	ArchCel:celtxt;
	c:celular;
begin
	assign(archcel, 'celulares.txt');
	rewrite(archcel);
	leerCel(c);
	while(c.codigo <> -1) do
	begin
		writeln(archcel,c.codigo,' ',c.precio:0:2,' ',c.marca);
		writeln(archcel,c.stockMin,' ',c.stockAct,' ',c.desc);
		writeln(archcel,c.nombre);
		leerCel(c);
	end;
	close(archcel);
end.
