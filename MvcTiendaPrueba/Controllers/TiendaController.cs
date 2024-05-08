using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MvcTiendaPrueba.Extensions;
using MvcTiendaPrueba.Models;
using MvcTiendaPrueba.Services;

namespace MvcTiendaPrueba.Controllers
{
    public class TiendaController : Controller
    {
        private ServiceApiTienda service;
        private ServiceCacheRedis cacheredis;
        private IHttpContextAccessor httpContextAccessor;
        public TiendaController(ServiceApiTienda service, ServiceCacheRedis cacheredis, IHttpContextAccessor httpContextAccessor)
        {
            this.service = service;
            this.cacheredis = cacheredis;
            this.httpContextAccessor = httpContextAccessor;
        }

        public async Task<IActionResult> Index()
        {
            var categorias = await service.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            var comentarios = service.GetComentariosAsync();
            ViewData["COMENTARIOS"] = comentarios;
            return View();
        }


        /*******************************/

        public async Task<IActionResult> DetailsProducto
            (int idproducto)
        {
            List<Comentario> comentarios = await this.service.FindComentariosAsync(idproducto);
            HttpContext.Session.SetObject("COMENTARIOS", comentarios);

            Producto producto = await this.service.FindProductosAsync(idproducto);
            return View(producto);
        }

        public async Task<IActionResult> PaginarGrupoProductos(int? posicion)
        {
            var categorias = await service.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            if (posicion == null)
            {
                posicion = 1;
            }
            int registros = await this.service.GetNumeroProductosAsync();
            List<Producto> productos = await this.service.GetGrupoProductosAsync(posicion.Value);
            ViewData["REGISTROS"] = registros;
            ViewData["NumeroPaginaActual"] = posicion; // Pasa el número de página actual a la vista
            return View(productos);
        }

        public async Task<IActionResult> ProductosCategoria(int? posicion, int idcategoria)
        {
            var categorias = await service.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            if (posicion == null)
            {
                posicion = 1;
            }
           
                List<Producto> productos = await this.service.GetGrupoProductosCategoriaAsync(posicion.Value,idcategoria);
                int registros = await this.service.GetNumeroProductosCategoriaAsync(idcategoria);
                ViewData["REGISTROS"] = registros;
                ViewData["IDCATEGORIA"] = idcategoria;
                ViewData["NumeroPaginaActual"] = posicion; // Pasa el número de página actual a la vista
                return View(productos);
        }


        public async Task<IActionResult> Categorias()
        {
            List<Categoria> categorias = await this.service.GetCategoriasAsync();
            return View(categorias);
        }

        /************************CESTA*****************************************/

        public async Task<IActionResult> Cesta()
        {
            List<Producto> productos = await this.cacheredis.GetProductosCarritoAsync();
            return View(productos);
        }

        public async Task<IActionResult> AnyadirProductoCesta(int idproducto)
        {
            Producto producto = await this.service.FindProductosAsync(idproducto);
            await this.cacheredis.AddProductoCarritoAsync(producto);
            return RedirectToAction("PaginarGrupoProductos");

        }

        public async Task<IActionResult> EliminarProductoCesta(int idproducto)
        {
            await this.cacheredis.DeleteProductoCarritoAsync(idproducto);
            return RedirectToAction("CESTA");
        }


        /**************************FAVORITOS***************************************/

        public async Task<IActionResult> Favoritos()
        {
            List<Producto> productos = await this.cacheredis.GetProductosFavoritosAsync();
            return View(productos);
        }


        public async Task<IActionResult>
            AnyadirProductoFavoritos(int idproducto)
        {
            Producto producto = await this.service.FindProductosAsync(idproducto);
            await this.cacheredis.AddProductoFavoritoAsync(producto);
            return RedirectToAction("PAginarGrupoProductos");

        }

        public async Task<IActionResult> EliminarProductoFavoritos(int idproducto)
        {
            await this.cacheredis.DeleteProductoFavoritoAsync(idproducto);
            return RedirectToAction("FAVORITOS");
        }


        /******************** PEDIDOS ****************************/

        public async Task<IActionResult> RealizarCompra()
        {
            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {
                Usuario usuario = await this.service.GetPerfilUsuarioAsync();
                List<Producto> productosEnCesta = await this.cacheredis.GetProductosCarritoAsync();

                // Creamos el pedido
                Pedido pedido = await this.service.CreatePedidoAsync(usuario.IdUsuario, productosEnCesta);

                // Limpiamos la cesta después de crear el pedido

                foreach (Producto producto in productosEnCesta)
                {
                    await this.cacheredis.DeleteProductoCarritoAsync(producto.IdProducto);
                }
                productosEnCesta.Clear();
            }
            return RedirectToAction("PaginarGrupoProductos");

        }
        
        public async Task<IActionResult> PedidosUsuario()
        {
            if (httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {
                Usuario usuario = await this.service.GetPerfilUsuarioAsync();
                List<DetallePedidoView> pedidosUsuarios = await this.service.GetProductosPedidoUsuarioAsync(usuario.IdUsuario);
                return View(pedidosUsuarios);
            }
            else
            {
                return View(new List<DetallePedidoView>());
            }
        }

    }
}
