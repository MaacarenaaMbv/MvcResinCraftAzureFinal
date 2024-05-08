using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcTiendaPrueba.Models
{
    public class Comentario
    {
        public int IdComentario { get; set; }

        public int IdUsuario { get; set; }

        public int IdProducto { get; set; }

        public int Valoracion { get; set; }

        public string ComentarioTexto { get; set; }

        public DateTime FechaPublicacion { get; set; }
    }
}
