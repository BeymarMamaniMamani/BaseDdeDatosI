USE [atencion_al_cliente]
GO
/****** Object:  User [RonaldBaseDeDatosI]    Script Date: 18/11/2021 13:54:04 ******/
CREATE USER [RonaldBaseDeDatosI] FOR LOGIN [RonaldBaseDeDatosI] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [RonaldHito2]    Script Date: 18/11/2021 13:54:04 ******/
CREATE USER [RonaldHito2] FOR LOGIN [RonaldHito2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[numeros_naturales]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[numeros_naturales](@parametro1 INT)
    RETURNS VARCHAR(100) AS
    BEGIN
     -- utilizando WHILE
        DECLARE @respuesta VARCHAR(100) = '';
        DECLARE @contador INTEGER = 1;

        WHILE @contador <= @parametro1
            BEGIN
                IF (@contador%2=0)
                    BEGIN
                        SET @respuesta = CONCAT(@respuesta, @contador, ', ');
                    end
                SET @contador = @contador + 1;
            END;

        RETURN @respuesta;

    END
GO
/****** Object:  Table [dbo].[marca_auto]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[marca_auto](
	[id_marca] [int] NOT NULL,
	[marca] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productos_autos]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productos_autos](
	[id_auto] [int] NOT NULL,
	[nombre_auto] [varchar](30) NOT NULL,
	[tipo_auto] [varchar](30) NOT NULL,
	[id_marca] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_auto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caracteristicas_del_auto]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caracteristicas_del_auto](
	[numero_auto] [int] IDENTITY(1,1) NOT NULL,
	[color] [varchar](30) NOT NULL,
	[motor] [varchar](100) NOT NULL,
	[caja] [varchar](100) NULL,
	[modelo] [int] NOT NULL,
	[asientos] [int] NOT NULL,
	[peso_kg] [int] NOT NULL,
	[id_auto] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numero_auto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[precio]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[precio](
	[numero_auto] [int] IDENTITY(1,1) NOT NULL,
	[precio_normal] [int] NOT NULL,
	[credito] [int] NOT NULL,
	[descuento] [int] NOT NULL,
	[cuotas] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numero_auto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Gama_segun_Precio]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Gama_segun_Precio] AS
    SELECT prod.nombre_auto AS Nombre, ma.marca AS Marca, prod.tipo_auto, pre.precio_normal AS Precio , Gama =
        CASE
            WHEN pre.precio_normal > 10000 AND pre.precio_normal <= 15000 THEN 'Gama Basica'
            WHEN pre.precio_normal > 15000 AND pre.precio_normal <= 20000 THEN 'Gama Intermedia'
            WHEN pre.precio_normal > 20000 AND pre.precio_normal <= 25000 THEN 'Gama Alta'
            WHEN pre.precio_normal > 25000 THEN 'Gama Alta++'
        END
    FROM precio AS pre
    INNER JOIN caracteristicas_del_auto AS carac ON pre.numero_auto = carac.numero_auto
    INNER JOIN productos_autos AS prod ON carac.id_auto = prod.id_auto
    INNER JOIN marca_auto AS ma ON prod.id_marca = ma.id_marca
GO
/****** Object:  View [dbo].[Autos_King_long]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_King_long] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 911
GO
/****** Object:  View [dbo].[Autos_Great_Wall]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_Great_Wall] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 111
GO
/****** Object:  View [dbo].[Autos_Haval]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_Haval] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 211
GO
/****** Object:  View [dbo].[Autos_Geely]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_Geely] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 311
GO
/****** Object:  View [dbo].[Autos_Forland]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_Forland] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 411
GO
/****** Object:  View [dbo].[Autos_JMC]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_JMC] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 511
GO
/****** Object:  View [dbo].[Autos_Changan]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_Changan] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 611
GO
/****** Object:  View [dbo].[Autos_Chery]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_Chery] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 711
GO
/****** Object:  View [dbo].[Autos_Foton]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Autos_Foton] AS
    SELECT ma.marca, prod.nombre_auto, prod.tipo_auto
    FROM marca_auto AS ma
    INNER JOIN productos_autos AS prod ON ma.id_marca = prod.id_marca
    WHERE ma.id_marca = 811
GO
/****** Object:  Table [dbo].[administradores]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[administradores](
	[id_admin] [int] NOT NULL,
	[nombres] [varchar](50) NOT NULL,
	[apellidos] [varchar](100) NOT NULL,
	[correo_electronico] [varchar](100) NULL,
	[sede_ciudad] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[citas_y_reservas]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[citas_y_reservas](
	[numero_de_cita] [int] IDENTITY(1,1) NOT NULL,
	[ci_cliente] [varchar](15) NOT NULL,
	[id_admin] [int] NOT NULL,
	[horario] [varchar](10) NOT NULL,
	[ciudad] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numero_de_cita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[horario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 18/11/2021 13:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[ci] [varchar](15) NOT NULL,
	[nombres] [varchar](50) NOT NULL,
	[apellidos] [varchar](100) NOT NULL,
	[correo] [varchar](100) NULL,
	[ciudad] [varchar](50) NOT NULL,
	[id_auto] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ci] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[caracteristicas_del_auto]  WITH CHECK ADD FOREIGN KEY([id_auto])
REFERENCES [dbo].[productos_autos] ([id_auto])
GO
ALTER TABLE [dbo].[citas_y_reservas]  WITH CHECK ADD FOREIGN KEY([ci_cliente])
REFERENCES [dbo].[clientes] ([ci])
GO
ALTER TABLE [dbo].[citas_y_reservas]  WITH CHECK ADD FOREIGN KEY([id_admin])
REFERENCES [dbo].[administradores] ([id_admin])
GO
ALTER TABLE [dbo].[clientes]  WITH CHECK ADD FOREIGN KEY([id_auto])
REFERENCES [dbo].[productos_autos] ([id_auto])
GO
ALTER TABLE [dbo].[precio]  WITH CHECK ADD FOREIGN KEY([numero_auto])
REFERENCES [dbo].[caracteristicas_del_auto] ([numero_auto])
GO
ALTER TABLE [dbo].[productos_autos]  WITH CHECK ADD FOREIGN KEY([id_marca])
REFERENCES [dbo].[marca_auto] ([id_marca])
GO
