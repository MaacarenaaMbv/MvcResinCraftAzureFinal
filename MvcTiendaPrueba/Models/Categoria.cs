using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcTiendaPrueba.Models
{
    public class Categoria
    {
        public int IdCategoria { get; set; }

        public string Nombre { get; set; }
    }
}
