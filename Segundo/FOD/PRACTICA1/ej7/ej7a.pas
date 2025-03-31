program ej7;
type
	string20 = string[20];
		
	novela = record
		cod:integer;
		nombre:string20;
		genero:string20;
		precio:real;
	end;
	
	txtNov = text;
	
	
	procedure leerNovela(var n:novela);
	begin
		writeln('INGRESE EL CODIGO DE LA NOVELA');
		readln(n.cod);
		if (n.cod<>-1)then begin
			writeln('INGRESE EL NOMBRE DE LA NOVELA');
			readln(n.nombre);
			writeln('INGRESE EL GENERO DE LA NOVELA');
			readln(n.genero);
			writeln('INGRESE EL PRECIO DE LA NOVELA');
			readln(n.precio);
		end;
	end;
	
	var
		textNov:txtNov;
		n:novela;
		
	begin
		assign(textNov,'novela.txt');
		rewrite(textNov);
		leerNovela(n);
		while (n.cod<>-1)do begin
			writeln(textNov,n.cod,n.precio,n.genero);
			writeln(textNov,n.nombre);
			leerNovela(n);
		end;
		writeln('/// // / CARGA TERMINADA / // ///');
		close(textNov);
	end.

