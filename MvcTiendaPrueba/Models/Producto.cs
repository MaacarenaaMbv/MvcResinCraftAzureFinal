using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcTiendaPrueba.Models
{
    public class Producto
    {
        public int IdProducto { get; set; }

        public string Nombre { get; set; }

        public string Descripcion { get; set; }

        public decimal Precio { get; set; }

        public int Inventario { get; set; }

        public int IdCategoria { get; set; }

        public int IdSubcategoria { get; set; }

    }
}
