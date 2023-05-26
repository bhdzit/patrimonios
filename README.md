# Centro de informacion

El Estado de Hidalgo se encuentra subdividido en diez regiones geográficas, La Huasteca, Sierre Gorda, Sierra Alta, Sierra Baja, Sierra De Tenango, Valle de Tulancingo, Altiplanicie Pulquera, Comarca Minera, Cuenca De México y Valle del Mezquital; siendo esta ultima la más grande y nuestra área estudio.

El Valle del Mezquital contiene 26 municipios con una área aproximada de 7000 km2, cuenta con un amplia riqueza cultural y natural que hace de esta zona con un gran potencial cultura, natural y turístico; por solo mencionar algunos casos, la zona arqueológica de Tula, el cerro del Xicuco, parques acuáticos, las Grutas de Tolantongo, el ex convento de Actopan, entre muchos otros sitios; sin embargo, hay lugares que no son tan conocidos o identificados por los habitantes o visitantes, ya sea por falta de difusión o divulgación, los cuales pueden ser susceptibles a ser considerados como patrimonio.



### Prerrequisitos

- Instalar [Flutter < 3.0.0][Flutter]
- Instalar [Android Studio][android]
- Instalar [Xcode][xcode] (Mac)

## Descripción del producto: 

App móvil que permite ver los diferente patromonios que tienes El Valle del Mezquital, caracteristicas he informacion como poder agendar visitas todo
desde tu smartphone o tablet.  

 <p >¿A quién va dirigido?</p>
 <p>Persona que busquen nuevas experiencias y conocer mas de sus patrimonos culturales.</p>
  <br>

### Principales funciones :


- **Login** <br> 
  Al entrar a la aplicacion mostrara una animacion de 10 segundo dicha animacion se presenta en `lib\splash.dart`, despues de este tiemp mostrara la pantalla de `Inicio de Sesion` que es el compoente `lib\login.dart`.

<p align="center">
  <a href="#">
    <img src="./login.gif" alt="CI status" />
  </a>&nbsp;

  </a>
</p>

- **Inicio** <br> 
  Tras iniciar sesion se mostrara la pantalla de Inicio que es el componete `lib\inicio.dart` dicho componente contiene una breve descripcion de lo que es de lo que es el patrimonio cultural, natural e inmatrial.

<p align="center">
  <a href="#">
    
  </a>&nbsp;

  </a>
</p>

- **Menu** <br> 
  Un menu de opciones se encuentra de lado derecho, dicho menu es el componente `lib\home.dart`, el componente contiene todas las posibles pantallas principales que se pueden ver como: 
   - **Lugares Culturales**
   - **Lugares Naturales**
   - **Lugares Inmateriales**
   - **Ruta**
   - **Vistas Agendadas**
   - **Acerca de**
   - **Contacto**
   - **Salir**

<p align="center">
  <a href="#">
    
  </a>&nbsp;

  </a>
</p>

- **Lugares Culturales** <br> 
  La pantalla Lugares culturales que es el componente `lib\cultural.dart` dicho componente contiene una lista de los lugares culturales, al hacer click sobre uno mostrara la pantalla de `Informacion del lugar`.

<p align="center">
  <a href="#">
    
  </a>&nbsp;

  </a>
</p>

- **Lugares Naturales** <br> 
  La pantalla Lugares naturales que es el componente `lib\natural.dart` dicho componente contiene una lista de los lugares naturales, al hacer click sobre uno mostrara la pantalla de `Informacion del lugar`.

<p align="center">
  <a href="#">
    
  </a>&nbsp;

  </a>
</p>

- **Lugares Inmateriales** <br> 
  La pantalla Lugares inmateriales que es el componente `lib\inmaterial.dart` dicho componente contiene una lista de los lugares inmateriales, al hacer click sobre uno mostrara la pantalla de `Informacion del lugar`.

<p align="center">
  <a href="#">
    
  </a>&nbsp;

  </a>
</p>

- **Informacion del lugar** <br> 
  La pantalla Informacion del lugar que es el componente `lib\utils\lugar_info.dart` depende de las pantallas Lugares Culturales, Lugares Naturales o Lugares Inmateriales, esta pantalla contiene la informacion del cual se le dio click en las pantallas anteriores, esta contiene la informaicon de:
  - **Ubicacion** <br> 
  - **Clima** <br> 
  - **Tempertura** <br> 
  - **Precipitacion Pluival** <br> 
  - **Sintesis** <br>

  Ademas de contar con las acciones de :
  - **Descargar Extenso** <br>
  El cual mostrara un PDF con toda la informacion del lugar 
  - **Agendar visita** <br>
  El cual mostrara una ventana con ls informacion para reservar un espacion en el calendario del usuario. 
  - **Perspectiva 3D** <br>
  Muestra Perspectiva 3D de Google Maps


<p align="center">
  <a href="#">
    
  </a>&nbsp;

  </a>
</p>




[flutter]: https://nodejs.org/
[android]: https://nodejs.org/
[xcode]: https://nodejs.org/