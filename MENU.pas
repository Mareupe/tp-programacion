Unit MENU;

Interface

Uses crt, iconos_carteles, ARCHART, ARCHDIR, ARCHMUS, ARCHOBR, VALIDACIONES;

Var
    Opcion:   char; // almacena la opcion elejida en el menu x el usuario
    X, Y:   Byte; // Coordenadas para controlar algunos menus graficos


// variables de posicion para algunos recuadros graficos que se modifican dependiendo del tipo de menu

//Menus (todo funciona)
Procedure Menu_Principal;
Procedure Menu_Cargar;
Procedure Menu_Editar;
Procedure Menu_Borrar;
Procedure Menu_Estadisticas;

//Cargar (verificar museo, las demas funcionan)
Procedure MCargar_OBR (Var Obras:Archivo_Obras;Var Museos:Archivo_Museos;Var Artistas:Archivo_Artistas);
Procedure MCargar_ART (Var Artistas:Archivo_Artistas);
Procedure MCargar_MUS (Var Museos:Archivo_Museos; Var Directores:Archivo_Directores);
Procedure MCargar_Director (Var Directores:Archivo_Directores);

//Baja (todas funcionan)
Procedure MBajar_obr (Var Obras:Archivo_Obras);
Procedure MBajar_Art (Var Artistas:Archivo_Artistas);
Procedure MBajar_Mus (Var Museos:Archivo_Museos);
Procedure MBajar_Dir (Var Directores:Archivo_Directores);

//Modificar (verificar que los carteles y marcos no se superponen)
Procedure MModificar_Obra(Var Obras:Archivo_Obras);
Procedure MModificar_Artista(Var Artistas:Archivo_Artistas);
Procedure MModificar_Museo(Var Museos:Archivo_Museos);
Procedure MModificar_Director(Var Directores:Archivo_Directores);

//Estadistica (algoritmos al final)
{Procedure ProcesarArchivos(var ARCH_Obras:Archivo_Obras; var ARCH_Artistas:Archivo_Artistas); }// Comparar los artistas con las obras (1 artista := n obras)
Procedure Segun_ObraMostrar(var Obras:Archivo_Obras);
procedure Estadistica_Artistas_Obras(var ARCH_Artistas:Archivo_Artistas; var ARCH_Obras:Archivo_Obras);
Procedure Atras(var ARCH_Artistas:Archivo_Artistas; var ARCH_Obras:Archivo_Obras; var PunteroArt:int64; var Lim:Int64);
Procedure Adelante(var ARCH_Artistas:Archivo_Artistas; var ARCH_Obras:Archivo_Obras; var PunteroArt:int64; var Lim:Int64);

{Procedure artistas_con_mas_obras();
*

Procedure Segun_Obra_Mostrar_Artista_Museo (var Obras:Archivo_Obras);
Procedure Segun_Museo_Mostrar_Director_Obras (var Museos:Archivo_Museos;Var Obras:Archivo_Obras);

}
Procedure Segun_ArtistaMOSTRARObras(var Obras:Archivo_Obras; var Artistas:Archivo_Artistas);

///////////////////////////////////////

Implementation
Procedure Menu_Principal;
var 
	Opc:char;

Begin
    Repeat
	 Opc := '0';
     Menu_Principal_Graph();
     Opc := Readkey;
		Case (Opc) Of
		 '1':   Menu_Cargar();
		 '2':   Menu_Editar();
		 '3':   Menu_Borrar();
		 '4':   Menu_Estadisticas();
		 '0':   Exit;
		End;
    Until (Opc='0');
End;

Procedure Menu_Cargar;
Var
	Opc: char;
	
Begin
    Repeat
     Opc := '0';
     Menu_Cargar_Graph;
     Opc := Readkey;
     Case (Opc) Of
         '1':   MCargar_OBR(Obras,Museos,Artistas);
         '2':   MCargar_ART (Artistas);
         '3':   MCargar_MUS(Museos,Directores);
         '4':   MCargar_Director(Directores);
         '0':   clrscr;
        End;
    Until (Opc='0');
End;

Procedure Menu_Editar;
Var
	Opc: char;
	
Begin
    Opc := '0';
    Repeat
        Menu_Editar_Graph;
        Opc := Readkey;
    
		Case (Opc) Of
			 '1':   MModificar_Obra (Obras);
			 '2':   MModificar_Artista (Artistas);
			 '3':   MModificar_Museo (Museos);
			 '4':   MModificar_Director (Directores);
			 '0':   clrscr;
			End;
    Until (Opc = '0');
End;

Procedure Menu_Borrar;
Var
	Opc:char;
	
Begin
    Opc := '0';
    Repeat
        Menu_Borrar_Graph;
        Opc := Readkey;
		Case (Opc) Of
         '1':   MBajar_obr (Obras);
         '2':   MBajar_Art (Artistas);
         '3':   MBajar_Mus (Museos);
         '4':   MBajar_Dir (Directores);
         '0':   clrscr;
        End;
	Until (Opc='0');
End;

Procedure Menu_Estadisticas;
var
	Opc: char;
	
Begin
Opc := '0';
    Repeat
		Menu_Estadisticas_Graph;
        Opc := Readkey;
		Case (Opc) Of

			'1':Begin // Dado un Artista Mostrar sus Obras
				 Segun_ArtistaMOSTRARObras(Obras, Artistas);
                End;

			'2':Begin // Dado un Museo Mostrar Director y Lista de Obras
				 Menu_Estadistica_ObrasxAutor();
				 Estadistica_Artistas_Obras(Artistas, Obras);
                End;

			'3':Begin // Esto esta de adorno V:
				 Segun_ObraMostrar(Obras);
				 readkey;
				 Clrscr;
                End;

			'4':Begin
				 clrscr;
				 TextColor(Red);
				 Writeln('Barrido Obras');
				 Barrido_Obr(Obras);
			
				 TextColor(Green);
				 Gotoxy(25,1);
				 Writeln('Barrido Artistas');
				 Barrido_Art(Artistas);
				
				 TextColor(Blue);
				 Gotoxy(50,1);
				 Writeln('Barrido Museos:');
				 Barrido_Mus(Museos);
				 
				 TextColor(Yellow);
				 Gotoxy(75,1);
				 Writeln('Barrido Directores');
                 Barrido_Dir(Directores);

                End;

			'0':clrscr;
		End;
	Until (Opc = '0');
