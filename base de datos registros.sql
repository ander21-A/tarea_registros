CREATE SCHEMA `registros` ;

CREATE TABLE `registros`.`clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(60) NULL,
  `apellidos` VARCHAR(60) NULL,
  `nit` VARCHAR(12) NULL,
  `genero` BIT NULL,
  `telefono` VARCHAR(25) NULL,
  `correo_electronico` VARCHAR(45) NULL,
  `fecha_ingreso` DATETIME NULL,
  PRIMARY KEY (`id_cliente`));

CREATE TABLE `registros`.`ventas` (
  `id_ventas` INT NOT NULL AUTO_INCREMENT,
  `no_factura` INT NULL,
  `serie` CHAR(1) NULL,
  `fecha_factura` DATE NULL,
  `id_cliente` INT NULL,
  `id_empleado` INT NULL,
  `fecha_ingreso` DATETIME NULL,
  PRIMARY KEY (`id_ventas`));
ALTER TABLE `registros`.`ventas` 
ADD INDEX `id_cliente_cliente_ventas_idx` (`id_cliente` ASC) VISIBLE;
;
ALTER TABLE `registros`.`ventas` 
ADD CONSTRAINT `id_cliente_cliente_ventas`
  FOREIGN KEY (`id_cliente`)
  REFERENCES `registros`.`ventas` (`id_ventas`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `registros`.`ventas` 
ADD INDEX `id_empleado_empleados_ventas_idx` (`id_empleado` ASC) VISIBLE;
;
ALTER TABLE `registros`.`ventas` 
ADD CONSTRAINT `id_empleado_empleados_ventas`
  FOREIGN KEY (`id_empleado`)
  REFERENCES `registros`.`empleados` (`id_empleado`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `registros`.`empleados` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(60) NULL,
  `apellidos` VARCHAR(60) NULL,
  `direccion` VARCHAR(60) NULL,
  `telefono` VARCHAR(25) NULL,
  `dpi` VARCHAR(25) NULL,
  `genero` BIT NULL,
  `fecha_nacimiento` DATE NULL,
  `id_puesto` SMALLINT NULL,
  `fecha_inicio_labores` DATE NULL,
  `fecha_ingreso` DATETIME NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `id_puesto_puesto_empleados_idx` (`id_puesto` ASC) VISIBLE,
  CONSTRAINT `id_puesto_puesto_empleados`
    FOREIGN KEY (`id_puesto`)
    REFERENCES `registros`.`puestos` (`id_puesto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

CREATE TABLE `registros`.`ventas_detalle` (
  `id_ventadetalle` BIGINT NOT NULL AUTO_INCREMENT,
  `id_venta` INT NULL,
  `id_producto` INT NULL,
  `cantidad` VARCHAR(45) NULL,
  `precio_unitario` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id_ventadetalle`),
  INDEX `id_venta_ventas_ventas_detalle_idx` (`id_venta` ASC) VISIBLE,
  CONSTRAINT `id_venta_ventas_ventas_detalle`
    FOREIGN KEY (`id_venta`)
    REFERENCES `registros`.`ventas` (`id_ventas`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

CREATE TABLE `registros`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `producto` VARCHAR(50) NULL,
  `id_marca` SMALLINT NULL,
  `descripcion` VARCHAR(100) NULL,
  `imagen` VARCHAR(30) NULL,
  `precio_costo` DECIMAL(8,2) NULL,
  `precio_venta` DECIMAL(8,2) NULL,
  `existencia` INT NULL,
  `fecha_ingreso` DATETIME NULL,
  PRIMARY KEY (`id_producto`));
ALTER TABLE `registros`.`productos` 
ADD INDEX `id_marca_marcas_productos_idx` (`id_marca` ASC) VISIBLE;
;
ALTER TABLE `registros`.`productos` 
ADD CONSTRAINT `id_marca_marcas_productos`
  FOREIGN KEY (`id_marca`)
  REFERENCES `registros`.`marcas` (`id_marca`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `registros`.`productos` 
DROP FOREIGN KEY `id_marca_marcas_productos`;
ALTER TABLE `registros`.`productos` 
ADD CONSTRAINT `id_marca_marcas_productos`
  FOREIGN KEY (`id_marca`)
  REFERENCES `registros`.`marcas` (`id_marca`)
  ON UPDATE CASCADE;

CREATE TABLE `registros`.`marcas` (
  `id_marca` SMALLINT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(60) NULL,
  PRIMARY KEY (`id_marca`));

ALTER TABLE `registros`.`marcas` 
CHANGE COLUMN `marca` `marca` VARCHAR(60) NULL ;

CREATE TABLE `registros`.`compras_detalle` (
  `id_compra_detalle` BIGINT NOT NULL AUTO_INCREMENT,
  `id_compra` INT NULL,
  `id_producto` INT NULL,
  `cantidad` INT NULL,
  `precio_costo_unitario` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id_compra_detalle`),
  INDEX `id_producto_producto_compras_datella_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `id_producto_producto_compras_datella`
    FOREIGN KEY (`id_producto`)
    REFERENCES `registros`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

CREATE TABLE `registros`.`proveedores` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `proveedore` VARCHAR(60) NULL,
  `nit` VARCHAR(12) NULL,
  `direccion` VARCHAR(80) NULL,
  `telefono` VARCHAR(25) NULL,
  PRIMARY KEY (`id_proveedor`));

ALTER TABLE `registros`.`compras` 
ADD INDEX `id_proveedor_proveedor_compras_idx` (`id_proveedor` ASC) VISIBLE;
;
ALTER TABLE `registros`.`compras` 
ADD CONSTRAINT `id_proveedor_proveedor_compras`
  FOREIGN KEY (`id_proveedor`)
  REFERENCES `registros`.`proveedores` (`id_proveedor`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;