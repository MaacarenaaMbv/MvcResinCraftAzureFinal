USE [TIENDA]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[IDPRODUCTO] [int] NOT NULL,
	[NOMBRE] [nvarchar](100) NULL,
	[DESCRIPCION] [nvarchar](max) NULL,
	[PRECIO] [decimal](10, 2) NULL,
	[INVENTARIO] [int] NULL,
	[IDCATEGORIA] [int] NULL,
	[IDSUBCATEGORIA] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPRODUCTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_GRUPO_PRODUCTOS]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_GRUPO_PRODUCTOS]
as
	select cast(
		row_number() over (order by NOMBRE) as int) as posicion,
		ISNULL(IDPRODUCTO, 0) AS IDPRODUCTO, NOMBRE, DESCRIPCION, PRECIO, INVENTARIO, IDCATEGORIA, IDSUBCATEGORIA FROM Productos
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[IDPEDIDO] [int] NOT NULL,
	[IDUSUARIO] [int] NULL,
	[FECHA] [date] NULL,
	[TOTAL] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPEDIDO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallesPedido]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesPedido](
	[IDDETALLEPEDIDO] [int] NOT NULL,
	[IDPEDIDO] [int] NULL,
	[IDPRODUCTO] [int] NULL,
	[CANTIDAD] [int] NULL,
	[PRECIOUNITARIO] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDDETALLEPEDIDO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DetallesPedidoView]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DetallesPedidoView] AS
SELECT 
    dp.IDDETALLEPEDIDO,
    dp.IDPEDIDO,
    dp.IDPRODUCTO,
    dp.CANTIDAD,
    dp.PRECIOUNITARIO,
    p.NOMBRE AS NOMBRE_PRODUCTO,
    dp.CANTIDAD * dp.PRECIOUNITARIO AS TOTAL_DETALLE,
    ped.TOTAL AS TOTAL_PEDIDO,
    ped.IDUSUARIO  -- Agregamos el IdUsuario
FROM 
    DETALLESPEDIDO dp
JOIN 
    PRODUCTOS p ON dp.IDPRODUCTO = p.IDPRODUCTO
JOIN 
    PEDIDOS ped ON dp.IDPEDIDO = ped.IDPEDIDO;

GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[IDCATEGORIA] [int] NOT NULL,
	[NOMBRE] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCATEGORIA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comentarios]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comentarios](
	[IDCOMENTARIO] [int] NOT NULL,
	[IDUSUARIO] [int] NULL,
	[IDPRODUCTO] [int] NULL,
	[VALORACION] [int] NULL,
	[COMENTARIO] [nvarchar](max) NULL,
	[FECHAPUBLICACION] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCOMENTARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImagenesProductos]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImagenesProductos](
	[IDIMAGEN] [int] NOT NULL,
	[IDPRODUCTO] [int] NULL,
	[RUTAIMAGEN] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDIMAGEN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincias](
	[IDPROVINCIA] [int] NOT NULL,
	[NOMBRE] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPROVINCIA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subcategorias]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subcategorias](
	[IDSUBCATEGORIA] [int] NOT NULL,
	[NOMBRE] [nvarchar](100) NULL,
	[IDCATEGORIA] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDSUBCATEGORIA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[IDUSUARIO] [int] NOT NULL,
	[NOMBREUSUARIO] [nvarchar](50) NULL,
	[NOMBRE] [nvarchar](100) NULL,
	[APELLIDO] [nvarchar](100) NULL,
	[CORREO] [nvarchar](100) NULL,
	[DIRECCION] [nvarchar](200) NULL,
	[SALT] [nvarchar](50) NULL,
	[IDPROVINCIA] [int] NULL,
	[TELEFONO] [nvarchar](9) NULL,
	[PASSENCRIPT] [varbinary](max) NULL,
 CONSTRAINT [PK__Usuarios__98242AA98F294C4F] PRIMARY KEY CLUSTERED 
(
	[IDUSUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Categorias] ([IDCATEGORIA], [NOMBRE]) VALUES (1, N'Ceniceros')
INSERT [dbo].[Categorias] ([IDCATEGORIA], [NOMBRE]) VALUES (2, N'Marcapáginas')
INSERT [dbo].[Categorias] ([IDCATEGORIA], [NOMBRE]) VALUES (3, N'Joyas')
INSERT [dbo].[Categorias] ([IDCATEGORIA], [NOMBRE]) VALUES (4, N'Bolígrafos')
INSERT [dbo].[Categorias] ([IDCATEGORIA], [NOMBRE]) VALUES (5, N'Llaveros')
GO
INSERT [dbo].[Comentarios] ([IDCOMENTARIO], [IDUSUARIO], [IDPRODUCTO], [VALORACION], [COMENTARIO], [FECHAPUBLICACION]) VALUES (1, 1, 1, 5, N'¡Me encanta este producto! La calidad es increíble.', CAST(N'2024-02-28T08:30:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([IDCOMENTARIO], [IDUSUARIO], [IDPRODUCTO], [VALORACION], [COMENTARIO], [FECHAPUBLICACION]) VALUES (2, 2, 1, 4, N'Buen producto, pero el envío fue un poco lento.', CAST(N'2024-02-28T10:45:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([IDCOMENTARIO], [IDUSUARIO], [IDPRODUCTO], [VALORACION], [COMENTARIO], [FECHAPUBLICACION]) VALUES (3, 3, 2, 5, N'El diseño de este producto es único. ¡Lo recomiendo totalmente!', CAST(N'2024-02-28T12:15:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([IDCOMENTARIO], [IDUSUARIO], [IDPRODUCTO], [VALORACION], [COMENTARIO], [FECHAPUBLICACION]) VALUES (4, 2, 3, 2, N'No estoy satisfecho con la calidad de este producto.', CAST(N'2024-02-28T14:20:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([IDCOMENTARIO], [IDUSUARIO], [IDPRODUCTO], [VALORACION], [COMENTARIO], [FECHAPUBLICACION]) VALUES (5, 1, 3, 1, N'Bastante decepcionante. No se parece en nada a la imagen.', CAST(N'2024-02-28T16:50:00.000' AS DateTime))
GO
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (1, 1, 1, 2, CAST(14.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (2, 1, 3, 1, CAST(8.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (3, 2, 5, 1, CAST(29.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (4, 2, 7, 2, CAST(6.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (5, 3, 9, 3, CAST(4.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (6, 3, 10, 2, CAST(3.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (7, 4, 137, 0, CAST(17.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (8, 5, 64, 0, CAST(19.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (9, 6, 112, 0, CAST(69.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (10, 7, 102, 1, CAST(19.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (11, 17, 93, 1, CAST(4.49 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (12, 17, 97, 1, CAST(39.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (13, 17, 137, 1, CAST(17.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (14, 18, 97, 1, CAST(39.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (15, 18, 102, 1, CAST(19.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (16, 18, 137, 1, CAST(17.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (17, 19, 97, 1, CAST(39.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (18, 19, 137, 1, CAST(17.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (19, 20, 65, 1, CAST(7.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (20, 20, 73, 1, CAST(79.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (21, 20, 161, 1, CAST(179.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (22, 21, 97, 1, CAST(39.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (23, 21, 137, 1, CAST(17.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (24, 22, 74, 1, CAST(34.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (25, 22, 127, 1, CAST(9.99 AS Decimal(10, 2)))
INSERT [dbo].[DetallesPedido] ([IDDETALLEPEDIDO], [IDPEDIDO], [IDPRODUCTO], [CANTIDAD], [PRECIOUNITARIO]) VALUES (26, 22, 137, 1, CAST(17.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (1, 1, N'/img/cenicero_cuadrado_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (2, 1, N'/img/cenicero_cuadrado_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (3, 2, N'/img/cenicero_redondo_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (4, 2, N'/img/cenicero_redondo_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (5, 3, N'/img/marcapaginas_clasico_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (6, 3, N'/img/marcapaginas_clasico_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (7, 4, N'/img/marcapaginas_decorativo_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (8, 4, N'/img/marcapaginas_decorativo_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (9, 5, N'/img/collar_resina_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (10, 5, N'/img/collar_resina_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (11, 6, N'/img/pendientes_resina_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (12, 6, N'/img/pendientes_resina_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (13, 7, N'/img/boligrafo_normal_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (14, 7, N'/img/boligrafo_normal_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (15, 8, N'/img/boligrafo_personalizado_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (16, 8, N'/img/boligrafo_personalizado_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (17, 9, N'/img/llavero_metalico_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (18, 9, N'/img/llavero_metalico_2.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (19, 10, N'/img/llavero_acrilico_1.jpg')
INSERT [dbo].[ImagenesProductos] ([IDIMAGEN], [IDPRODUCTO], [RUTAIMAGEN]) VALUES (20, 10, N'/img/llavero_acrilico_2.jpg')
GO
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (1, 1, CAST(N'2024-02-28' AS Date), CAST(49.99 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (2, 2, CAST(N'2024-02-27' AS Date), CAST(79.98 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (3, 3, CAST(N'2024-02-26' AS Date), CAST(109.97 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (4, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (5, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (6, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (7, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (8, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (9, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (10, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (11, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (12, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (13, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (14, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (15, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (16, 15, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (17, 17, CAST(N'2024-03-19' AS Date), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (18, 15, CAST(N'2024-03-19' AS Date), CAST(77.97 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (19, 18, CAST(N'2024-03-19' AS Date), CAST(57.98 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (20, 18, CAST(N'2024-03-19' AS Date), CAST(267.97 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (21, 20, CAST(N'2024-03-19' AS Date), CAST(57.98 AS Decimal(10, 2)))
INSERT [dbo].[Pedidos] ([IDPEDIDO], [IDUSUARIO], [FECHA], [TOTAL]) VALUES (22, 20, CAST(N'2024-03-19' AS Date), CAST(62.97 AS Decimal(10, 2)))
GO
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (1, N'Cenicero Cuadrado', N'Cenicero de resina con forma cuadrada', CAST(14.99 AS Decimal(10, 2)), 50, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (2, N'Cenicero Redondo', N'Cenicero de resina con forma redonda', CAST(12.99 AS Decimal(10, 2)), 50, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (3, N'Marcapáginas Clásico', N'Marcapáginas de resina con diseño clásico', CAST(8.99 AS Decimal(10, 2)), 100, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (4, N'Marcapáginas Decorativo', N'Marcapáginas de resina con diseño decorativo', CAST(10.99 AS Decimal(10, 2)), 100, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (5, N'Collar de Resina', N'Collar de resina con colgante único', CAST(29.99 AS Decimal(10, 2)), 30, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (6, N'Pendientes de Resina', N'Pendientes de resina en varios colores', CAST(19.99 AS Decimal(10, 2)), 50, 3, 6)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (7, N'Bolígrafo Normal', N'Bolígrafo de resina de diseño normal', CAST(6.99 AS Decimal(10, 2)), 80, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (8, N'Bolígrafo Personalizado', N'Bolígrafo de resina personalizado con nombre', CAST(9.99 AS Decimal(10, 2)), 50, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (9, N'Llavero Metálico', N'Llavero de resina con acabado metálico', CAST(4.99 AS Decimal(10, 2)), 100, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (10, N'Llavero Acrílico', N'Llavero de resina transparente', CAST(3.99 AS Decimal(10, 2)), 100, 5, 10)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (11, N'Cenicero Decorativo', N'Cenicero decorativo con diseño floral tallado', CAST(19.99 AS Decimal(10, 2)), 30, 1, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (12, N'Marcapáginas Decorado', N'Marcapáginas de resina con diseño pintado a mano', CAST(12.99 AS Decimal(10, 2)), 50, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (13, N'Collar de Perlas', N'Collar de perlas naturales con cierre de oro', CAST(39.99 AS Decimal(10, 2)), 20, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (14, N'Bolígrafo Premium', N'Bolígrafo de metal de alta calidad con grabado láser', CAST(29.99 AS Decimal(10, 2)), 30, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (15, N'Llavero de Cuero', N'Llavero de cuero genuino con detalles de metal', CAST(6.99 AS Decimal(10, 2)), 80, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (16, N'Cenicero de Madera', N'Cenicero de madera tallada a mano', CAST(24.99 AS Decimal(10, 2)), 40, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (17, N'Marcapáginas Elegante', N'Marcapáginas de metal plateado con diseño elegante', CAST(8.99 AS Decimal(10, 2)), 70, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (18, N'Collar de Cristal', N'Collar de cristal facetado con colgante brillante', CAST(34.99 AS Decimal(10, 2)), 25, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (19, N'Bolígrafo Elegante', N'Bolígrafo de diseño elegante y ergonómico', CAST(14.99 AS Decimal(10, 2)), 60, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (20, N'Llavero Personalizado', N'Llavero de metal con placa grabada personalizable', CAST(9.99 AS Decimal(10, 2)), 50, 5, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (21, N'Cenicero de Metal', N'Cenicero de metal con acabado plateado', CAST(11.99 AS Decimal(10, 2)), 45, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (22, N'Marcapáginas Divertido', N'Marcapáginas de resina con diseño divertido y colorido', CAST(7.99 AS Decimal(10, 2)), 80, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (23, N'Collar de Diamantes', N'Collar de diamantes con colgante de oro blanco', CAST(299.99 AS Decimal(10, 2)), 10, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (24, N'Bolígrafo de Lujo', N'Bolígrafo de lujo con incrustaciones de piedras preciosas', CAST(99.99 AS Decimal(10, 2)), 15, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (25, N'Llavero de Plástico', N'Llavero de plástico resistente en varios colores', CAST(2.99 AS Decimal(10, 2)), 150, 5, 10)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (26, N'Cenicero de Porcelana', N'Cenicero de porcelana fina con diseño floral', CAST(16.99 AS Decimal(10, 2)), 35, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (27, N'Marcapáginas Metálico', N'Marcapáginas de metal resistente con acabado brillante', CAST(9.99 AS Decimal(10, 2)), 60, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (28, N'Collar de Jade', N'Collar de jade natural con cuentas redondas', CAST(49.99 AS Decimal(10, 2)), 18, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (29, N'Bolígrafo de Oro', N'Bolígrafo de oro macizo con detalles grabados', CAST(499.99 AS Decimal(10, 2)), 5, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (30, N'Llavero de Metal', N'Llavero de metal resistente con forma de corazón', CAST(5.99 AS Decimal(10, 2)), 90, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (31, N'Cenicero Vintage', N'Cenicero de vidrio con diseño vintage grabado a mano', CAST(18.99 AS Decimal(10, 2)), 25, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (32, N'Marcapáginas Floral', N'Marcapáginas de metal con diseño floral y borla', CAST(6.99 AS Decimal(10, 2)), 60, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (33, N'Collar de Perlas Blancas', N'Collar de perlas blancas naturales con cierre de plata', CAST(49.99 AS Decimal(10, 2)), 15, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (34, N'Bolígrafo de Lujo Plateado', N'Bolígrafo de metal plateado con incrustaciones de cristal', CAST(39.99 AS Decimal(10, 2)), 20, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (35, N'Llavero de Cuero Negro', N'Llavero de cuero negro con detalle de metal plateado', CAST(8.99 AS Decimal(10, 2)), 100, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (36, N'Cenicero de Cerámica', N'Cenicero de cerámica esmaltada con motivo abstracto', CAST(14.99 AS Decimal(10, 2)), 40, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (37, N'Marcapáginas de Cuero', N'Marcapáginas de cuero genuino con relieve grabado', CAST(9.99 AS Decimal(10, 2)), 50, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (38, N'Collar de Oro Rosa', N'Collar de oro rosa con colgante de corazón', CAST(69.99 AS Decimal(10, 2)), 12, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (39, N'Bolígrafo de Oro Puro', N'Bolígrafo de oro macizo con acabado pulido brillante', CAST(199.99 AS Decimal(10, 2)), 8, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (40, N'Llavero de Metal Plateado', N'Llavero de metal plateado en forma de llave', CAST(4.99 AS Decimal(10, 2)), 120, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (41, N'Cenicero de Porcelana China', N'Cenicero de porcelana china finamente decorado a mano', CAST(22.99 AS Decimal(10, 2)), 30, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (42, N'Marcapáginas Elegante y Sencillo', N'Marcapáginas de metal con diseño elegante y clip sencillo', CAST(5.99 AS Decimal(10, 2)), 70, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (43, N'Collar de Rubíes', N'Collar de rubíes auténticos con cierre de platino', CAST(149.99 AS Decimal(10, 2)), 7, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (44, N'Bolígrafo de Plata Antigua', N'Bolígrafo de plata antigua con grabados de filigrana', CAST(79.99 AS Decimal(10, 2)), 10, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (45, N'Llavero de Silicona', N'Llavero de silicona flexible y resistente en varios colores', CAST(2.49 AS Decimal(10, 2)), 200, 5, 10)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (46, N'Cenicero de Mármol', N'Cenicero de mármol natural pulido con vetas', CAST(34.99 AS Decimal(10, 2)), 18, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (47, N'Marcapáginas Brillante', N'Marcapáginas de metal brillante con piedras incrustadas', CAST(7.99 AS Decimal(10, 2)), 80, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (48, N'Collar de Zafiros', N'Collar de zafiros genuinos con cadena de plata', CAST(199.99 AS Decimal(10, 2)), 9, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (49, N'Bolígrafo de Cristal', N'Bolígrafo de cristal transparente con punta de plata', CAST(24.99 AS Decimal(10, 2)), 25, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (50, N'Llavero de Metal Dorado', N'Llavero de metal dorado con diseño de estrella', CAST(6.49 AS Decimal(10, 2)), 150, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (51, N'Cenicero de Vidrio Templado', N'Cenicero de vidrio templado resistente al calor', CAST(12.99 AS Decimal(10, 2)), 35, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (52, N'Marcapáginas de Perlas', N'Marcapáginas de perlas blancas con detalle de lazo', CAST(8.49 AS Decimal(10, 2)), 65, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (53, N'Collar de Esmeraldas', N'Collar de esmeraldas naturales con cierre de oro blanco', CAST(249.99 AS Decimal(10, 2)), 6, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (54, N'Bolígrafo de Titanio', N'Bolígrafo de titanio resistente y ligero con acabado mate', CAST(49.99 AS Decimal(10, 2)), 15, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (55, N'Llavero de Metal Cromado', N'Llavero de metal cromado con diseño elegante', CAST(3.99 AS Decimal(10, 2)), 180, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (56, N'Cenicero de Aluminio', N'Cenicero de aluminio ligero y duradero en color plateado', CAST(9.99 AS Decimal(10, 2)), 45, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (57, N'Marcapáginas de Plata', N'Marcapáginas de plata esterlina con grabado personalizado', CAST(12.49 AS Decimal(10, 2)), 55, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (58, N'Collar de Diamantes', N'Collar de diamantes genuinos con montura de platino', CAST(999.99 AS Decimal(10, 2)), 5, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (59, N'Bolígrafo de Ébano', N'Bolígrafo de madera de ébano con detalles de metal negro', CAST(29.99 AS Decimal(10, 2)), 20, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (60, N'Llavero de Metal Mate', N'Llavero de metal con acabado mate y diseño minimalista', CAST(4.29 AS Decimal(10, 2)), 130, 5, 10)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (61, N'Cenicero de Acero Inoxidable', N'Cenicero de acero inoxidable de alta calidad', CAST(17.99 AS Decimal(10, 2)), 28, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (62, N'Marcapáginas Elegante', N'Marcapáginas de metal elegante con adornos dorados', CAST(6.79 AS Decimal(10, 2)), 75, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (63, N'Collar de Perlas Rosadas', N'Collar de perlas rosadas con cierre de plata de ley', CAST(39.99 AS Decimal(10, 2)), 10, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (64, N'Bolígrafo de Acero Pulido', N'Bolígrafo de acero pulido con detalles cromados', CAST(19.99 AS Decimal(10, 2)), 30, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (65, N'Llavero de Cuero Marrón', N'Llavero de cuero marrón con grabado personalizado', CAST(7.99 AS Decimal(10, 2)), 90, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (66, N'Cenicero de Porcelana Fina', N'Cenicero de porcelana fina con diseño floral delicado', CAST(26.99 AS Decimal(10, 2)), 22, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (67, N'Marcapáginas Vintage', N'Marcapáginas vintage de metal envejecido con adornos de filigrana', CAST(9.99 AS Decimal(10, 2)), 45, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (68, N'Collar de Turquesas', N'Collar de turquesas genuinas con cadena de plata chapada en oro', CAST(149.99 AS Decimal(10, 2)), 8, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (69, N'Bolígrafo de Oro Rosa', N'Bolígrafo de oro rosa con detalles de cristales de Swarovski', CAST(59.99 AS Decimal(10, 2)), 18, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (70, N'Llavero de Plástico', N'Llavero de plástico resistente en colores variados', CAST(1.99 AS Decimal(10, 2)), 250, 5, 10)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (71, N'Cenicero de Cristal Tallado', N'Cenicero de cristal tallado a mano con patrón geométrico', CAST(24.99 AS Decimal(10, 2)), 32, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (72, N'Marcapáginas Metálico', N'Marcapáginas de metal con acabado metálico en varios colores', CAST(5.49 AS Decimal(10, 2)), 80, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (73, N'Collar de Amatistas', N'Collar de amatistas naturales con cadena de plata de ley', CAST(79.99 AS Decimal(10, 2)), 6, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (74, N'Bolígrafo de Bronce Antiguo', N'Bolígrafo de bronce antiguo con grabados florales', CAST(34.99 AS Decimal(10, 2)), 12, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (75, N'Llavero de Metal Brillante', N'Llavero de metal brillante con forma de corazón', CAST(5.79 AS Decimal(10, 2)), 120, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (76, N'Collar de Perlas Negras', N'Collar de perlas negras naturales con cierre de plata', CAST(59.99 AS Decimal(10, 2)), 10, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (77, N'Bolígrafo de Acero Inoxidable', N'Bolígrafo de acero inoxidable resistente con acabado mate', CAST(14.99 AS Decimal(10, 2)), 35, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (78, N'Llavero de Cuero Rojo', N'Llavero de cuero rojo con diseño elegante y duradero', CAST(9.49 AS Decimal(10, 2)), 80, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (79, N'Cenicero de Aluminio Anodizado', N'Cenicero de aluminio anodizado en colores llamativos', CAST(11.99 AS Decimal(10, 2)), 40, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (80, N'Marcapáginas de Metal Dorado', N'Marcapáginas de metal dorado con borla de seda', CAST(8.29 AS Decimal(10, 2)), 60, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (81, N'Collar de Topacios', N'Collar de topacios genuinos con cadena de plata de ley', CAST(129.99 AS Decimal(10, 2)), 7, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (82, N'Bolígrafo de Plástico Reciclado', N'Bolígrafo ecológico de plástico reciclado', CAST(4.99 AS Decimal(10, 2)), 40, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (83, N'Llavero de Metal Plateado Mate', N'Llavero de metal plateado con acabado mate y diseño moderno', CAST(6.99 AS Decimal(10, 2)), 100, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (84, N'Cenicero de Cerámica Esmaltada', N'Cenicero de cerámica esmaltada con diseño artístico', CAST(16.49 AS Decimal(10, 2)), 28, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (85, N'Marcapáginas de Cuero Sintético', N'Marcapáginas de cuero sintético con borla decorativa', CAST(7.49 AS Decimal(10, 2)), 50, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (86, N'Collar de Diamantes y Perlas', N'Collar de diamantes y perlas con cadena de oro blanco', CAST(499.99 AS Decimal(10, 2)), 5, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (87, N'Bolígrafo de Aluminio Ligero', N'Bolígrafo de aluminio ligero y duradero con agarre ergonómico', CAST(19.99 AS Decimal(10, 2)), 25, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (88, N'Llavero de Metal Elegante', N'Llavero de metal elegante con diseño floral grabado', CAST(8.99 AS Decimal(10, 2)), 110, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (89, N'Cenicero de Porcelana Decorativa', N'Cenicero de porcelana decorativa con motivos florales', CAST(19.99 AS Decimal(10, 2)), 35, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (90, N'Marcapáginas de Metal Brillante', N'Marcapáginas de metal brillante con forma de mariposa', CAST(9.99 AS Decimal(10, 2)), 70, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (91, N'Collar de Tanzanitas', N'Collar de tanzanitas genuinas con cadena de plata de ley', CAST(179.99 AS Decimal(10, 2)), 8, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (92, N'Bolígrafo de Madera de Cerezo', N'Bolígrafo de madera de cerezo pulida a mano', CAST(29.99 AS Decimal(10, 2)), 15, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (93, N'Llavero de Metal Cromado Brillante', N'Llavero de metal cromado brillante con diseño geométrico', CAST(4.49 AS Decimal(10, 2)), 140, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (94, N'Cenicero de Vidrio Artístico', N'Cenicero de vidrio artístico hecho a mano con patrón abstracto', CAST(23.99 AS Decimal(10, 2)), 30, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (95, N'Marcapáginas de Plástico Flexible', N'Marcapáginas de plástico flexible en varios colores', CAST(3.99 AS Decimal(10, 2)), 90, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (96, N'Collar de Jade', N'Collar de jade auténtico con colgante de luna', CAST(89.99 AS Decimal(10, 2)), 9, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (97, N'Bolígrafo de Acero Inoxidable Premium', N'Bolígrafo de acero inoxidable premium con acabado pulido', CAST(39.99 AS Decimal(10, 2)), 18, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (98, N'Llavero de Cuero Grabado', N'Llavero de cuero genuino grabado con diseño personalizado', CAST(10.99 AS Decimal(10, 2)), 70, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (99, N'Cenicero de Madera Tallada', N'Cenicero de madera tallada a mano con motivos étnicos', CAST(29.99 AS Decimal(10, 2)), 25, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (100, N'Marcapáginas de Metal Antiguo', N'Marcapáginas de metal antiguo con incrustaciones de piedras preciosas', CAST(14.99 AS Decimal(10, 2)), 55, 2, 4)
GO
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (101, N'Collar de Coral', N'Collar de coral auténtico con cierre de plata de ley', CAST(199.99 AS Decimal(10, 2)), 6, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (102, N'Bolígrafo de Acero Inoxidable Mate', N'Bolígrafo de acero inoxidable mate con detalles en negro', CAST(19.99 AS Decimal(10, 2)), 22, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (103, N'Llavero de Metal Dorado Brillante', N'Llavero de metal dorado brillante con diseño en relieve', CAST(7.29 AS Decimal(10, 2)), 130, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (104, N'Cenicero de Piedra Natural', N'Cenicero de piedra natural pulida con textura suave', CAST(19.99 AS Decimal(10, 2)), 20, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (105, N'Marcapáginas de Cristal Tallado', N'Marcapáginas de cristal tallado con forma de diamante', CAST(8.99 AS Decimal(10, 2)), 60, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (106, N'Collar de Ambar', N'Collar de ambar auténtico con colgante de sol', CAST(149.99 AS Decimal(10, 2)), 7, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (107, N'Bolígrafo de Titanio Ligero', N'Bolígrafo de titanio ligero y resistente con diseño ergonómico', CAST(49.99 AS Decimal(10, 2)), 20, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (108, N'Llavero de Metal Plateado Pulido', N'Llavero de metal plateado pulido con forma de corazón', CAST(5.99 AS Decimal(10, 2)), 150, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (109, N'Cenicero de Porcelana Japonesa', N'Cenicero de porcelana japonesa tradicional con diseño oriental', CAST(26.99 AS Decimal(10, 2)), 28, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (110, N'Marcapáginas de Metal Mate', N'Marcapáginas de metal mate con detalle de hojas grabadas', CAST(6.99 AS Decimal(10, 2)), 75, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (111, N'Collar de Lapislázuli', N'Collar de lapislázuli genuino con cadena de plata chapada en oro', CAST(99.99 AS Decimal(10, 2)), 10, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (112, N'Bolígrafo de Ébano y Plata', N'Bolígrafo de ébano y plata con detalles en plata de ley', CAST(69.99 AS Decimal(10, 2)), 12, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (113, N'Llavero de Metal Mate Negro', N'Llavero de metal mate negro con diseño minimalista', CAST(4.79 AS Decimal(10, 2)), 120, 5, 10)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (114, N'Cenicero de Cerámica Esmaltada', N'Cenicero de cerámica esmaltada con diseño moderno', CAST(18.99 AS Decimal(10, 2)), 32, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (115, N'Marcapáginas de Plata Antigua', N'Marcapáginas de plata antigua con grabados florales', CAST(11.49 AS Decimal(10, 2)), 50, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (116, N'Collar de Turmalina', N'Collar de turmalina genuina con cadena de oro amarillo', CAST(179.99 AS Decimal(10, 2)), 8, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (117, N'Bolígrafo de Plástico Resistente', N'Bolígrafo de plástico resistente con punta de acero inoxidable', CAST(3.99 AS Decimal(10, 2)), 40, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (118, N'Llavero de Metal Cromado Elegante', N'Llavero de metal cromado elegante con diseño de lazo', CAST(6.49 AS Decimal(10, 2)), 100, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (119, N'Cenicero de Vidrio Templado Resistente', N'Cenicero de vidrio templado resistente a golpes y rayones', CAST(14.99 AS Decimal(10, 2)), 35, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (120, N'Marcapáginas de Plástico Transparente', N'Marcapáginas de plástico transparente con clip integrado', CAST(4.99 AS Decimal(10, 2)), 80, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (121, N'Collar de Obsidiana', N'Collar de obsidiana auténtica con cadena de plata de ley', CAST(89.99 AS Decimal(10, 2)), 7, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (122, N'Bolígrafo de Plástico Brillante', N'Bolígrafo de plástico brillante con punta retráctil', CAST(2.99 AS Decimal(10, 2)), 60, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (123, N'Llavero de Metal Dorado Mate', N'Llavero de metal dorado mate con diseño geométrico', CAST(7.99 AS Decimal(10, 2)), 90, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (124, N'Cenicero de Porcelana Decorativa', N'Cenicero de porcelana decorativa con patrón floral', CAST(17.99 AS Decimal(10, 2)), 25, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (125, N'Marcapáginas de Plástico Flexible', N'Marcapáginas de plástico flexible con forma de animal', CAST(3.49 AS Decimal(10, 2)), 70, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (126, N'Collar de Cuarzo Rosa', N'Collar de cuarzo rosa con cadena de plata esterlina', CAST(119.99 AS Decimal(10, 2)), 6, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (127, N'Bolígrafo de Aluminio Ligero', N'Bolígrafo de aluminio ligero con diseño ergonómico', CAST(9.99 AS Decimal(10, 2)), 30, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (128, N'Llavero de Metal Plateado Brillante', N'Llavero de metal plateado brillante con forma de estrella', CAST(4.49 AS Decimal(10, 2)), 110, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (129, N'Cenicero de Cerámica Pintada a Mano', N'Cenicero de cerámica pintada a mano con motivos abstractos', CAST(21.99 AS Decimal(10, 2)), 30, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (130, N'Marcapáginas de Metal Plateado', N'Marcapáginas de metal plateado con incrustaciones de piedras', CAST(10.99 AS Decimal(10, 2)), 60, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (131, N'Collar de Ámbar Báltico', N'Collar de ámbar báltico auténtico con cuentas de ámbar natural', CAST(149.99 AS Decimal(10, 2)), 8, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (132, N'Bolígrafo de Plástico Reciclado', N'Bolígrafo de plástico reciclado con agarre ergonómico', CAST(1.99 AS Decimal(10, 2)), 50, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (133, N'Llavero de Metal Elegante', N'Llavero de metal elegante con diseño floral grabado', CAST(8.49 AS Decimal(10, 2)), 120, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (134, N'Cenicero de Porcelana Oriental', N'Cenicero de porcelana oriental con patrón tradicional japonés', CAST(24.99 AS Decimal(10, 2)), 22, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (135, N'Marcapáginas de Metal Negro', N'Marcapáginas de metal negro con acabado mate', CAST(7.49 AS Decimal(10, 2)), 80, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (136, N'Collar de Rubíes', N'Collar de rubíes genuinos con cadena de oro de 18 quilates', CAST(299.99 AS Decimal(10, 2)), 4, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (137, N'Bolígrafo de Acero Inoxidable Mate', N'Bolígrafo de acero inoxidable mate con detalles en dorado', CAST(17.99 AS Decimal(10, 2)), 28, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (138, N'Llavero de Metal Plateado Pulido', N'Llavero de metal plateado pulido con diseño de corazón', CAST(6.29 AS Decimal(10, 2)), 140, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (139, N'Cenicero de Madera Tallada a Mano', N'Cenicero de madera tallada a mano con diseño étnico', CAST(27.99 AS Decimal(10, 2)), 20, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (140, N'Marcapáginas de Metal Antiguo', N'Marcapáginas de metal antiguo con incrustaciones de piedras preciosas', CAST(13.99 AS Decimal(10, 2)), 65, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (141, N'Collar de Esmeraldas', N'Collar de esmeraldas genuinas con cadena de oro blanco', CAST(499.99 AS Decimal(10, 2)), 3, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (142, N'Bolígrafo de Titanio Premium', N'Bolígrafo de titanio premium con acabado mate y detalles en negro', CAST(59.99 AS Decimal(10, 2)), 15, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (143, N'Llavero de Metal Cromado Brillante', N'Llavero de metal cromado brillante con diseño moderno', CAST(5.49 AS Decimal(10, 2)), 130, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (144, N'Cenicero de Vidrio Templado', N'Cenicero de vidrio templado resistente con patrón grabado', CAST(16.99 AS Decimal(10, 2)), 40, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (145, N'Marcapáginas de Plástico Resistente', N'Marcapáginas de plástico resistente en colores brillantes', CAST(5.99 AS Decimal(10, 2)), 100, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (146, N'Collar de Zafiros', N'Collar de zafiros genuinos con cadena de plata de ley', CAST(399.99 AS Decimal(10, 2)), 5, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (147, N'Bolígrafo de Plástico Ecológico', N'Bolígrafo de plástico ecológico con tinta recargable', CAST(2.49 AS Decimal(10, 2)), 45, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (148, N'Llavero de Metal Dorado Brillante', N'Llavero de metal dorado brillante con diseño de mariposa', CAST(8.99 AS Decimal(10, 2)), 120, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (149, N'Cenicero de Porcelana Blanca', N'Cenicero de porcelana blanca con acabado brillante', CAST(19.99 AS Decimal(10, 2)), 26, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (150, N'Marcapáginas de Metal Dorado', N'Marcapáginas de metal dorado con detalle de flores grabadas', CAST(9.99 AS Decimal(10, 2)), 70, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (151, N'Collar de Granates', N'Collar de granates genuinos con cadena de plata de ley', CAST(199.99 AS Decimal(10, 2)), 7, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (152, N'Bolígrafo de Aluminio Resistente', N'Bolígrafo de aluminio resistente con clip de metal', CAST(8.99 AS Decimal(10, 2)), 25, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (153, N'Llavero de Metal Plateado Pulido', N'Llavero de metal plateado pulido con diseño de llave', CAST(4.79 AS Decimal(10, 2)), 110, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (154, N'Cenicero de Cerámica Hecho a Mano', N'Cenicero de cerámica hecho a mano con detalles pintados', CAST(22.99 AS Decimal(10, 2)), 35, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (155, N'Marcapáginas de Plata Antigua', N'Marcapáginas de plata antigua con grabados de hojas', CAST(12.49 AS Decimal(10, 2)), 55, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (156, N'Collar de Peridotos', N'Collar de peridotos genuinos con cadena de plata de ley', CAST(149.99 AS Decimal(10, 2)), 8, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (157, N'Bolígrafo de Plástico Transparente', N'Bolígrafo de plástico transparente con tinta de colores', CAST(1.99 AS Decimal(10, 2)), 70, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (158, N'Llavero de Metal Elegante', N'Llavero de metal elegante con diseño de flores grabado', CAST(7.49 AS Decimal(10, 2)), 130, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (159, N'Cenicero de Porcelana Europea', N'Cenicero de porcelana europea con patrón tradicional', CAST(25.99 AS Decimal(10, 2)), 30, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (160, N'Marcapáginas de Metal Brillante', N'Marcapáginas de metal brillante con forma de corazón', CAST(8.99 AS Decimal(10, 2)), 75, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (161, N'Collar de Aguamarinas', N'Collar de aguamarinas genuinas con cadena de plata esterlina', CAST(179.99 AS Decimal(10, 2)), 6, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (162, N'Bolígrafo de Acero Inoxidable Pulido', N'Bolígrafo de acero inoxidable pulido con detalles en dorado', CAST(29.99 AS Decimal(10, 2)), 20, 4, 8)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (163, N'Llavero de Metal Cromado Mate', N'Llavero de metal cromado mate con diseño minimalista', CAST(5.49 AS Decimal(10, 2)), 140, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (164, N'Cenicero de Cristal Tallado', N'Cenicero de cristal tallado con patrón floral', CAST(18.99 AS Decimal(10, 2)), 32, 1, 2)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (165, N'Marcapáginas de Plástico Brillante', N'Marcapáginas de plástico brillante en colores vivos', CAST(6.99 AS Decimal(10, 2)), 85, 2, 4)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (166, N'Collar de Coral Negro', N'Collar de coral negro auténtico con cadena de plata de ley', CAST(249.99 AS Decimal(10, 2)), 5, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (167, N'Bolígrafo de Plástico Resistente', N'Bolígrafo de plástico resistente con agarre de goma', CAST(3.99 AS Decimal(10, 2)), 40, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (168, N'Llavero de Metal Plateado Brillante', N'Llavero de metal plateado brillante con diseño de diamante', CAST(7.99 AS Decimal(10, 2)), 150, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (169, N'Cenicero de Porcelana Vintage', N'Cenicero de porcelana vintage con patrón retro', CAST(23.99 AS Decimal(10, 2)), 28, 1, 1)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (170, N'Marcapáginas de Metal Antiguo', N'Marcapáginas de metal antiguo con borla de seda', CAST(15.99 AS Decimal(10, 2)), 60, 2, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (171, N'Collar de Amatistas', N'Collar de amatistas genuinas con cadena de oro de 24 quilates', CAST(599.99 AS Decimal(10, 2)), 4, 3, 5)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (172, N'Bolígrafo de Plástico Ecológico', N'Bolígrafo de plástico ecológico con tinta recargable', CAST(2.49 AS Decimal(10, 2)), 50, 4, 7)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (173, N'Llavero de Metal Dorado Mate', N'Llavero de metal dorado mate con diseño de corazón', CAST(8.99 AS Decimal(10, 2)), 130, 5, 9)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (174, N'Cenicero de Porcelana Azul', N'Cenicero de porcelana azul con patrón geométrico', CAST(20.99 AS Decimal(10, 2)), 24, 1, 3)
INSERT [dbo].[Productos] ([IDPRODUCTO], [NOMBRE], [DESCRIPCION], [PRECIO], [INVENTARIO], [IDCATEGORIA], [IDSUBCATEGORIA]) VALUES (175, N'Marcapáginas de Plástico Flexible', N'Marcapáginas de plástico flexible con forma de animal', CAST(4.99 AS Decimal(10, 2)), 90, 2, 3)
GO
INSERT [dbo].[Provincias] ([IDPROVINCIA], [NOMBRE]) VALUES (1, N'Madrid')
INSERT [dbo].[Provincias] ([IDPROVINCIA], [NOMBRE]) VALUES (2, N'Barcelona')
INSERT [dbo].[Provincias] ([IDPROVINCIA], [NOMBRE]) VALUES (3, N'Valencia')
INSERT [dbo].[Provincias] ([IDPROVINCIA], [NOMBRE]) VALUES (4, N'Sevilla')
INSERT [dbo].[Provincias] ([IDPROVINCIA], [NOMBRE]) VALUES (5, N'Alicante')
GO
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (1, N'Cuadrados', 1)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (2, N'Redondos', 1)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (3, N'Clásicos', 2)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (4, N'Decorativos', 2)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (5, N'Collares', 3)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (6, N'Pendientes', 3)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (7, N'Normales', 4)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (8, N'Personalizados', 4)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (9, N'Metálicos', 5)
INSERT [dbo].[Subcategorias] ([IDSUBCATEGORIA], [NOMBRE], [IDCATEGORIA]) VALUES (10, N'Acrílicos', 5)
GO
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (1, N'usuario1', N'Juan', N'Pérez', N'juan@example.com', N'Calle Principal, 123', NULL, NULL, NULL, NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (2, N'usuario2', N'María', N'González', N'maria@example.com', N'Avenida Central, 456', NULL, NULL, NULL, NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (3, N'usuario3', N'Carlos', N'Sánchez', N'carlos@example.com', N'Carrera 7, 890', NULL, NULL, NULL, NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (4, N'usuario4', N'Pedro', N'López', N'pedro@example.com', N'Calle Mayor, 456', NULL, NULL, N'123123123', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (5, N'usuario5', N'Laura', N'Martínez', N'laura@example.com', N'Plaza Principal, 789', NULL, NULL, N'456456456', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (6, N'usuario6', N'Ana', N'Hernández', N'ana@example.com', N'Paseo de la Reforma, 1011', NULL, NULL, N'789789789', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (7, N'usuario7', N'David', N'Rodríguez', N'david@example.com', N'Calle del Sol, 1213', NULL, NULL, N'159159159', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (8, N'usuario8', N'Sofía', N'Díaz', N'sofia@example.com', N'Avenida de la Luna, 1415', NULL, NULL, N'357357357', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (9, N'usuario9', N'Manuel', N'Gómez', N'manuel@example.com', N'Calle de la Esperanza, 1617', NULL, NULL, N'753753753', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (10, N'usuario10', N'Elena', N'Fernández', N'elena@example.com', N'Paseo de los Álamos, 1819', NULL, NULL, N'951951951', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (11, N'usuario11', N'Marta', N'Ruiz', N'marta@example.com', N'Calle de los Rosales, 2021', NULL, NULL, N'246246246', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (12, N'usuario12', N'Alberto', N'Torres', N'alberto@example.com', N'Avenida de los Pinos, 2223', NULL, NULL, N'468468468', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (13, N'usuario13', N'Clara', N'Jiménez', N'clara@example.com', N'Carrera 12, 2425', NULL, NULL, N'680680680', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (14, N'usuario14', N'Javier', N'Ramírez', N'javier@example.com', N'Calle de las Flores, 2627', NULL, NULL, N'802802802', NULL)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (15, N'Maacarenaa.mbv', N'Macarena', N'Mamolar', N'macarena99@gmail.com', N'Calle prueba', N':Ia:>Ç^E¾ÁýC°ßBüGúeG2Q]î÷èd&Øù·ù;', 5, N'123456789', 0xD125687D66CC52A1CC810D7739CC241E2C52480660C3192BACB26DE84307998B1D3BD9442E40737C1DDAAFE139E52BAD31632583B30707D00D88E93967F34943)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (16, N'UsuarioPrueba', N'Usuario', N'Prueba', N'usuarioprueba@example.com', N'Calle prueba', N'Üe ç%"Y©tdBzÑMÜN-öW%làÃ¨³L_¯¼!²I»(3/|', 1, N'123456789', 0x77D7EAAA866BCCF1A252C8563C246E2CB80D8B032B414147F06F34122B5AFF9A10FF4663B5FB2557C5C1D5CD5C3635370A6F97466576DEBD9B84634CE5FD00A2)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (17, N'Naagoree', N'Nagore', N'Barrero', N'nagore@barrero.com', N'Calle prueba', N'#ª+P4chM}K%y:ôù­:/¦ï»³µv|Ç''¸+Î¢êû>væmùÄ¦·4', 3, N'987654321', 0xB0C7BCBFC0FD8FA2DF7C912AAAD75ECDDFC3745CB17A4E2CB0EA5005C931FFB9466DF1C50804CE1C0F823DA4741527C18778303226F4087119D4DAB5E3BF7F10)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (18, N'MacarenaPrueba', N'MacarenaCambio', N'Prueba', N'macarena99@hotmail.com', N'Calle preuba', N'»ÙÛµ{½6@Ó-aÓ1/&4ïÍùNÀ>áOc¿6«²SÀ[i(', 1, N'123456789', 0x2D7CB0C7F94174C40B4A015ECAD40CB0A21F577D5220FBF4FB57CCF9922A83412B0A03F0D19CB9416BD5387EE18A2A62AA77B0DA39363A546B2D6D5DD992AE71)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (19, N'NombrePrueba', N'Prueba', N'Clase', N'macarena@example.com', N'Calle prueba', N'¿²^í»×"Ç83ýÉçª#)µGÓ¼¶Y°®âÅ»8îCÎÏ0a§áÀ8+Â', 1, N'987654321', 0x4683C4934D8524812417BCEC6B068C29D8830A598C195E2E1812F254E9BBF11C1E14C5496230A27EE65751582D0BE5F7940D8E79EE5581A78BFA30EA3E653CC1)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (20, N'PruebaMMM', N'adsf', N'PruebaCambio', N'macarenaprueba@hola.com', N'Calle de prueba', N'>\*²q	*ý·)ÓJ¿J4ð£Á4¬Héòýq=Ýì}êTðYu¦F£.ï', 2, N'123456789', 0x4F6B9D0B2D343FC2A77AFC66A10AF77E364B56307D40A00D6A4A74137E8A394DF2A0943BA9A29A9818A7325D56B907F5F383A00AF7A23DA5A716E935E927DD6A)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (25, N'Login', N'Login', N'Prueba', N'login@gmail.com', N'Calle cambio', N'ÔuÎZ}ÏùÍù6¤÷AÙ±«?A~Ç°µ$ÆÙ®ojnÌ9á', 1, N'123456789', 0x7E464967C10CF15E3695582D3D56F1972DB887C84130878B3A1E2C1336C66875DB79949DBC681059F6C7BE7FDFA5594CE9BD81A70BE31BCEA66C1AE38C1C11D3)
INSERT [dbo].[Usuarios] ([IDUSUARIO], [NOMBREUSUARIO], [NOMBRE], [APELLIDO], [CORREO], [DIRECCION], [SALT], [IDPROVINCIA], [TELEFONO], [PASSENCRIPT]) VALUES (26, N'Admin', N'Admin', N'Prueba', N'admin@gmail.com', N'Calle prueba', N'/¬¡ë|eªñÕeWC±hïöçÜõÏ°Ao@í0,Þô\b]¾Ñß¨«ÛÛÙÞb:e', 1, N'123456789', 0x71D1026AACF9A09411813E01F39465B4081614D93D699D53C0345DC763D5BE989CF730A100906E4D54DC2613728893C73CD2E91F6A77AD52B5771A29BEC7E03F)
GO
ALTER TABLE [dbo].[Comentarios]  WITH CHECK ADD FOREIGN KEY([IDPRODUCTO])
REFERENCES [dbo].[Productos] ([IDPRODUCTO])
GO
ALTER TABLE [dbo].[Comentarios]  WITH CHECK ADD  CONSTRAINT [FK__Comentari__IDUSU__619B8048] FOREIGN KEY([IDUSUARIO])
REFERENCES [dbo].[Usuarios] ([IDUSUARIO])
GO
ALTER TABLE [dbo].[Comentarios] CHECK CONSTRAINT [FK__Comentari__IDUSU__619B8048]
GO
ALTER TABLE [dbo].[DetallesPedido]  WITH CHECK ADD FOREIGN KEY([IDPEDIDO])
REFERENCES [dbo].[Pedidos] ([IDPEDIDO])
GO
ALTER TABLE [dbo].[DetallesPedido]  WITH CHECK ADD FOREIGN KEY([IDPRODUCTO])
REFERENCES [dbo].[Productos] ([IDPRODUCTO])
GO
ALTER TABLE [dbo].[ImagenesProductos]  WITH CHECK ADD FOREIGN KEY([IDPRODUCTO])
REFERENCES [dbo].[Productos] ([IDPRODUCTO])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK__Pedidos__IDUSUAR__5812160E] FOREIGN KEY([IDUSUARIO])
REFERENCES [dbo].[Usuarios] ([IDUSUARIO])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK__Pedidos__IDUSUAR__5812160E]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([IDCATEGORIA])
REFERENCES [dbo].[Categorias] ([IDCATEGORIA])
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([IDSUBCATEGORIA])
REFERENCES [dbo].[Subcategorias] ([IDSUBCATEGORIA])
GO
ALTER TABLE [dbo].[Subcategorias]  WITH CHECK ADD FOREIGN KEY([IDCATEGORIA])
REFERENCES [dbo].[Categorias] ([IDCATEGORIA])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK__Usuarios__IDPROV__4CA06362] FOREIGN KEY([IDPROVINCIA])
REFERENCES [dbo].[Provincias] ([IDPROVINCIA])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK__Usuarios__IDPROV__4CA06362]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPO_PRODUCTOS]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GRUPO_PRODUCTOS](@posicion int)
as
	select IDPRODUCTO, NOMBRE, DESCRIPCION, PRECIO, INVENTARIO, IDCATEGORIA, IDSUBCATEGORIA FROM V_GRUPO_PRODUCTOS
	where posicion >= @posicion and posicion < (@posicion + 16)
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPO_PRODUCTOS_CATEGORIA]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GRUPO_PRODUCTOS_CATEGORIA](@posicion int, @idcategoria int)
as
	select IDPRODUCTO, NOMBRE, DESCRIPCION, PRECIO, INVENTARIO, IDCATEGORIA, IDSUBCATEGORIA FROM 
	(select cast(
		row_number() over (order by NOMBRE) as int) as posicion,
		IDPRODUCTO, NOMBRE, DESCRIPCION, PRECIO, INVENTARIO, IDCATEGORIA, IDSUBCATEGORIA FROM Productos
	where IDCATEGORIA = @idcategoria) as QUERY
	where QUERY.posicion >= @posicion and posicion < (@posicion + 16)
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPO_PRODUCTOS_POR_CATEGORIA]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GRUPO_PRODUCTOS_POR_CATEGORIA]
    @IDCATEGORIA int,
    @posicion int
as
begin
    select IDPRODUCTO, NOMBRE, DESCRIPCION, PRECIO, INVENTARIO, IDCATEGORIA, IDSUBCATEGORIA 
    from V_GRUPO_PRODUCTOS
    where IDCATEGORIA = @IDCATEGORIA and posicion >= @posicion and posicion < (@posicion + 16)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRO_PRODUCTO_CATEGORIA]    Script Date: 20/03/2024 11:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     CREATE procedure [dbo].[SP_REGISTRO_PRODUCTO_CATEGORIA]
(@posicion int, @categoria int 
, @registros int out) 
as 
select @registros = count(IDPRODUCTO) from Productos 
where IDCATEGORIA=@categoria 
select IDPRODUCTO, NOMBRE, DESCRIPCION, PRECIO, INVENTARIO,IDCATEGORIA,IDSUBCATEGORIA from  
    (select cast( 
    ROW_NUMBER() OVER (ORDER BY NOMBRE) as int) AS POSICION 
    , IDPRODUCTO, NOMBRE, DESCRIPCION, PRECIO, INVENTARIO,IDCATEGORIA,IDSUBCATEGORIA 
    from Productos 
    where IDCATEGORIA=@categoria) as QUERY 
    where QUERY.POSICION >= @posicion and QUERY.POSICION < (@posicion + 2)

GO