End;


Procedure MCargar_OBR(Var Obras:Archivo_Obras; Var Museos:Archivo_Museos; Var Artistas:Archivo_Artistas);
Var
    Mus :   Museo;
    Artist :   Artista;
    restaurar :   char; // variable de restauracion en caso de existencia
    pos, B, Code :   Int64; // posicion en archivo - conversion a integer - codigo a asignar
    Name, N_Mus, N_Art, N1 :   String; // Se usa Name para Nombre del Artista y Nombre de la Obra

Begin
    B := 0;
    pos := -1;
    Code := 0;
    Menu_Cargar_Obra; // Carga de la Interfaz
    TextColor (Green);
    Gotoxy (33,5);
    Readln(Name); // Nombre de la Obra
    Buscar_Obra_Nombre (Obras, pos, Name, obr); // Si el Nombre no existe en el Archivo
    If (pos = -1) Then // Si la obra no existe
        Begin
            Repeat
                Code := Random(4294967295); // Codigo Random
                Buscar_Obra_Codigo(Obras, pos, Code, Obr); // Se busca si el codigo esta en uso
            Until (pos = -1);

            AbrirO(Obras);
            Gotoxy (30,7);
            Writeln (Code);
            obr.Codigo_Obra := Code;
            obr.Nombre := Name;

            TextColor(Green);
            Gotoxy(35,9);
            Readln(obr.Material);
            Gotoxy(31,11);

            TextColor(Green);
            Readln(N1);
            X := (31);
            Y := (11);
            Validacion_Integer(N1,B,X,Y);
            obr.Anio := B;

            TextColor(Green);
            Gotoxy(28,13);
            Readln(obr.Tipo);

            TextColor(Green);
            Gotoxy(30,15);
            Readln(obr.Estilo);

            TextColor(Green);
            Gotoxy(36,17);
            X := (36);
            Y := (17);
            Readln(N1);
            Validacion_Integer(N1,B,X,Y);
            obr.Peso := B;

            TextColor(Green);
            Gotoxy(39,19);
            X := (39);
            Y := (19);
            Readln(N1);
            Validacion_Integer(N1,B,X,Y);
            obr.Altura := B;

            TextColor(Green);
            Gotoxy(37,21);
            Readln(obr.Completo);

            TextColor(Green);
            Gotoxy(34,23);
            X := (34);
            Y := (23);
            Readln(N1);
            Validacion_Integer(N1,B,X,Y);
            obr.partes := B;

            TextColor(Green);
            Window(3,26,60,28);
            Gotoxy(27,25);
            X := (27);
            Y := (23);
            Readln(obr.Descripcion);
            Window(1,1,120,35);

            TextColor(Green);
            Gotoxy(34,30);
            Readln(N_Art);
            // Leemos el Nombre del Artista
            obr.Artista := N_Art;

            TextColor(Green);
            Gotoxy(32,32);
            Readln(N_Mus);
            // Leemos el Nombre del Museo

            obr.Nombre_Museo := N_Mus;
            obr.activo := True;

            GuardarO(Obras,obr);
            CerrarO(Obras);

            burbujaO(Obras);

            Aviso_Carga_Exitosa();

            // Carga de Obra Finalizada

            Buscar_Artista(Artistas, pos, N_Art, Artist);
            // Busqueda del artista de la obra para ver si necesita ser cargado

            If (pos = -1) Then // Luego de Buscar... El Artista Existe?
			Begin
				Aviso_Artista_Inexistente;
				MCargar_ART(Artistas); // VARIABLE cc YA NO ES NECESARIA
            End;
            
            Buscar_Museo_Nombre (Museos, pos, N_Mus, Mus);


            // Busqueda del museo que posee la obra para ver si necesita ser cargado

            If (pos = -1) Then // Si el museo no existe
			Begin
				Aviso_Museo_Inexistente;
				MCargar_MUS(Museos, Directores);
			End;
        End
    Else // Si la obra ya existe
        Begin
			restaurar := 'n';
            Aviso_Dato_Existente();
            AbrirO(Obras);
            LeerO(Obras, Obr, Pos);
            If (obr.Activo = False) Then // Si la obra esta dada de baja
                Begin
                    Aviso_Dato_Oculto();
                    Repeat
                        // Solo se puede ingresar S, s o N, n
                        restaurar := readkey;
                    Until (restaurar = 'N') Or (restaurar ='n') Or (restaurar =
                          'S') Or (restaurar ='s');

                    If (restaurar ='S') Or (restaurar ='s') Then
                        // El usuario quiere restaurar el archivo?
                        Begin
                            clrscr;
                            obr.Activo := True;
                            ModificarO(Obras, obr, pos);
                            Aviso_Restauracion_Exitosa;
                            CerrarO(Obras);
                        End;
                End
            Else // Si la obra existe pero no se la da de alta
                CerrarO(Obras);
            // Cierra el archivo, no se modifica nada y se vuelve al menu.
        End;
End;

Procedure MCargar_ART(Var Artistas:Archivo_Artistas);
Var
    Pos:   int64;
    Nombre, DNI :   String;
    restaurar :   char;

Begin
    Pos := -1;
    Menu_Cargar_Artista_Part1;
    TextColor (Green);
    Gotoxy (34,6);
    Readln (Nombre);
    Buscar_Artista(Artistas, Pos, Nombre, Artist);
    // Busqueda del Artista en el Archivo
		If (Pos = -1) Then
        Begin
            Menu_Cargar_Artista_Part2;
            AbrirA(Artistas);
            Artist.Nombre := Nombre;
            Artist.Activo := True;
            TextColor(Green);
            Gotoxy (31,8);
            Readln (DNI);
            Validacion_Integer(DNI, Artist.DNI, 31, 8);
            Gotoxy (37,10);
            Readln (Artist.Direccion);
            Gotoxy (35,12);
            Readln (Artist.Fecha_Nacimiento);
            GuardarA(Artistas,Artist);
            Aviso_Carga_Exitosa;
            CerrarA(Artistas);
            burbujaA(Artistas);
        End
    Else
	Begin
		Clrscr;
		Aviso_Dato_Existente;
		AbrirA(Artistas);
		LeerA(Artistas, artist, Pos);
			If (Artist.Activo = False) Then
			Begin
				Aviso_Dato_Oculto;
				Repeat
					restaurar := readkey;
				Until (restaurar = 'N') Or (restaurar ='n') Or (restaurar = 'S') Or (restaurar ='s');
				If (restaurar ='S') Or (restaurar ='s') Then
					Begin
						Clrscr;
						Artist.Activo := true;
						ModificarA(Artistas,Artist,pos);
						Aviso_Restauracion_Exitosa;
					End;
			End;
		CerrarA(Artistas);
	End;
