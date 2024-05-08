using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcTiendaPrueba.Models
{
    public class Usuario
    {
        public int IdUsuario { get; set; }

        public string NombreUsuario { get; set; }

        public string Nombre { get; set; }

        public string Apellido { get; set; }
        public string Correo { get; set; }

        /*[Column("CONTRASENIA")]
        public string Contrasenia { get; set; }*/

        public string Direccion { get; set; }

        public string Salt { get; set; }

        public int IdProvincia { get; set; }

        public string PassEncript { get; set; }

        public string Telefono { get; set; }

    }
}
