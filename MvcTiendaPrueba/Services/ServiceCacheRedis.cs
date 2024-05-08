using MvcTiendaPrueba.Helpers;
using MvcTiendaPrueba.Models;
using Newtonsoft.Json;
using StackExchange.Redis;

namespace MvcTiendaPrueba.Services
{
    public class ServiceCacheRedis
    {
        private IDatabase database;
        public ServiceApiTienda service;
        private IHttpContextAccessor httpContextAccessor;


        public ServiceCacheRedis(ServiceApiTienda service, IHttpContextAccessor httpContextAccessor)
        {
            this.database =
                HelperCacheMultiplexer.Connection.GetDatabase();
            this.service = service;
            this.httpContextAccessor = httpContextAccessor;
        }

        //METODO PARA ALMACENAR PRODUCTOS
        public async Task AddProductoFavoritoAsync(Producto producto)
        {
            
            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {
                Usuario usuario = await this.service.GetPerfilUsuarioAsync();
                string jsonProductos = await
                this.database.StringGetAsync("favoritos" + "_" + usuario.IdUsuario);
                List<Producto> productosList;
                if (jsonProductos == null)
                {
                    //NO TENEMOS FAVORITOS TODAVIA, CREAMOS LA COLECCION
                    productosList = new List<Producto>();
                }
                else
                {
                    //YA TENEMOS FAVORITOS EN CACHE Y LOS RECUPERAMOS
                    productosList =
                        JsonConvert.DeserializeObject<List<Producto>>
                        (jsonProductos);
                }
                //INCLUIMOS EL NUEVO PRODUCTO
                productosList.Add(producto);
                //SERIALIZAMOS LA COLECCION CON LOS NUEVOS DATOS DE NUEVO
                jsonProductos = JsonConvert.SerializeObject(productosList);
                //ALMACENAMOS LOS NUEVOS DATOS EN AZURE CACHE REDIS
                await this.database.StringSetAsync
                    ("favoritos" + "_" + usuario.IdUsuario, jsonProductos);
            }
            else
            {
                Console.WriteLine("Usuario no autenticado");
            }
        }

        //METODO PARA RECUPERAR TODOS LOS PRODUCTOS
        public async Task<List<Producto>> GetProductosFavoritosAsync()
        {
            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {
                Usuario usuario = await this.service.GetPerfilUsuarioAsync();

                string jsonProductos = await
                    this.database.StringGetAsync("favoritos" + "_" + usuario.IdUsuario);

                if (jsonProductos == null)
                {
                    return null;
                }
                else
                {
                    List<Producto> favoritos =
                        JsonConvert.DeserializeObject<List<Producto>>
                        (jsonProductos);
                    return favoritos;
                }
            }
            else
            {
                return new List<Producto>();
            }
        }

        //METODO PARA ELIMINAR PRODUCTOS DE FAVORITOS
        public async Task DeleteProductoFavoritoAsync
            (int idproducto)
        {
            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {

                Usuario usuario = await this.service.GetPerfilUsuarioAsync();


                List<Producto> favoritos =
                    await this.GetProductosFavoritosAsync();
                if (favoritos != null)
                {
                    //BUSCAMOS EL PRODUCTO
                    Producto productoDelete =
                        favoritos.FirstOrDefault
                        (x => x.IdProducto == idproducto);
                    //ELIMINAMOS EL PRODUCTO DE LA COLECCION
                    favoritos.Remove(productoDelete);
                    //TENEMOS QUE COMPROBAR SI TODAVIA 
                    //TENEMOS ALGUN FAVORITO
                    if (favoritos.Count == 0)
                    {
                        //SI YA NO TENEMOS FAVORITOS ELIMINAMOS 
                        //LA KEY DE AZURE CACHE REDIS
                        await this.database.
                            KeyDeleteAsync("favoritos" + "_" + usuario.IdUsuario);
                    }
                    else
                    {
                        //ALMACENAMOS LOS PRODUCTOS FAVORITOS DE NUEVO
                        string jsonProductos =
                            JsonConvert.SerializeObject(favoritos);
                        //PODEMOS INDICAR POR CODIGO EL TIEMPO DE 
                        //DURACION DE LA KEY DENTRO DE CACHE REDIS.

                        await this.database.StringSetAsync
                            ("favoritos" + "_" + usuario.IdUsuario, jsonProductos
                            , TimeSpan.FromMinutes(60));
                    }
                }
            }
        }

        public async Task AddProductoCarritoAsync(Producto producto)
        {

            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {
                Usuario usuario = await this.service.GetPerfilUsuarioAsync();
                string jsonProductos = await
                this.database.StringGetAsync("carrito" + "_" + usuario.IdUsuario);
                List<Producto> productosList;
                if (jsonProductos == null)
                {
                    productosList = new List<Producto>();
                }
                else
                {
                    productosList =
                        JsonConvert.DeserializeObject<List<Producto>>
                        (jsonProductos);
                }
                productosList.Add(producto);
                jsonProductos = JsonConvert.SerializeObject(productosList);
                await this.database.StringSetAsync
                    ("carrito" + "_" + usuario.IdUsuario, jsonProductos);
            }
            else
            {
                Console.WriteLine("Usuario no autenticado");
            }
        }

        public async Task<List<Producto>> GetProductosCarritoAsync()
        {
            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {
                Usuario usuario = await this.service.GetPerfilUsuarioAsync();

                string jsonProductos = await
                    this.database.StringGetAsync("carrito" + "_" + usuario.IdUsuario);

                if (jsonProductos == null)
                {
                    return null;
                }
                else
                {
                    List<Producto> favoritos =
                        JsonConvert.DeserializeObject<List<Producto>>
                        (jsonProductos);
                    return favoritos;
                }
            }
            else
            {
                return new List<Producto>();
            }
        }

        public async Task DeleteProductoCarritoAsync
            (int idproducto)
        {
            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {

                Usuario usuario = await this.service.GetPerfilUsuarioAsync();


                List<Producto> favoritos =
                    await this.GetProductosCarritoAsync();
                if (favoritos != null)
                {
                    Producto productoDelete =
                        favoritos.FirstOrDefault
                        (x => x.IdProducto == idproducto);
                    favoritos.Remove(productoDelete);
                    if (favoritos.Count == 0)
                    {
                        await this.database.
                            KeyDeleteAsync("carrito" + "_" + usuario.IdUsuario);
                    }
                    else
                    {
                        string jsonProductos =
                            JsonConvert.SerializeObject(favoritos);
                        await this.database.StringSetAsync
                            ("carrito" + "_" + usuario.IdUsuario, jsonProductos
                            , TimeSpan.FromMinutes(60));
                    }
                }
            }
        }

    }
}