End;

Procedure MCargar_MUS(Var Museos:Archivo_Museos; Var Directores:Archivo_Directores); // Menu de Carga de museos Nuevos (Funcionando)
Var
    Mus :   Museo;
    X, Y :   integer;
    restaurar :   Char;
    Direct2 :   Director;
    pos, Code, B :   Int64;
    Name, Busc2, N1 :   String;

Begin
    Menu_Cargar_Museo; // Dibuja la interfaz
    Gotoxy (32,6);
    TextColor (Green);
    Readln (Name); // Nombre
    Buscar_Museo_Nombre(Museos, pos, Name, Mus);
    If (pos = -1) Then // Si el nombre no existe en el archivo
        Begin

            Repeat
                Code := Random(4294967295);
                // Codigo (debe ser de asignacion automatica)
                Buscar_Museo_Codigo(Museos, pos, Code, Mus);
                // Se busca si el codigo esta en uso
            Until (pos = -1);

            AbrirM(Museos);
            Gotoxy (29,8);
            Writeln (Code);
            Mus.Codigo := Code;
            Mus.Nombre := Name;
            TextColor (Green);

            Gotoxy (31,10);
            Readln (Mus.Calle);
            // Calle
            Gotoxy (32,12);
            Readln (Mus.Ciudad);
            // Ciudad
            Gotoxy (30,14);
            Readln (Mus.Pais);
            // Pais
            Gotoxy (24,16);
            Readln (N1);
            //Telefono
            X := 24;
            Y := 16;
            Validacion_Integer(N1,B,X,Y);
            Mus.Telefono := B;
            //Almacenamiento del Telefono

            Gotoxy (34,18);
            Readln (Busc2);
            // Nombre Director
            Mus.Name_Director := Busc2;
            //Almacenamiento del Nombre del Director

            Mus.activo := true;
            // Estado
            GuardarM (Museos,Mus);
            // Guardar registro en el archivo
            CerrarM (Museos);
            // Cerrar archivo museo

            burbujaM(Museos);

            Aviso_Carga_Exitosa();
            Buscar_Director (Directores, Pos, Busc2, Direct2);


            // Busco si el Director relacionado a este museo que estoy cargndo Existe en el Archivo de Directores.
            //Busqueda del director
            If (Pos = -1) Then
                // Si el Director no existe lo cargo, sino solo se sale
                Begin
                    Aviso_Director_Inexistente;
                    MCargar_Director(Directores);
                End;
        End
    Else // aviso de museo existente
        Begin
            Clrscr;
            Aviso_Dato_Existente;
            AbrirM(Museos);
            LeerM(Museos,Mus,Pos);
            If (Mus.Activo = False) Then
                Begin
                    Aviso_Dato_Oculto;
                    Repeat
                        restaurar := readkey;
                    Until (restaurar = 'N') Or (restaurar ='n') Or (restaurar =
                          'S') Or (restaurar ='s');

                    If (restaurar ='S') Or (restaurar ='s') Then
                        Begin
                            Clrscr;
                            Mus.Activo := True;
                            ModificarM(Museos,Mus,Pos);
                            Aviso_Restauracion_Exitosa;
                            CerrarM(Museos);
                        End;
                End;
            CerrarM(Museos);
        End;
End;

Procedure MCargar_Director(Var Directores:Archivo_Directores);
Var
    pos :   Int64;
    Name, DNI :   String;
    restaurar :   char;
    Direct :   Director;

Begin
    Menu_Cargar_Director_Part1;
    TextColor (Green);
    Gotoxy (34,6);
    Readln(Name);
    Buscar_Director (Directores, pos, Name, Direct);
    //busqueda en el archivo
    If (pos = -1) Then
        Begin
            //si los datos no existen
            AbrirD (Directores);
            //apertura del archivo
            Direct.ApyNom := Name;
            Direct.Activo := True;
            Menu_Cargar_Director_Part2;
            TextColor (Green);
            Gotoxy (33,8);
            Readln (DNI);
			Validacion_Integer(DNI, Direct.DNI, 33, 8);
            Gotoxy (36,10);
            Readln (Direct.Direccion);
            Gotoxy (35,14);
            Readln (Direct.Periodo_Asignacion_Inic);
            Gotoxy (31,16);
            Readln (Direct.Periodo_Asignacion_Fin);
            Gotoxy (23,18);
            Readln (Direct.Telefono);
            GuardarD(Directores,Direct);
            Aviso_Carga_Exitosa();
            CerrarD (Directores);
            burbujaD(Directores); //(proboca problemas si se ejecuta, al parecer intenta leer mas alla del filesize)

        End
    Else // si los datos existen. aviso de datos existentes
        Begin
            Clrscr;
            Aviso_Dato_Existente;
            // muestra esto no c xq!
            AbrirD(Directores);
            LeerD(Directores, Direct, pos);
            If (Direct.Activo = False) Then
                Begin
                    Aviso_Dato_Oculto;
                    Repeat
                        restaurar := readkey;
                    Until (restaurar = 'N') Or (restaurar ='n') Or (restaurar =
                          'S') Or (restaurar ='s');

                    If (restaurar ='S') Or (restaurar ='s') Then
                        Begin
                            Clrscr;
                            Direct.Activo := True;
                            ModificarD(Directores,Direct,Pos);
                            Aviso_Restauracion_Exitosa;
                            CerrarD(Directores);
                        End;
                End
            Else
                CerrarD(Directores);
        End;
End;

