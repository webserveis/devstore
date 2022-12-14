#
# Dev Store API


Backend de una tienda de productos con enlace externo

## Estructura de la BD
Dev store API, es una API para gestionar una pequeña tienda con productos y enlaces de tiendas externas, partiendo la estructura siguiente

 - **Suppliers**
Subministradores, diseñadores del producto

 - **Stores**
Tiendas donde se pueden econtrar los productos

 - **Categories**
Categorias de productos


 - **Products**
Productos disponibles

 - **LinksProducts**
Enlaces externos de las tienda por cada producto

 - **Collections**
 Colleciones, Promociones de productos
 
 **Observaciones**
 
 - Las categorias tienen un campo `active` para activar o desactivar los productos de esa categoria.
 - Los productos tienen un campo `available` para desactivar un producto en concreto
 - Un producto, puede tener varios enlaces de tiendas externos
 - para establecer el orden de aparición de un producto usar `reorder_level`

# Instalar

## Base de datos, tablas y datos

Para crear la BD en el directorio install, se puede encontrar el script de instalación:

Editar el archivo `make.py` con los datos de conexión al servidor SQL, luego
```python make.py``` o bien importar los archivos `sql_script\dev_store_db.sql` y `sql_script\dev_store_data.sql`

## Instalar DevStore API

### Localmente
Para instalar la devstore se hace mediante compose

```compose update```

### Remotamente
Usar ftp para subir los archvivos

## Configuración

Dentro del directorio app se encuenta el `settings.php` donde se debe definir el acceso al servidor SQL

```
'pdo' => [
    'dsn' => 'mysql:host=localhost;dbname=devstore;charset=utf8',
    'username' => 'root',
    'password' => ''
],
```


# End points
Uris disponibles para la obtención de recursos

`GET devstore/public/v1/status` Obtener la última modificación de un producto.

`GET devstore/public/v1/categories` Obtener todas la categorias.

`GET devstore/public/v1/suppliers` Obtener todos los subministradores de productos.

`GET devstore/public/v1/stores` Obtener las tiendas externas.

`GET devstore/public/v1/products` Obtener todos los productos.

`GET devstore/public/v1/productslinks` Obtener los enlaces de la adquisición de los productos.

`GET devstore/public/v1/products/compact`
Obtener todos los productos disponibles, solamente los campos escenciales para mostrar un listado rápido.


## Filtrado y operadores de consulta

Para obtener un recurso único se puede proporcionar el id del recurso como parte de la ruta URI.

`GET devstore/public/v1/categories/4` devolverá el recurso único que corresponde con su identificador 4

**Filtrar con operadores**
También se puede usar parámetros de consulta para filtrar y obtener colecciones de recursos, usando el parametro `filter` especificando el nombre del campo el operador y el valor `?filter=field:operator:[value]`, por ejemplo:

`GET devstore/public/v1/categories?filter=active:eq[1]` devolverá listado de las categorias activas.

Se puede combinar diferentes filtros, separados por el delimitador `,`. 

`GET devstore/public/v1/products?filter=available:eq[1],category_id:eq[4]` Obtener todos los productos disponibles de una categoría concreta.

**Operadores**
Los operadores que se pueden usar en filtro de datos
 - eq: equals
 - ne: not equal
 -  lt: less than
 -  le: less than or equal
 -  gt: greater than
 -  ge: greater than or equal
 -  in: including
 -  co: like

## Ordanamiento
La colección de datos se puede ordenar por un campo o varios campos de modo ascendente o descedente, para indicar se usa el parámetro `sort_by`

`GET devstore/public/v1/products?sort_by=reorder_level:asc` para obtener los productos ordenados por `reorder_level`


## Paginación

La paginación basada en el desplazamiento se utiliza los parámetros de consulta de desplazamiento y límite para paginar los elementos de una colección.

El parámetro de `limit` controla el número máximo de elementos que se pueden devolver para una sola solicitud. Este parámetro se puede considerar como el tamaño de la página. Si no se especifica ningún límite, el sistema establece un límite predeterminado de 25 resultados por solicitud. El valor límite máximo válido es 100.

El parámetro `offset` establece la primera posición que se devolverá a partir de los resultados de la consulta. El valor predeterminado es 0, que inicia la página en el primer resultado. El valor de desplazamiento máximo válido es 9999.

`GET devstore/public/v1/products?limit=10` para obtener 10 productos.

`GET devstore/public/v1/products?limit=10&offset=10` para obtener los 10 siguientes productos.



## Tipos de datos de fecha

Las fechas se representan con el formato EDM (2019-02-12T00:00:00): cuando especifica una fecha como "AAAA-MM-DD", la API interpreta como "AAAA-MM-DDT00:00:00". Asegúrese de que el mes y el día tengan dos dígitos, MM y DD.

## Combinaciónes útiles

`GET devstore/public/v1/categories?filter=active:eq[1]` Obtener todas las categorias que están disponibles, campo `active` debe ser 1

`GET devstore/public/v1/products?filter=available:eq[1]&sort_by=reorder_level:asc`
Obtener los productos disponibles y reordenados por nivel de aparición, campo `reorder_level`

`GET devstore/public/v1/products?filter=available:eq[1]&sort_by=ctime:desc&limit=5`
Obtener los 5 últimos productos de la tienda.

`GET devstore/public/v1/products?filter=available:eq[1],category_id:eq[1]&sort_by=reorder_level:asc`
Obtener todos los productos disponibles de una categoria mediante el ID de categoria.

`GET devstore/public/v1/productslinks?filter=product_id:eq[2]`
Obtener todos los enlaces de un producto mediante su ID de producto

`GET devstore/public/v1/products/compact?filter=category_id:eq[1]` Obtener todos los productos disponibles, en formato compacto de una categoría concreta.

# Assets
Las imágenes, recursos etc... se encuentran en el directorio `assets`
`http://localhost/devstore/public/assets/geeksta_itsworksinmymachine.jpg`


# Fix

archivo `devstore\vendor\faapz\pdo\src\Clause\Limit.php`

```php
public function getValues(): array
{
    $values = [$this->size];
    if ($this->offset !== null) {
        $values[] = $this->offset;
    }

    //return $values;
    return [];
}

public function __toString(): string
{
    $sql = 'LIMIT ' . $this->size;
    if ($this->offset !== null) {
        $sql .= ' OFFSET '. $this->offset;
    }

    return $sql;
}

```


//https://learn.microsoft.com/en-us/power-bi/collaborate-share/service-url-filters
//https://developer.box.com/guides/api-calls/pagination/offset-based/
//https://stackoverflow.com/questions/40618327/how-to-design-generic-filtering-operators-in-the-query-string-of-an-api