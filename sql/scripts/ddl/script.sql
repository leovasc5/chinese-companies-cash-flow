
-- -----------------------------------------------------
-- Schema supermercado
-- -----------------------------------------------------
-- Banco de dados de um supermercado.
DROP SCHEMA IF EXISTS `supermercado` ;

-- -----------------------------------------------------
-- Schema supermercado
--
-- Banco de dados de um supermercado.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `supermercado`;
USE `supermercado` ;

-- -----------------------------------------------------
-- Table `supermercado`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`endereco` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`endereco` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(64) NOT NULL,
  `estado` VARCHAR(64) NOT NULL,
  `pais` VARCHAR(64) NOT NULL,
  `codigo_postal` CHAR(5) NOT NULL,
  `regiao` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermercado`.`transporte`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`transporte` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`transporte` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `modo_UNIQUE` ON `supermercado`.`transporte` (`titulo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `supermercado`.`perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`perfil` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`perfil` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(64) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `supermercado`.`perfil` (`id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `supermercado`.`consumidor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`consumidor` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`consumidor` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(64) NOT NULL,
  `id_perfil` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_consumidor_perfil1`
    FOREIGN KEY (`id_perfil`)
    REFERENCES `supermercado`.`perfil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_consumidor_perfil1_idx` ON `supermercado`.`consumidor` (`id_perfil` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `supermercado`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`pedido` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`pedido` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_pedido` DATETIME NOT NULL,
  `data_envio` DATETIME NOT NULL,
  `id_endereco` INT UNSIGNED NOT NULL,
  `id_transporte` INT UNSIGNED NOT NULL,
  `id_consumidor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pedido_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `supermercado`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_transporte1`
    FOREIGN KEY (`id_transporte`)
    REFERENCES `supermercado`.`transporte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_consumidor1`
    FOREIGN KEY (`id_consumidor`)
    REFERENCES `supermercado`.`consumidor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pedido_endereco_idx` ON `supermercado`.`pedido` (`id_endereco` ASC) VISIBLE;

CREATE INDEX `fk_pedido_transporte1_idx` ON `supermercado`.`pedido` (`id_transporte` ASC) VISIBLE;

CREATE INDEX `fk_pedido_consumidor1_idx` ON `supermercado`.`pedido` (`id_consumidor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `supermercado`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`categoria` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`categoria` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermercado`.`subcategoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`subcategoria` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`subcategoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(64) NOT NULL,
  `id_categoria` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_subcategoria_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `supermercado`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `supermercado`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`produto` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`produto` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(128) NOT NULL,
  `id_subcategoria` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_produto_subcategoria1`
    FOREIGN KEY (`id_subcategoria`)
    REFERENCES `supermercado`.`subcategoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `supermercado`.`produto_pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermercado`.`produto_pedido` ;

CREATE TABLE IF NOT EXISTS `supermercado`.`produto_pedido` (
  `id_produto` INT UNSIGNED NOT NULL,
  `id_pedido` INT UNSIGNED NOT NULL,
  `preco` DECIMAL(10,5) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_produto`, `id_pedido`),
  CONSTRAINT `fk_produto_has_pedido_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `supermercado`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_pedido_pedido1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `supermercado`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_produto_has_pedido_pedido1_idx` ON `supermercado`.`produto_pedido` (`id_pedido` ASC) VISIBLE;

CREATE INDEX `fk_produto_has_pedido_produto1_idx` ON `supermercado`.`produto_pedido` (`id_produto` ASC) VISIBLE;