Procedure MBajar_Art(Var Artistas:Archivo_Artistas);
//Estas son las bajas

Var
    Pos :   int64;
    Nombre :   String;
    artist :   Artista;

Begin
    Menu_Baja_Artista(Nombre);
    Buscar_Artista(Artistas,Pos,Nombre,artist);
    If (Pos <> -1) Then
        Begin
            AbrirA(Artistas);
            LeerA(Artistas,artist,Pos);


            //llamar a la funcion leer de la unit Artista (controlar si los parametros estan bien puestos)
            If (artist.Activo=True) Then
                Begin
                    artist.Activo := False;
                    ModificarA(Artistas,artist,pos);


                    //llamar a la funcion modificar de la unit Artista (controlar si los parametros estan bien puestos)
                    Aviso_Eliminacion_Exitosa();
                    CerrarA(Artistas);
                End
            Else
                Begin
                    If (artist.Activo=False) Then
                        Begin
                            CerrarA(Artistas);
                            Menu_Baja_Artista_Inexistente();
                            Readkey;
                        End;
                End;
        End
    Else
        Begin
            Menu_Baja_Artista_Inexistente();
            Readkey;
        End;
    Clrscr;
End;

Procedure MBajar_Dir(Var Directores:Archivo_Directores);

Var
    Pos :   int64;
    Name :   String;
    direct :   Director;

Begin
    Menu_Baja_Director(Name);
    Buscar_Director(Directores, Pos, Name, direct);
    If (Pos <> -1) Then
        Begin
            AbrirD(Directores);
            LeerD(Directores, direct, Pos);


            //llamar a la funcion leer de la unit Directores (controlar si los parametros estan bien puestos)
            If (direct.Activo = True) Then
                Begin
                    direct.Activo := False;
                    ModificarD(Directores, direct, pos);


                    //llamar a la funcion modificar de la unit Director (ahora si esta bien)
                    Aviso_Eliminacion_Exitosa();
                End
            Else
                Begin
                    If (direct.Activo=False) Then
                        Begin
                            Menu_Baja_Director_Inexistente();
                            Gotoxy (65,9);
                            Writeln(Name);
                            readkey;
                        End;
                End;
            CerrarD(Directores);
        End
    Else
        Begin
            Menu_Baja_Director_Inexistente;
            readkey;
        End;
    Clrscr;
End;

Procedure MBajar_Mus(Var Museos:Archivo_Museos);
//Estas son las bajas

Var
    Pos :   int64;
    Mus :   Museo;
    Nombre :   String;

Begin
    Menu_Baja_Museo(Nombre);
    Buscar_Museo_Nombre(Museos, Pos, Nombre, Mus);
    If (Pos <> -1) Then
        Begin
            AbrirM(Museos);
            LeerM(Museos, Mus, Pos);


            //llamar a la funcion leer de la unit Museos (controlar si los parametros estan bien puestos)
            If (Mus.Activo = True) Then
                Begin
                    Mus.Activo := False;
                    ModificarM(Museos, mus, pos);


                    //llamar a la funcion modificar de la unit Artista (controlar si los parametros estan bien puestos)
                    Aviso_Eliminacion_Exitosa();
                    CerrarM(Museos);
                End
            Else
                Begin
                    If (Mus.Activo = False) Then
                        Begin
                            Menu_Baja_Museo_Inexistente;
                            Readkey;
                        End;
                End;
        End
    Else
        Begin
            Menu_Baja_Museo_Inexistente;
            Readkey;
        End;
    Clrscr;
End;

Procedure MBajar_obr(Var Obras:Archivo_Obras);
//Estas son las bajas

Var
    Obr :   Obra;
    Pos :   int64;
    Nombre :   String;

Begin
    Menu_Baja_Obra (Nombre);
    Buscar_Obra_Nombre (Obras, Pos, Nombre, Obr);
    If (Pos <> -1) Then
        Begin
            AbrirO(Obras);
            // Apertura del Archivo Obras
            LeerO(Obras, Obr, Pos);
            If (Obr.Activo = True) Then
                Begin
                    Obr.Activo := False;
                    ModificarO(Obras, obr, pos); // Se modifica la variable Activo de la Obra
                    CerrarO(Obras); // Cierre del Archivo Obras
                    Aviso_Eliminacion_Exitosa();
                End
            Else
                Begin
                    If (Obr.Activo = False) Then
                        Begin
                            Menu_Baja_Obra_Inexistente;
                            Readkey;
                            CerrarO(Obras);
                            // Cierre del Archivo Obras
                        End;
                End;
        End
    Else
        Begin
            Menu_Baja_Obra_Inexistente;
            Readkey;
        End;
    Clrscr;
End;

Procedure MModificar_Artista(Var Artistas:Archivo_Artistas);

Var
    Opc :   char;
    artist :   Artista;
    N1, Bus:   String;
    Pos, Num :   int64;

