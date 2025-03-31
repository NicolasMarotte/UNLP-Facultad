program p1ej5;
type
	string15 =String[15];
	string100 =String[100];
	
	celular = record
		cod : integer;
		nombre : string15;
		descripcion : string100;
		marca : string15;
		precio : real;
		stockMinimo : integer;
		stockDisponible: integer;
	end;
	
	textoCel=text;
	
	archivoCel= file of celular;
	
	procedure leerCelular(var c:celular);
	var
		cel:celular;
	begin
		writeln('INGRSE EL CODIGO DEL CELULAR');
		readln(cel.cod);
		if (cel.cod<>-1)then begin
			writeln('INGRSE EL NOMBRE ');
			readln(cel.nombre);
			writeln('INGRSE LA DESCRIPCION');
			readln(cel.descripcion);
			writeln('INGRSE LA MARCA');
			readln(cel.marca);
			writeln('INGRSE EL PRECIO');
			readln(cel.precio);
			writeln('INGRSE EL STOCK MINIMO');
			readln(cel.stockMinimo);
			writeln('INGRSE EL STOCK DISPONIBLE');
			readln(cel.stockDisponible);
		end
	end;
	
	procedure leer (var a:archivoCel);
	var
		cel:celular;
	begin
		if (not eof(a))then 
			read(a,cel)
		else 
			cel.cod:=-1;
	end;
	
procedure BinATxt(var ac:archivoCel;var tc:textoCel);
var
	c:celular;
	str:string;
begin
	writeln(' - - - INGRESE EL NOMBRE DEL ARCHIVO BINARIO - - -');
	readln(str);
	assign(ac,str);
	rewrite(ac);
	reset(tc);
	while(not eof(tc)) do
	begin
		readln(tc,c.cod,c.precio,c.marca);
		readln(tc,c.stockMinimo,c.stockDisponible);
		readln(tc,c.nombre);
		write(ac, c);
	end;
	close(ac);
	close(tc);
	writeln ('ARCHIVO EXPORTADO');
end;
procedure TxtABin(var tc:textoCel;var ac:archivoCel);
var
	c:celular;
begin
	rewrite(tc);
	reset(ac);
	while (not eof(ac)) do
	begin
		read(ac,c);
		writeln(tc,c.cod,c.precio:0:2,c.marca);
		writeln(tc,c.stockMinimo,c.stockDisponible,c.descripcion);
		writeln(tc,c.nombre);
	end;
	close(tc);
	close(ac);
end;

procedure abrirArchivo(var ac:archivoCel);
var
	str:String15;
begin
	writeln('--- INGRESE EL NOMBRE DEL ARCHIVO');
	readln(str);
	assign(ac,str);
end;

procedure listar (var ac:archivoCel);
var
	c:celular;
begin
	reset(ac);
	while(not eof(ac))do begin
		read(ac,c);
		with c do writeln('////// CODIGO',cod,'MARCA',marca,'NOMBRE',nombre,'DESCRIPCION',descripcion,'PRECIO',precio,'STOCK',stockMinimo,'/',stockDisponible,'//////');
	end;
	close(ac);
end;

procedure listarStock (var ac:archivoCel);
var
	c:celular;
begin
	reset(ac);
	while(not eof(ac))do begin
		read(ac,c);
		if (c.stockDisponible<c.stockMinimo)then 
			with c do writeln('////// CODIGO',cod,'MARCA',marca,'NOMBRE',nombre,'DESCRIPCION',descripcion,'PRECIO',precio,'STOCK',stockMinimo,'/',stockDisponible,'//////');
	end;
	close(ac);
end;

procedure listarDesc(var ac:archivoCel);
var
	str:string15;
	c:celular;
begin
	writeln('INGRESE LA CADENA');
	readln(str);
	str:=str;
	reset(ac);
	while(not eof(ac))do begin
		read(ac,c);
		if(c.descripcion=str)then
			with c do writeln('////// CODIGO',cod,'MARCA',marca,'NOMBRE',nombre,'DESCRIPCION',descripcion,'PRECIO',precio,'STOCK',stockMinimo,'/',stockDisponible,'//////');
	end;
	close(ac);
end;

procedure agregarCelular(var ac:archivoCel);
var
	c:celular;
begin
	leerCelular(c);
	if (c.cod <>-1)then begin 
		reset(ac);
		seek(ac,fileSize(ac));
		write(ac,c);
		writeln('/// SE AGREGO CORRECTAMENTE ///');
	end;
	close(ac);
end;
	
procedure modificarStock (var ac:archivoCel);
var
	c:celular;
	int:integer;
begin
	writeln('INGRESE EL CODIGO DEL CELULAR A MODIFICAR SU STOCK');
	readln(int);
	reset(ac);
	read(ac,c);
	leer(ac);
	while (c.cod<>-1)and(c.cod<>int)do begin
		leer(ac);
		if(c.cod<>-1)then 
			writeln('EL CODIGO NO SE ENCUENTRA EN LA BASE DE DATOS')
		else begin
			writeln('INGRESE EL NUEVO STOCK');
			readln(c.stockDisponible);
			write(ac,c);
		end;
	close(ac);
	end;
end;

procedure cargarSinStock (var ac:archivoCel);
var
	c:celular;
	txt:text;
begin
	assign(txt,'SinStock.txt');
	rewrite(txt);
	reset(ac);
	while (not eof(ac)) do
	begin
		read(ac, c);
		if (c.stockDisponible = 0) then
		begin
			writeln(txt,c.cod,' ',c.precio:0:2,' ',c.marca);
			writeln(txt,c.stockMinimo,' ',c.stockDisponible,' ',c.descripcion);
			writeln(txt,c.nombre);	
		end;
	end;
	writeln('ARCHIVO EXPORTADO');
	close(ac);
	close(txt);
end;

var
	archCel : archivoCel;
	txtCel : textoCel;
	int:integer;
	
begin
	
	assign(txtCel,'celulares.txt');
	repeat
	writeln(' ///////	MENU	///////');
	writeln('1. CREAR TEXTO A PARTIR DE BINARIO');
	writeln('2. ABRIR ARCHIVO');
	writeln('3. MODIFICAR TEXTO A PARTIR DE BINARIO');
	writeln('4. IMPRIMIR TODOS');
	writeln('5. ELEMENOS CON MENOS STOCK QUE MINIMO');
	writeln('6. ELEMENTOS CON ESTA DESCRIPCION');
	writeln('7. AGREGR CELULAR');
	writeln('8. MODIFICAR STOCK');
	writeln('9. CREAR TXT DE PRODUCTOS SINS STOCK');
	writeln('-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_');
	readln(int);
	
	case int of
	1: BinATxt(archCel,txtCel);
	2: abrirArchivo(archCel);
	3: TxtABin(txtCel,archCel);
	4: listar(archCel);
	5: listarStock(archCel);
	6: listarDesc(archCel);
	7: agregarCelular(archCel);
	8: modificarStock(archCel);
	9: cargarSinStock(archCel);
	end;
	writeln('--------------------------------------------');
	until (2<1);
end.


	
		
	
		
