#Dev Store API
Backend de una tienda de productos con enlace externo


Dev store API, es una API para gestionar una pequeña tienda con productos y enlaces de tiendas externas, partiendo la estructura siguiente

 - Suppliers
Subministradores, diseñadores del producto

 - Stores
Tiendas donde se pueden econtrar los productos

 - Categories
Categorias de productos

 - Products
Productos disponibles

 - LinksProducts
Enlaces externos de las tienda por cada producto

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


##Configuración

Dentro del directorio app se encuenta el `settings.php` donde se debe definir el acceso al servidor SQL

```
'pdo' => [
    'dsn' => 'mysql:host=localhost;dbname=devstore;charset=utf8',
    'username' => 'root',
    'password' => ''
],
```

# End points

**Get last update**
Obtener la última modificación de un producto

`devstore/public/v1/status`


**Get all categories**
Obtener todas la categorias

`devstore/public/v1/categories`

**Get category by ID**
Obtener una categoria mediante su ID

`devstore/public/v1/categories/4`

**Get all available categories**
Obtener todas las categorias que están disponibles, campo `active` debe ser 1

`devstore/public/v1/categories?filter=active:eq[1]`

**Get all products**
Obtener todos los productos

`devstore/public/v1/products`

**Get a product by id**
Obtener un producto mediante su ID

`devstore/public/v1/products/2`

**Get only available products and sort bye reorder_level**
Obtener los productos disponibles y reordenados por nivel de aparición, campo `reorder_level`

`devstore/public/v1/products?filter=available:eq[1]&sort_by=reorder_level:asc`

**Get last products**
Obtener los 5 últimos productos de la tienda

`devstore/public/v1/products?filter=available:eq[1]&sort_by=ctime:desc&limit=5`

**Get all available products from category**
Obtener todos los productos disponibles de una categoria mediante el ID de categoria

`devstore/public/v1/products?filter=available:eq[1],category_id:eq[1]&sort_by=reorder_level:asc`

**Get all suppliers**
Obtener todos los subministradores de productos

`devstore/public/v1/suppliers`

**Get one supplier by ID**
Obtener un subministrador mediante su ID

`devstore/public/v1/suppliers/1`

**Get all available products compact output**
Obtener todos los productos disponibles, solamente los campos escenciales para mostrar un listado rápido

`devstore/public/v1/products/compact`

En caso se querer filtrar por una categoria

`devstore/public/v1/products/compact?filter=category_id:eq[1]`


**Get all store links from products**
Obtener todos los enlaces de los productos

`devstore/public/v1/productslinks`

**Get all store links from product_id**
Obtener todos los enlaces de un producto mediante su ID de producto

`devstore/public/v1/productslinks?filter=product_id:eq[2]`

# Assets
http://localhost/devstore/public/assets/geeksta_itsworksinmymachine.jpg