Begin
    Menu_Editar_Artista_Part1(Bus);
    Buscar_Artista(Artistas, Pos, Bus, artist);
    If (Pos <> -1) Then
        Begin
            AbrirA(Artistas);
            LeerA(Artistas, artist, Pos);
            If (artist.Activo <> false) Then
                Begin
                    Dato_Encontrado_Artista;
                    Repeat // el Repeat y el Until se utiliza para mostrar los datos de aca abajo hasta que se apriete una de las opciones (1,2,3,a)
                        Gotoxy(1,1);
                        Menu_Editar_Artista_Part2;
                        TextColor(Green);
                        Gotoxy (8,4);
                        Writeln (artist.DNI);
                        Gotoxy (11,6);
                        Writeln (artist.Nombre);
                        Gotoxy (14,8);
                        Writeln (artist.Direccion);
                        Gotoxy (24,10);
                        Writeln (artist.Fecha_Nacimiento);
                        Gotoxy (3,14);
                        Opc := Readkey;
                        TextColor(Blue);
                        Case Opc Of
                            '1':
                                   Begin
                                       Gotoxy (3,14);
                                       Writeln('D.N.I.: ');
                                       Gotoxy (11,14);
                                       TextColor(Green);
                                       Readln(N1);
                                       X := 3;
                                       Y := 14;
                                       Validacion_Integer2(N1,Num,X,Y);
                                       // valida que el dni sea un numero
                                       Artist.DNI := Num;
                                       ModificarA(Artistas,artist,pos);





                     //llamar a la funcion modificar de la unit Artista (controlar si los parametros estan bien puestos)
                                   End;

                            '2':
                                   Begin
                                       Gotoxy (3,14);
                                       Writeln ('Nombre: ');
                                       Gotoxy (11,14);
                                       TextColor(Green);
                                       Readln(Artist.Nombre);
                                       ModificarA(Artistas,artist,pos);





                     //llamar a la funcion modificar de la unit Artista (controlar si los parametros estan bien puestos)
                                   End;

                            '3':
                                   Begin
                                       Gotoxy (3,14);
                                       Writeln ('Direccion: ');
                                       Gotoxy (14,14);
                                       TextColor(Green);
                                       Readln(artist.Direccion);
                                       ModificarA(Artistas,artist,pos);





                     //llamar a la funcion modificar de la unit Artista (controlar si los parametros estan bien puestos)
                                   End;
                            '4':
                                   Begin
                                       Gotoxy (3,14);
                                       Writeln ('Fecha de Nacimiento: ');
                                       Gotoxy (24,14);
                                       TextColor(Green);
                                       Readln(artist.Fecha_Nacimiento);
                                       ModificarA(Artistas,artist,pos);
                                   End;
                        End;
                    Until (Opc='0');
					 CerrarA(Artistas);
					 Aviso_Edicion_Exitosa;
                End
            Else
                Begin
                    CerrarA(Artistas);
                    Aviso_Dato_Inexistente();
                End;
        End
    Else
        Begin
            Aviso_Dato_Inexistente;
        End;
End;

Procedure MModificar_Museo(Var Museos:Archivo_Museos);

Var
    Pos :   int64;
    mus :   Museo;
    Opc :   char;
    Bus :   String;

Begin
    Menu_Editar_Museo_Part1(Bus);
    // modificar cartel para capturar el dato (ya)
    TextColor(Green);
    Buscar_Museo_Nombre (Museos, Pos, Bus, mus);
    If (Pos <> -1) Then
        Begin
            AbrirM(Museos);
            LeerM(Museos, mus, Pos);
            If (mus.Activo <> false) Then
                Begin
                    Dato_Encontrado_Museo;
                    Repeat
                        Menu_Editar_Museo_Part2;
                        TextColor(Green);
                        Gotoxy(11,4);
                        Writeln (mus.Codigo);
                        Gotoxy(11,6);
                        Writeln (mus.Nombre);
                        Gotoxy(24,8);
                        Writeln (mus.Name_Director);
                        Gotoxy(10,10);
                        Writeln (mus.Calle);
                        Gotoxy(11,12);
                        Writeln (mus.Ciudad);
                        Gotoxy(9,14);
                        Writeln (mus.Pais);
                        Gotoxy(13,16);
                        Writeln (mus.Telefono);
                        Gotoxy(1,1);
                        Opc := Readkey;
                        Case Opc Of
                            '1':
                                   Begin
                                       Cuadro_Edicion_Museo();
                                       Writeln('Nombre del Director del Museo: ',mus.Name_Director);
                                       Readln(mus.Name_Director);
                                       ModificarM(Museos,mus,pos);
                                       Window(1,19,76,23);
                                       Clrscr;
                                       Window(1,1,120,80)
                                   End;

                            '2':
                                   Begin
                                       Cuadro_Edicion_Museo();
                                       Writeln('Nombre del Museo: ', mus.Nombre);
                                       Readln(mus.Nombre);
                                       ModificarM(Museos,mus,pos);
                                       Window(1,19,76,23);
                                       Clrscr;
                                       Window(1,1,120,80)
                                   End;

                            '3':
                                   Begin
                                       Cuadro_Edicion_Museo();
                                       Writeln('Telefono del Museo: ', mus.Telefono);
                                       Readln(mus.Telefono);
                                       ModificarM(Museos,mus,pos);
                                       Window(1,19,76,23);
                                       Clrscr;
                                       Window(1,1,120,80)
                                   End;

                            '4':
                                   Begin
                                       Cuadro_Edicion_Museo();
                                       Writeln('Direccion del Museo: ', mus.Calle);
                                       Readln(mus.Calle);
                                       ModificarM(Museos,mus,pos);
                                       Window(1,19,76,23);
                                       Clrscr;
                                       Window(1,1,120,80)
                                   End;

                            '5':
                                   Begin
                                       Cuadro_Edicion_Museo();
                                       Writeln('Pais en el que se encuentra el Museo: ', mus.Pais);
                                       Readln(mus.Pais);
                                       ModificarM(Museos,mus,pos);
                                       Window(1,19,76,23);
                                       Clrscr;
                                       Window(1,1,120,80)
                                   End;

                            '6':
                                   Begin
                                       Cuadro_Edicion_Museo();
                                       Writeln('Ciudad en la que se encuentra el Museo: ', mus.Ciudad);
                                       Readln(mus.Ciudad);
                                       ModificarM(Museos,mus,pos);
                                       Window(1,19,76,23);
                                       Clrscr;
                                       Window(1,1,120,80)
                                   End;
                        End;
                    Until (Opc='0');
                    Aviso_Edicion_Exitosa();
                End
            Else
                Aviso_Dato_Inexistente();
			CerrarM(Museos);
        End
    Else
        Begin
            Aviso_Dato_Inexistente();
        End;
End;

Procedure MModificar_Director(Var Directores:Archivo_Directores);

Var
    Bus :   String;
    Pos :   int64;
    direct :   Director;
    Opc, Opc2 :   char;


