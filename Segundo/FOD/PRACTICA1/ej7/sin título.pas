program ej7;
type
	string20 :string[20];
		
	novela = record
		cod:integer;
		nombre:string20;
		genero:string20;
		precio:real;
	end;
	
	txtNov : text;
	
	
	procedure leerNovela(var n:novela);
	begin
		writeln('INGRESE EL CODIGO DE LA NOVELA')
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
		textNovela:txtNov;
		n:novela;
		
	begin
		assign(txtNov,'novela.txt');
		rewrite(txtNov);
		leerNovela(n);
		while (n.cod<>-1)do begin
			writeln(txtNov,n.cod,n.precio,n.genero);
			writeln(txtNov,n.nom);
			leer(n);
		end;
		writeln('/// // / CARGA TERMINADA / // ///');
		close(txtNov);
	end;

