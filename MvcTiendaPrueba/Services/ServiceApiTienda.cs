using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using MvcTiendaPrueba.Helpers;
using MvcTiendaPrueba.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;
using System.Text;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace MvcTiendaPrueba.Services
{
    public class ServiceApiTienda
    {
        private string UrlApi;
        private MediaTypeWithQualityHeaderValue header;
        private IHttpContextAccessor httpContextAccessor;


        public ServiceApiTienda(IConfiguration configuration, IHttpContextAccessor httpContextAccessor)
        {
            this.header =
                new MediaTypeWithQualityHeaderValue("application/json");
            this.UrlApi = configuration.GetValue<string>
                ("ApiUrls:ApiTienda");
            this.httpContextAccessor = httpContextAccessor;

        }

        private async Task<T> CallApiAsync<T>(string request, string method = "GET", HttpContent content = null)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.UrlApi);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);
                
                HttpResponseMessage response;

                if (method == "GET")
                {
                    response = await client.GetAsync(request);
                }
                else if (method == "POST")
                {
                    response = await client.PostAsync(request, content);
                }
                else if (method == "PUT")
                {
                    response = await client.PutAsync(request, content);
                }
                else
                {
                    throw new ArgumentException($"Método HTTP no válido: {method}", nameof(method));
                }

                if (response.IsSuccessStatusCode)
                {
                    T data = await response.Content.ReadAsAsync<T>();
                    return data;
                }
                else
                {
                    return default(T);
                }
            }
        }



        public async Task<List<Provincia>> GetProvinciasAsync()
        {
            string request = "api/tienda/getprovincias";
            List<Provincia> provincias = await this.CallApiAsync<List<Provincia>>(request);
            return provincias;
        }

        public async Task<List<Comentario>> GetComentariosAsync()
        {
            string request = "api/tienda/getcomentarios";
            List<Comentario> comentarios = await this.CallApiAsync<List<Comentario>>(request);
            return comentarios;
        }

        public async Task<List<Producto>> GetProductosAsync()
        {
            string request = "api/tienda/getproductos";
            List<Producto> productos = await this.CallApiAsync<List<Producto>>(request);
            return productos;
        }

        public async Task<List<Categoria>> GetCategoriasAsync()
        {
            string request = "api/tienda/getcategorias";
            List<Categoria> categorias = await this.CallApiAsync<List<Categoria>>(request);
            return categorias;
        }

        public async Task<List<Comentario>> FindComentariosAsync(int idproducto)
        {
            string request = "api/tienda/findcomentarios/" + idproducto;
            List<Comentario> comentarios = await
                this.CallApiAsync<List<Comentario>>(request);
            return comentarios;
        }

        public async Task<Producto> FindProductosAsync(int id)
        {
            string request = "api/tienda/findproductos/" + id;
            Producto producto = await
                this.CallApiAsync<Producto>(request);
            return producto;
        }

        public async Task<Categoria> FindCategoriasAsync(int id)
        {
            string request = "api/tienda/findcategorias/" + id;
            Categoria categoria = await
                this.CallApiAsync<Categoria>(request);
            return categoria;
        }

        public async Task<ModelProductoPaginacion> GetProductoCategoriaAsync(int? posicion, int idcategoria)
        {
            string request = "api/tienda/getproductocategoria/" + posicion + "/" + idcategoria;
            ModelProductoPaginacion model = await
                this.CallApiAsync<ModelProductoPaginacion>(request);
            return model;
        }

        public async Task<int> GetNumeroProductosAsync()
        {
            string request = "api/tienda/getnumeroproductos";
            int numero = await
                this.CallApiAsync<int>(request);
            return numero;
        }

        public async Task<List<Producto>> GetGrupoProductosAsync(int posicion)
        {
            string request = "api/tienda/getgrupoproductos/"+ posicion;
            List<Producto> productos = await
                this.CallApiAsync<List<Producto>>(request);
            return productos;
        }

        public async Task<int> GetNumeroProductosCategoriaAsync(int idcategoria)
        {
            string request = "api/tienda/getnumeroproductoscategoria/" + idcategoria;
            int numero = await
                this.CallApiAsync<int>(request);
            return numero;
        }

        public async Task<List<Producto>> GetGrupoProductosCategoriaAsync(int posicion, int idcategoria)
        {
            string request = "api/tienda/getgrupoproductoscategoria/" + posicion + "/" + idcategoria;
            List<Producto> productos = await
                this.CallApiAsync<List<Producto>>(request);
            return productos;
        }

        public async Task<int> GetMaxIdUsuarioAsync()
        {
            string request = "api/tienda/getmaxidusuario";
            int numero = await 
                this.CallApiAsync<int>(request);
            return numero;
        }

        public async Task<int> GetMaxIdPedidoAsync()
        {
            string request = "api/tienda/getmaxidpedido";
            int numero = await
                this.CallApiAsync<int>(request);
            return numero;
        }

        public async Task<int> GetMaxIdDetallePedidoAsync()
        {
            string request = "api/tienda/GetMaxIdDetallePedido";
            int numero = await
                this.CallApiAsync<int>(request);
            return numero;
        }

        public async Task<int> GetMaxIdProductoAsync()
        {
            string request = "api/tienda/GetMaxIdProducto";
            int numero = await
                this.CallApiAsync<int>(request);
            return numero;
        }

        public async Task<int> GetMaxIdCategoriaAsync()
        {
            string request = "api/tienda/GetMaxIdCategoria";
            int numero = await
                this.CallApiAsync<int>(request);
            return numero;
        }

        //idpedidos=1&idpedidos=2
        private string TransformCollectionToQuery
            (List<int> collection)
        {
            string result = "";
            foreach (int elem in collection)
            {
                result += "idpedidos=" + elem + "&";
            }
            result = result.TrimEnd('&');
            return result;
        }

        public async Task<List<DetallePedidoView>> GetProductosPedidoAsync(List<int> idpedidos)
        {
            string request = "api/tienda/getproductospedido";
            string data = this.TransformCollectionToQuery(idpedidos);
            List<DetallePedidoView> productos = await
                this.CallApiAsync<List<DetallePedidoView>>(request + "?" + data);
            return productos;
        }


        public async Task<List<DetallePedidoView>> GetProductosPedidoUsuarioAsync(int idusuario)
        {
            string request = "api/tienda/getproductospedidousuario/" + idusuario;
            List<DetallePedidoView> productos = await
                this.CallApiAsync<List<DetallePedidoView>>(request);
            return productos;
        }


        public async Task<Pedido> CreatePedidoAsync(int idusuario, List<Producto> cesta)
        {
            try
            {
                // Construye la URL del endpoint de la API
                string request = "api/tienda/crearpedido/" + idusuario;

                // Serializa la lista de productos a JSON
                var jsonCesta = JsonConvert.SerializeObject(cesta);

                // Crea el contenido de la solicitud HTTP con la lista de productos en formato JSON
                var content = new StringContent(jsonCesta, Encoding.UTF8, "application/json");

                // Realiza la solicitud HTTP GET a la API utilizando el método CallApiAsync
                HttpResponseMessage response = await CallApiAsync<HttpResponseMessage>(request, "POST", content);

                // Verifica si la solicitud fue exitosa
                if (response.IsSuccessStatusCode)
                {
                    // Lee el contenido de la respuesta y lo deserializa a un objeto Pedido
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    var pedidoCreado = JsonConvert.DeserializeObject<Pedido>(jsonResponse);

                    // Devuelve el pedido creado
                    return pedidoCreado;
                }
                else
                {
                    // Si la solicitud no fue exitosa, lanza una excepción o maneja el error según sea necesario
                    throw new Exception($"La solicitud HTTP falló con el código de estado: {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                // Maneja cualquier excepción que pueda ocurrir durante el proceso
                throw new Exception($"Ocurrió un error al crear el pedido: {ex.Message}");
            }

        }

        public async Task InsertProductoAsync(string nombre, string descripcion, int precio, int idcategoria)
        {
            using (HttpClient client = new HttpClient())
            {
                var request = "api/tienda/insertproducto/" + nombre + "/" + descripcion + "/" + precio + "/" + idcategoria;
                client.BaseAddress = new Uri(this.UrlApi);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);
                HttpResponseMessage response =
                    await client.PostAsync(request, null);
            }
        }

        public async Task InsertCategoriaAsync(string nombre)
        {
            using (HttpClient client = new HttpClient())
            {
                var request = "api/Tienda/InsertCategoria/" + nombre;
                client.BaseAddress = new Uri(this.UrlApi);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);
                HttpResponseMessage response =
                    await client.PostAsync(request, null);
            }
        }

        public async Task<Usuario> ModificarUsuario(Usuario usuarioModificado)
        {

            using (HttpClient client = new HttpClient())
            {
                string request = "api/Tienda/ModificarUsuario";
                client.BaseAddress = new Uri(this.UrlApi);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);
                string json = JsonConvert.SerializeObject(usuarioModificado);
                StringContent content =
                    new StringContent(json, Encoding.UTF8, "application/json");
                HttpResponseMessage response =
                    await client.PutAsync(request, content);
                return usuarioModificado;
            }
        }

        private async Task<T> CallApiAsync<T>(string request, string token)

        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.UrlApi);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);

                client.DefaultRequestHeaders.Add("Authorization", "bearer " + token);

                HttpResponseMessage response = await client.GetAsync(request);

                if (response.IsSuccessStatusCode)
                {
                    T data = await response.Content.ReadAsAsync<T>();
                    return data;
                }
                else
                {
                    return default(T);
                }
            }

        }

        public async Task<string> GetTokenAsync(string email, string password)
        {
            using (HttpClient client = new HttpClient())
            {
                string request = "api/auth/login";
                client.BaseAddress = new Uri(this.UrlApi);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);
                LoginModel model = new LoginModel
                {
                    Email = email,
                    Password = password
                };
                string jsonData = JsonConvert.SerializeObject(model);
                StringContent content = new StringContent(jsonData, Encoding.UTF8, "application/json");
                HttpResponseMessage response = await client.PostAsync(request, content);
                if (response.IsSuccessStatusCode)
                {
                    string data = await response.Content.ReadAsStringAsync();
                    JObject keys = JObject.Parse(data);
                    string token = keys.GetValue("response").ToString();
                    return token;
                }
                else
                {
                    return null;
                }
            }
        }

        public async Task RegisterUsuario(string nombreUsuario, string nombre, string apellido, string email,
            string direccion, int idprovincia, string passEncript, string telefono)
        {
            using (HttpClient client = new HttpClient())
            {
                string request = "api/auth/registeruser";
                client.BaseAddress = new Uri(this.UrlApi);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.header);
                //INSTANCIAMOS NUESTRO MODEL

                Usuario user = new Usuario
                {
                    IdUsuario = await this.GetMaxIdUsuarioAsync(),
                    NombreUsuario = nombreUsuario,
                    Nombre = nombre,
                    Apellido = apellido,
                    Correo = email,
                    Direccion = direccion,
                    IdProvincia = idprovincia,
                    //SACAMOS EL SALT
                    Salt = HelperCryptography.GenerateSalt(),
                    PassEncript = passEncript,
                    Telefono = telefono
                };
                //user.Password = HelperCryptography.EncryptPassword(password, user.Salt);

                string json = JsonConvert.SerializeObject(user);


                StringContent content = new StringContent(json, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(request, content);
            }
        }

        public async Task<Usuario> GetPerfilUsuarioAsync()
        {
            string token = this.httpContextAccessor.HttpContext.User.FindFirst(x => x.Type == "TOKEN").Value;
            string request = "api/auth/PerfilUsuario";
            Usuario usuario = await this.CallApiAsync<Usuario>(request, token);
            return usuario;
        }

    }
}