Begin
    Menu_Editar_Director_Part1(Bus);
    Buscar_Director(Directores, Pos, Bus, direct);
    If (Pos <> -1) Then
        Begin
            AbrirD(Directores);
            LeerD(Directores, direct, Pos);
            If (direct.Activo = True) Then
                Begin
                    Dato_Encontrado_Director;
                    Repeat
                        Clrscr;
                        Menu_Editar_Director_Part2();
                        TextColor(Green);
                        Gotoxy (11,4);
                        Writeln (direct.APyNom);
                        Gotoxy (11,6);
                        Writeln (direct.DNI);
                        Gotoxy (14,8);
                        Writeln (direct.Direccion);
                        Gotoxy (13,11);
                        Writeln (direct.Periodo_Asignacion_Inic);
                        Gotoxy (43,11);
                        Writeln (direct.Periodo_Asignacion_Fin);
                        Gotoxy (25,13);
                        Writeln (direct.Telefono);
                        Opc := readkey;
                        Case Opc Of
                            '1':Begin
                                 Menu_Editar_Director_Part3();
                                 Gotoxy(1,1);
                                 Opc2 := Readkey;
                                   Case Opc2 Of
                                       '1': Begin
                                             TextColor(Green);
                                             Gotoxy (3,15);
                                             Writeln ('Escriba la Fecha de Inicio del Periodo: ');
                                             TextColor(Green);
                                             Readln(direct.
                                             Periodo_Asignacion_Inic);
                                             ModificarD(Directores,direct,pos); //llamar a la funcion modificar de la unit Directores (controlar si los parametros estan bien puestos)
                                             Aviso_Edicion_Exitosa();
                                            End;

                                       '2': Begin
                                             TextColor(Green);
                                             Gotoxy (3,15);
                                             Writeln ('Escriba la Fecha Final del Periodo: ');
                                             TextColor(Green);
                                             Readln(direct.Periodo_Asignacion_Fin);
                                             ModificarD(Directores,direct,pos);
                                             Aviso_Edicion_Exitosa();
                                            End;

                                    End;

                                End;

                            '2':Begin
                                 TextColor(Green);
                                 Gotoxy (3,15);
                                 Writeln ('Escriba el Nombre del Director: ');
                                 TextColor(Green);
                                 Readln(direct.APyNom);
                                 ModificarD(Directores,direct,pos);//llamar a la funcion modificar de la unit Directores (controlar si los parametros estan bien puestos)
                                 Aviso_Edicion_Exitosa();
                                End;

                            '3':Begin
                                 TextColor(Green);
                                 Gotoxy (3,15);
                                 Writeln ('Escriba la Direccion del Director: ');
                                 TextColor(Green);
                                 Readln(direct.Direccion);
                                 ModificarD(Directores,direct,pos);//llamar a la funcion modificar de la unit Directores (controlar si los parametros estan bien puestos)
                                 Aviso_Edicion_Exitosa();
                                End;

                            '4':Begin
                                 TextColor(Green);
                                 Gotoxy (3,15);
                                 Writeln ('Escriba el Numero de Telefono del Director: ');
                                 TextColor(Green);
                                 Readln(direct.Telefono);
                                 ModificarD(directores,direct,pos);
                                 Aviso_Edicion_Exitosa();
                                End;
                        End;
                    Until (Opc='0');
                End
            Else
             Aviso_Dato_Inexistente();
         CerrarD(Directores);
        End
    Else
        Begin
            Aviso_Dato_Inexistente();
        End;
End;

Procedure MModificar_Obra(Var Obras:Archivo_Obras);

Var
    obr :   Obra;
    Pos, Aux :   int64;
    Opc, N1, Bus :   String; //Variable de opciones y variable para verificacion de string/integer

Begin
    Menu_Editar_Obra_Part1(Bus); // modificar para capturar el dato (ya)
    Buscar_Obra_Nombre(Obras, Pos, Bus, obr); //Obras (el archivo) pos(posicion del registro de la obra en el archivo) Bus(codigo de la obra que se busca) obr(registro de la obra buscada)
    If (Pos <> -1) Then
        Begin
            AbrirO(Obras);
            LeerO(Obras, obr, Pos); //Obras(el archivo) registro(del archivo) y posicion del registro en el archivo
            If (obr.Activo <> false) Then
                Begin
                    Dato_Encontrado_Obra;
                    Repeat
                        Gotoxy(1,1);
                        Menu_Editar_Obra_Part2();
                        TextColor(Green);
                        Gotoxy (12,4);
                        Writeln (obr.Artista);
                        Gotoxy (9,6);
                        Writeln (obr.Peso:4:2);
                        Gotoxy (29,6);
                        Writeln (obr.Altura);
                        Gotoxy (51,6);
                        Writeln (obr.Completo);
                        Gotoxy (63,6);
                        Writeln (obr.Partes);
                        Gotoxy (9,8);
                        Writeln (obr.Tipo);
                        Gotoxy (13,10);
                        Writeln (obr.Material);
                        Gotoxy (11,12);
                        Writeln (obr.Estilo);
                        Gotoxy (9,14);
                        Writeln (obr.Anio);
                        Window (16,16,67,19);
                        Gotoxy (16,16);
                        Writeln (obr.Descripcion);
                        Window (1,1,120,35);
                        Gotoxy (11,22);
                        Writeln (obr.Codigo_Obra);
                        Gotoxy (43,22);
                        Writeln (obr.Nombre_Museo);
                        Gotoxy (70,16);
                        Cuadro_Edicion_Obra();
                        Readln(Opc);
                        Clrscr;
                        Case Opc Of
                            '1':
                                   Begin
                                       Writeln('Descripcion: ');
                                       Gotoxy (70,17);
                                       Readln(obr.Descripcion);
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
									   Window (1,1,120,35);




                       //llamar a la funcion modificar de la unit Obras (controlar si los parametros estan bien puestos)
                                   End;
                            '2':
                                   Begin
                                       Writeln('Tipo: ');
                                       Gotoxy (70,17);
                                       Readln(obr.Tipo);
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                   End;
                            '3':
                                   Begin
                                       Writeln('Material: ');
                                       Gotoxy (70,17);
                                       Readln(obr.Material);
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                    End;
                            '4':
                                   Begin
                                       Writeln('Estilo: ');
                                       Gotoxy (70,17);
                                       Readln(obr.Estilo);
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                   End;
                            '5':
                                   Begin
                                       Writeln('Altura: ');
                                       Gotoxy (70,17);
                                       Readln(N1);
                                       Validacion_Int_Edicion_Obras(N1, Aux);
                                       obr.Altura := Aux;
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                   End;
                            '6':
                                   Begin
                                       Writeln('Peso: ');
                                       Gotoxy (70,17);
                                       Readln(N1);
                                       Validacion_Int_Edicion_Obras(N1, Aux);
                                       obr.Peso := Aux;
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                   End;
                            '7':
                                   Begin
                                       Writeln('Completo: ');
                                       Gotoxy (70,17);
                                       Readln(obr.Completo);
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                   End;
                            '8':
                                   Begin
                                       Writeln('Partes: ');
                                       Gotoxy (70,17);
                                       Readln(N1);
                                       Validacion_Int_Edicion_Obras(N1, Aux);
                                       obr.Partes := Aux;
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                   End;
                            '9':
                                   Begin
                                       Writeln('Anio: ');
                                       Gotoxy (70,17);
                                       Readln(N1);
                                       Validacion_Int_Edicion_Obras(N1, Aux);
                                       obr.Anio := Aux;
                                       Clrscr;
                                       ModificarO(Obras,obr,pos);
                                       Window (1,1,120,35);
                                   End;
                            '10':
                                    Begin
                                        Writeln('Nombre del Artista: ');
                                        Gotoxy (71,17);
                                        Readln(obr.Artista);
                                        Clrscr;
                                        ModificarO(Obras,obr,pos);
                                        Window (1,1,120,35);
                                    End;
                            '11':
                                    Begin
                                        Writeln('Codigo del Museo: ');
                                        Gotoxy (70,17);
                                        Readln(obr.Nombre_Museo);
                                        // Lectura del nombre del Museo
                                        Clrscr;
                                        ModificarO(Obras,obr,pos);
                                        Window (1,1,120,35);
                                    End;
                            '12':
                                    Begin
                                        Writeln('Codigo de la Obra: ');
                                        Gotoxy (70,17);
                                        Readln(N1);
                                        Validacion_Int_Edicion_Obras(N1, Aux);
                                        obr.Codigo_Obra := Aux;
                                        Clrscr;
                                        ModificarO(Obras,obr,pos);
                                        Window (1,1,120,35);
                                    End;
                        End;
                    Until (Opc='0') Or (Opc='00');
                    Window (1,1,120,35);
                    Aviso_Carga_Exitosa();
                End
            Else
                Aviso_Dato_Inexistente();
            CerrarO(Obras);
        End   
    Else
        Begin
            Aviso_Dato_Inexistente();
        End;
