using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcTiendaPrueba.Models
{
    public class ImagenProducto
    {
        public int IdImagen { get; set; }

        public int IdProducto { get; set; }

        public string RutaImagen { get; set; }
    }
}
