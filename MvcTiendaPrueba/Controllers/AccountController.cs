using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using MvcTiendaPrueba.Extensions;
using MvcTiendaPrueba.Models;
using Newtonsoft.Json;
using System.Security.Claims;
using static System.Runtime.InteropServices.JavaScript.JSType;
using MvcTiendaPrueba.Services;
using System;

namespace MvcTiendaPrueba.Controllers
{
    public class AccountController : Controller
    {
        private ServiceApiTienda service;

        public AccountController(ServiceApiTienda service)
        {
            this.service = service;
        }

        public IActionResult Index()
        {
            return View();
        }
        /*****************/
        public async Task<IActionResult> PanelAdmin()
        {
            var categorias = await this.service.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            return View();
        }
        public async Task<IActionResult> NewCategoria()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> NewCategoria(string nombre)
        {
            await this.service.InsertCategoriaAsync(nombre);
            return RedirectToAction("PanelAdmin");
        }

        public async Task<IActionResult> NewProducto()
        {
            var categorias = await service.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> NewProducto(string nombre, string descripcion, int precio, int idcategoria)
        {
            var categorias = await service.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            await this.service.InsertProductoAsync(nombre, descripcion, precio, idcategoria);
            return RedirectToAction("PanelAdmin");

        }
        /**********************/
        public async Task<IActionResult> EditarPerfil()
        {
            Usuario usuario = await this.service.GetPerfilUsuarioAsync();

            return View(usuario);
        }
        [HttpPost]
        public async Task<IActionResult> EditarPerfil(Usuario usuarioModificado)
        {
            Usuario usuario = await this.service.GetPerfilUsuarioAsync();

            usuarioModificado.Salt = usuario.Salt;
            usuarioModificado.PassEncript = usuario.PassEncript;

            await this.service.ModificarUsuario(usuarioModificado);
 
            HttpContext.Session.SetObject("USUARIO", usuarioModificado);

            return RedirectToAction("MiPerfil", "Account");
        }


        public async Task<IActionResult> MiPerfil()
        {
            Usuario usuario = await this.service.GetPerfilUsuarioAsync();
            return View(usuario);
        }


        public async Task<IActionResult> Register()
        {
            var provincias = await service.GetProvinciasAsync();
            ViewData["PROVINCIAS"] = provincias;
            return View();
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public async Task<IActionResult> Register
            (string nombreUsuario, string nombre, string apellido, string correo, string direccion, int idprovincia, string passEncript, string telefono)
        {
            try
            {
                // Llama al método RegisterUsuario del servicio para registrar un usuario
                await this.service.RegisterUsuario(nombreUsuario, nombre, apellido, correo, direccion, idprovincia, passEncript, telefono);

                // Si el registro fue exitoso, establece un mensaje de éxito
                ViewData["MENSAJE"] = "Usuario registrado correctamente";

                // Devuelve la vista con el mensaje
                return View();
            }
            catch (Exception ex)
            {
                // Si ocurre algún error durante el registro, establece un mensaje de error
                ViewData["MENSAJE"] = "Error al registrar el usuario: " + ex.Message;

                // Devuelve la vista con el mensaje de error
                return View();
            }
        }


        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginModel model)
        {
            string token = await this.service.GetTokenAsync(model.Email, model.Password);
            if (token == null)
            {
                ViewData["MENSAJE"] = "Usuario/Password incorrectos";
                return View();
            }
            else
            {
                HttpContext.Session.SetString("TOKEN", token);

                //SEGURIDAD 
                ClaimsIdentity identity = new ClaimsIdentity(CookieAuthenticationDefaults.AuthenticationScheme, ClaimTypes.Name, ClaimTypes.Role);

                //Claim claimEmail = new Claim(ClaimTypes.Name, model.Email);
                // Claim claimPassword = new Claim("password", model.Password);
                identity.AddClaim(new Claim(ClaimTypes.Name, model.Email));
                identity.AddClaim(new Claim("password", model.Password));
                identity.AddClaim(new Claim("TOKEN", token));

                ClaimsPrincipal userPrincipal = new ClaimsPrincipal(identity);


                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, userPrincipal, 
                    new AuthenticationProperties
                        {
                             ExpiresUtc = DateTime.UtcNow.AddMinutes(30)
                        });
                bool esAdmin = await EsAdmin(model.Email);

                HttpContext.Session.SetObject("EsAdmin", esAdmin);
                ViewData["MENSAJE"] = "Bienvenido " + model.Email;

                return RedirectToAction("Index", "Tienda");
            }
        }

        private async Task<bool> EsAdmin(string userEmail)
        {
            return userEmail == "admin@gmail.com";
        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync
                (CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Tienda");
        }

        /*public IActionResult Logout()
        {
            HttpContext.Session.Remove("USUARIO");
            return RedirectToAction("Login");
        }*/


    }
}