End;


{
Procedure Segun_Obra_Mostrar_Artista_Museo(var Obras:Archivo_Obras);
var
    Buscado:Integer;
    pos:Integer;
    obr:Obra;

Begin
    pos:=-1;
    Writeln('Ingrese el Codigo de la Obra: ');
    readln(Buscado);
    AbrirO(Obras);
    Buscar_Obras(Obras,pos,Buscado,obr);
    if pos<>-1 then
    Begin
        LeerO(Obras,obr,pos);
        Writeln('El Artista de la Obra ',Buscado,' es: ',obr.Artista);
        Writeln('El Codigo del Museo de la Obra ',Buscado,' es: ',obr.Codigo_Museo);
    End;
CerrarO(Obras);
End;


Procedure Segun_Museo_Mostrar_Director_Obras(var Museos:Archivo_Museos;Var Obras:Archivo_Obras);
var
    Buscado:Integer;
    pos:Integer;
    Mus:Museo;//El Record se llama Museo y el Archivo Museos,
    obr:Obra;

Begin
    pos:=-1;
    Writeln('Ingrese el Codigo del Museo: ');
    readln(Buscado);
    AbrirM(Museos);
    Buscar_Museo(Museos,pos,Buscado,Mus);
    if pos<>-1 then //con la posicion -1 digo que el Museo Existe
    Begin
        LeerM(Museos,Mus,pos);
        Writeln('El Director del Museo',Buscado,' es:',Mus.Director);
        AbrirO (Obras);
        Writeln('Las Obras del Museo son:');
        Buscar_Museo_en_Obras(Obras,Buscado,obr);
    End;
CerrarM(Museos);
CerrarO(Obras);
End;

}

Procedure Segun_ArtistaMOSTRARObras(var Obras:Archivo_Obras; var Artistas:Archivo_Artistas);
var
    artist :Artista;
    Obr :Obra;
    busc :String;
    pos :int64;

Begin
Menu_Estadistica_Dni_Artista(busc);
Buscar_Artista(Artistas, pos, busc, artist);
If (pos <> -1) then //si el artista existe
    Begin
     Clrscr;
     textcolor(green);
     Menu_Estadistica_ObrasdelAutor(busc); // cuadro grafico
     Buscar_Artista_en_Obras(Obras, busc, Obr, 66, 6); //busca en el archivo las obras del artista {busc}
     readkey;
     clrscr;
    End
    Else // si el artista no existe
        Begin
         Menu_Baja_Artista_Inexistente(); // Notifica que el artista buscado no existe {hay que modificarlo, no pega ni con la gotita xD}
         readkey;
        End;
End;

{ hay que borrar esto}


procedure Estadistica_Artistas_Obras(var ARCH_Artistas:Archivo_Artistas; var ARCH_Obras:Archivo_Obras);
var
	PunteroArt, Cant, Lim: Int64;
	Artista : String;
	
	// para control de la lista
	count : byte;
	pressed : char;

const
	y = 6; // fila de datos
	x = 37; // columna de artistas
	x2 = 85; // columna de cantidad

begin
AbrirA(ARCH_Artistas);
Lim := Filesize(ARCH_Artistas);
CerrarA(ARCH_Artistas);
PunteroArt := 0;
Count := 0;
	Repeat
		// Busqueda en archivos
		Artista:='';
		Secuencia_Artistas(ARCH_Artistas, Artista, PunteroArt); // Carga la variable artistas de forma consecutiva
		Secuencia_Obras(ARCH_Obras, Artista, Cant); // utiliza la variable Artista para encontrar la cantidad correspondiente de obras con esa Variable
		
		// Impresion en menu
		Gotoxy(x,(y+count));
		Writeln(Artista);
		Gotoxy(x2,(y+count)); 
		Writeln(Cant);
		Inc(count);
	Until (Lim = PunteroArt) or (count = 6);

	Repeat // La lista siguiente y anterior
		pressed := readkey;
		If (Lim > 25) then // solo ingresa si el archivo tiene mas de 25 registros
		Begin
			case (pressed) of // 1 artistas que siguen con sus obras - 2 artistas de la lista anterior 
				'1':Atras(ARCH_Artistas, ARCH_Obras, PunteroArt, Lim); // Archivos - Puntero - Tamaño
				'2':Adelante(ARCH_Artistas, ARCH_Obras, PunteroArt, Lim); // Archivos - Puntero - Tamaño
			End;
		End;
	Until (pressed = '0')
End;


Procedure Atras(var ARCH_Artistas:Archivo_Artistas; var ARCH_Obras:Archivo_Obras; var PunteroArt:int64; var Lim:Int64); // Archivos - Puntero - Tamaño
var
	Cant: Int64; // contador de obras
	Artista: String; // almacena el nombre de un artista
	count: byte; // cantidad de artistas mostrados en la lista

const
	y = 6; // fila de datos
	x = 37; // columna de artistas
	x2 = 85; // columna de cantidad

Begin
Menu_Estadistica_ObrasxAutor();
PunteroArt := (PunteroArt-25);
count := 0;
	Repeat
		// Busqueda en archivos
		Artista:='';
		Secuencia_Artistas(ARCH_Artistas, Artista, PunteroArt); // Carga la variable artistas de forma consecutiva
		Secuencia_Obras(ARCH_Obras, Artista, Cant); // utiliza la variable Artista para encontrar la cantidad correspondiente de obras con esa Variable
		
		// Impresion en menu
		Gotoxy(x,(y+count));
		Writeln(Artista);
		Gotoxy(x2,(y+count)); 
		Writeln(Cant);
		Inc(count);
	Until (PunteroArt=Lim) or (count=25);
End;

Procedure Adelante(var ARCH_Artistas:Archivo_Artistas; var ARCH_Obras:Archivo_Obras; var PunteroArt:int64; var Lim:Int64); // Archivos - Puntero - Tamaño
var
	Cant: Int64; // contador de obras
	Artista : String; // almacena el nombre de un artista
	count: byte; // para control de la lista

const
	y = 6; // fila de datos
	x = 37; // columna de artistas
	x2 = 85; // columna de cantidad

Begin
Menu_Estadistica_ObrasxAutor();
count :=0;
	Repeat
		// Busqueda en archivos
		Artista:='';
		Secuencia_Artistas(ARCH_Artistas, Artista, PunteroArt); // Carga la variable artistas de forma consecutiva
		Secuencia_Obras(ARCH_Obras, Artista, Cant); // utiliza la variable Artista para encontrar la cantidad correspondiente de obras con esa Variable
		
		// Impresion en menu
		Gotoxy(x,(y+count));
		Writeln(Artista);
		Gotoxy(x2,(y+count)); 
		Writeln(Cant);
		Inc(count);
	Until (PunteroArt=Lim) or (count=25);
End;

Procedure Segun_ObraMostrar(var Obras:Archivo_Obras);
var
	busc:string;
	pos:int64;

Begin
Menu_Estadistica_Dni_Artista(busc);
Buscar_Obra_Nombre(Obras, pos, busc, Obr);
Clrscr;
Obra_Museo_Artista(); //hacer parte grafica!!!! para ayer
TextColor(Blue);
Gotoxy(10,2);
writeln (Obr.Nombre); // Nombre de la Obra
gotoxy(11,4);
writeln (Obr.Nombre_Museo); // Nombre del Museo
gotoxy(11,6);
writeln (Obr.Artista); // Nombre del Artista
End;

{ hay que borrar esto}
{

Procedure ProcesarArchivos(var ARCH_Obras:Archivo_Obras; var ARCH_Artistas:Archivo_Artistas);
Var
	PunteroArt: Int64;
	Cont_Obras: Int64;
	Artista, Opc : String;
	ciclos, x, y : byte;
	
Begin
x:= 36;
y:= 6;
ciclos:= 0;
PunteroArt:= 1;
	Repeat
		Artista:='';
		Cont_Obras:= 0;
		Secuencia_Artistas(ARCH_Artistas, Artista, PunteroArt);
		
		readkey;
		
		Gotoxy(x,y); Writeln(Artista);
		Secuencia_Obras(Artista, Cont_Obras);
		Gotoxy(x,y); Writeln(Cont_Obras);
		inc(y);
		inc(ciclos);
		
		gotoxy(1,y); writeln(ciclos);
	Until (Filesize(ARCH_Artistas) = PunteroArt) or (ciclos = 25);
		 Opc:= Readkey;
		 
			Case (Opc) of
				'1':Begin // Vuelve a mostrar la lista de datos anterios, si es que la hay
					 clrscr;
					 Menu_Estadistica_ObrasxAutor();
					 ciclos:= 0;
					 if (PunteroArt >= 25) then // validacion para evitar overflow
						Begin
							PunteroArt := (PunteroArt - 25);
						End
						Else
							PunteroArt := 1;
						Repeat
							Cont_Obras:= 0;
							Secuencia_Artistas(Artistas, Artista, PunteroArt);
							Secuencia_Obras(Artista, Cont_Obras);
							Gotoxy(x,y); Writeln(Artista);
							Gotoxy(x,y); Writeln(Cont_Obras);
							inc(ciclos);
						Until (Filesize(ARCH_Artistas) = PunteroArt) or (ciclos = 25);
					End;
					
				'2':Begin // Muestra la lista de datos siguiente, si es que la hay.
					 clrscr;
					 Menu_Estadistica_ObrasxAutor();
					 ciclos:= 0;
						Repeat
							Cont_Obras := 0;
							Secuencia_Artistas(Artistas, Artista, PunteroArt);
							Secuencia_Obras(Artista, Cont_Obras);
							Gotoxy(x,y); Writeln(Artista);
							Gotoxy(x,y); Writeln(Cont_Obras);
							inc(ciclos);
						Until (Filesize(ARCH_Artistas) = PunteroArt) or (ciclos = 25);
					End;
				
				'3':Exit; // Sale de este procedimeinto y vuelve al menu de estadisticas
			End;
		Until (Opc='3');
	End;}
Begin
End.
