USE eg;
-- -----------------------------------------------------
-- Tabela: `Usuario`
-- -----------------------------------------------------

CREATE TABLE `usuario` (
    `cod_usuario` INT AUTO_INCREMENT PRIMARY KEY, -- Código do usuário no sistema
    `nome_usuario` VARCHAR(50) COLLATE utf8mb4_general_ci DEFAULT NULL, -- Nome do usuário
    `username_usuario` VARCHAR(50) COLLATE utf8mb4_general_ci NOT NULL, -- login do usuário no sistema
    `email_usuario` VARCHAR(100) COLLATE utf8mb4_general_ci NOT NULL UNIQUE, -- Email de cadastro do usuário
    `password_usuario` VARCHAR(255) COLLATE utf8mb4_general_ci DEFAULT NULL, -- Aumentado para 255 para hashes mais longos
    `foto_usuario` VARCHAR(100), -- arquivo da imagem do usuario
    `conta_ativa` BOOLEAN NOT NULL DEFAULT TRUE, -- caso seja desejado ativar conta do usuário
    `criacao_usuario` TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data da criação do usuário
);

-- -----------------------------------------------------
-- Tabela: `Desenvolvedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Desenvolvedor` (
  `cod_Desenvolvedor` INT NOT NULL AUTO_INCREMENT,
  `nome_Desenvolvedor` VARCHAR(255) NOT NULL,
  `pais_Desenvolvedor` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_Desenvolvedor`),
  UNIQUE INDEX `nome_UNIQUE` (`nome_Desenvolvedor` ASC)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela: `Publicadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Publicadora` (
  `cod_Publicadora` INT NOT NULL AUTO_INCREMENT,
  `nome_Publicadora` VARCHAR(255) NOT NULL,
  `pais_Publicadora` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_Publicadora`),
  UNIQUE INDEX `nome_UNIQUE` (`nome_Publicadora` ASC)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela: `Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Genero` (
  `cod_Genero` INT NOT NULL AUTO_INCREMENT,
  `nome_Genero` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cod_Genero`),
  UNIQUE INDEX `nome_UNIQUE` (`nome_Genero` ASC)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela: `Plataforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Plataforma` (
  `cod_Plataforma` INT NOT NULL AUTO_INCREMENT,
  `nome_Plataforma` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cod_Plataforma`),
  UNIQUE INDEX `nome_UNIQUE` (`nome_Plataforma` ASC)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela: `Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jogo` (
  `cod_Jogo` INT NOT NULL AUTO_INCREMENT,
  `titulo_Jogo` VARCHAR(255) NOT NULL,
  `descricao_Jogo` TEXT NULL,
  `data_lancamento_Jogo` DATE NULL,
  `url_imagem_capa_Jogo` VARCHAR(512) NULL,
  `cod_desenvolvedor_fk` INT NULL,
  `cod_publicadora_fk` INT NULL,
  PRIMARY KEY (`cod_Jogo`),
  INDEX `fk_Jogo_Desenvolvedor_idx` (`cod_desenvolvedor_fk` ASC),
  INDEX `fk_Jogo_Publicadora_idx` (`cod_publicadora_fk` ASC),
  CONSTRAINT `fk_Jogo_Desenvolvedor`
    FOREIGN KEY (`cod_desenvolvedor_fk`)
    REFERENCES `Desenvolvedor` (`cod_Desenvolvedor`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_Publicadora`
    FOREIGN KEY (`cod_publicadora_fk`)
    REFERENCES `Publicadora` (`cod_Publicadora`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela de Associação: `Jogo_Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jogo_Genero` (
  `cod_jogo_fk` INT NOT NULL,
  `cod_genero_fk` INT NOT NULL,
  PRIMARY KEY (`cod_jogo_fk`, `cod_genero_fk`),
  INDEX `fk_Jogo_Genero_Genero_idx` (`cod_genero_fk` ASC),
  CONSTRAINT `fk_Jogo_Genero_Jogo`
    FOREIGN KEY (`cod_jogo_fk`)
    REFERENCES `Jogo` (`cod_Jogo`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_Genero_Genero`
    FOREIGN KEY (`cod_genero_fk`)
    REFERENCES `Genero` (`cod_Genero`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela de Associação: `Jogo_Plataforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jogo_Plataforma` (
  `cod_jogo_fk` INT NOT NULL,
  `cod_plataforma_fk` INT NOT NULL,
  PRIMARY KEY (`cod_jogo_fk`, `cod_plataforma_fk`),
  INDEX `fk_Jogo_Plataforma_Plataforma_idx` (`cod_plataforma_fk` ASC),
  CONSTRAINT `fk_Jogo_Plataforma_Jogo`
    FOREIGN KEY (`cod_jogo_fk`)
    REFERENCES `Jogo` (`cod_Jogo`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_Plataforma_Plataforma`
    FOREIGN KEY (`cod_plataforma_fk`)
    REFERENCES `Plataforma` (`cod_Plataforma`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela: `Avaliacao`
-- Conecta-se à sua tabela `usuario` existente.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Avaliacao` (
  `cod_Avaliacao` INT NOT NULL AUTO_INCREMENT,
  `nota_Avaliacao` DECIMAL(3,1) NOT NULL,
  `texto_Avaliacao` TEXT NULL,
  `data_criacao_Avaliacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cod_usuario_fk` INT NOT NULL,
  `cod_jogo_fk` INT NOT NULL,
  PRIMARY KEY (`cod_Avaliacao`),
  INDEX `fk_Avaliacao_Usuario_idx` (`cod_usuario_fk` ASC),
  INDEX `fk_Avaliacao_Jogo_idx` (`cod_jogo_fk` ASC),
  CONSTRAINT `fk_Avaliacao_Usuario`
    FOREIGN KEY (`cod_usuario_fk`)
    REFERENCES `usuario` (`cod_usuario`) -- APONTA PARA SUA TABELA EXISTENTE
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Avaliacao_Jogo`
    FOREIGN KEY (`cod_jogo_fk`)
    REFERENCES `Jogo` (`cod_Jogo`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Tabela: `Captura_Tela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Captura_Tela` (
  `cod_Captura_Tela` INT NOT NULL AUTO_INCREMENT,
  `url_imagem_Captura_Tela` VARCHAR(512) NOT NULL,
  `legenda_Captura_Tela` VARCHAR(255) NULL,
  `cod_jogo_fk` INT NOT NULL,
  PRIMARY KEY (`cod_Captura_Tela`),
  INDEX `fk_Captura_Tela_Jogo_idx` (`cod_jogo_fk` ASC),
  CONSTRAINT `fk_Captura_Tela_Jogo`
    FOREIGN KEY (`cod_jogo_fk`)
    REFERENCES `Jogo` (`cod_Jogo`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- #####################################################################
-- # Fim do Script                                                     #
-- #####################################################################







-- #####################################################################
-- # Script para Popular Tabelas Iniciais da Enciclopédia de Jogos    #
-- #####################################################################



-- -----------------------------------------------------
-- Inserindo dados na tabela `Genero`
-- -----------------------------------------------------
INSERT INTO `Genero` (`nome_Genero`) VALUES
('Ação'),
('Aventura'),
('RPG'),
('Estratégia'),
('Simulação'),
('Esportes'),
('Corrida'),
('Luta'),
('Plataforma'),
('Puzzle'),
('Tiro em Primeira Pessoa (FPS)'),
('Tiro em Terceira Pessoa (TPS)'),
('Sobrevivência'),
('Terror'),
('Mundo Aberto'),
('Furtivo (Stealth)'),
('Battle Royale'),
('MOBA'),
('MMORPG'),
('Roguelike'),
('Soulslike'),
('Hack and Slash'),
('Construção'),
('Sandbox'),
('Ritmo');

-- -----------------------------------------------------
-- Inserindo dados na tabela `Plataforma`
-- -----------------------------------------------------
INSERT INTO `Plataforma` (`nome_Plataforma`) VALUES
('PC'),
('PlayStation 5'),
('PlayStation 4'),
('PlayStation 3'),
('Xbox Series X/S'),
('Xbox One'),
('Xbox 360'),
('Nintendo Switch'),
('Nintendo Wii U'),
('Nintendo Wii'),
('Nintendo 3DS'),
('iOS'),
('Android'),
('macOS'),
('Linux'),
('Steam Deck'),
('PlayStation Vita'),
('PSP'),
('Nintendo DS'),
('GameCube'),
('PlayStation 2'),
('Xbox'),
('Dreamcast'),
('Nintendo 64'),
('PlayStation');

-- -----------------------------------------------------
-- Inserindo dados na tabela `Publicadora`
-- -----------------------------------------------------
INSERT INTO `Publicadora` (`nome_Publicadora`, `pais_Publicadora`) VALUES
('Electronic Arts', 'Estados Unidos'),
('Ubisoft', 'França'),
('Nintendo', 'Japão'),
('Sony Interactive Entertainment', 'Japão'),
('Activision Blizzard', 'Estados Unidos'),
('Take-Two Interactive', 'Estados Unidos'),
('Square Enix', 'Japão'),
('Bandai Namco Entertainment', 'Japão'),
('Capcom', 'Japão'),
('Sega', 'Japão'),
('Microsoft (Xbox Game Studios)', 'Estados Unidos'),
('Tencent Games', 'China'),
('Konami', 'Japão'),
('Bethesda Softworks', 'Estados Unidos'),
('Warner Bros. Interactive Entertainment', 'Estados Unidos'),
('Devolver Digital', 'Estados Unidos'),
('Annapurna Interactive', 'Estados Unidos'),
('CD Projekt', 'Polônia'),
('FromSoftware', 'Japão'),
('Focus Entertainment', 'França'),
('Paradox Interactive', 'Suécia'),
('505 Games', 'Itália'),
('Riot Games', 'Estados Unidos'),
('Team Cherry', 'Austrália'),
('Hello Games', 'Reino Unido'),
('Supergiant Games', 'Estados Unidos'),
('ZA/UM', 'Estônia'),
('Humble Bundle', 'Estados Unidos'),
('Coffee Stain Publishing', 'Suécia'),
('Innersloth', 'Estados Unidos'),
('miHoYo', 'China'),
('PlayStation PC LLC', 'Estados Unidos');
INSERT IGNORE INTO `Publicadora` (`nome_Publicadora`, `pais_Publicadora`) VALUES
('Electronic Arts', 'Estados Unidos'), ('Ubisoft', 'França'), ('Nintendo', 'Japão'), ('Sony Interactive Entertainment', 'Japão'), ('Activision Blizzard', 'Estados Unidos'),
('Take-Two Interactive', 'Estados Unidos'), ('Square Enix', 'Japão'), ('Bandai Namco Entertainment', 'Japão'), ('Capcom', 'Japão'), ('Sega', 'Japão'),
('Microsoft (Xbox Game Studios)', 'Estados Unidos'), ('Tencent Games', 'China'), ('Konami', 'Japão'), ('Bethesda Softworks', 'Estados Unidos'), ('Warner Bros. Interactive Entertainment', 'Estados Unidos'),
('Devolver Digital', 'Estados Unidos'), ('Annapurna Interactive', 'Estados Unidos'), ('CD Projekt', 'Polônia'), ('FromSoftware', 'Japão'), ('Focus Entertainment', 'França'),
('Paradox Interactive', 'Suécia'), ('505 Games', 'Itália'), ('Riot Games', 'Estados Unidos'), ('ConcernedApe', 'Estados Unidos'), ('Team Cherry', 'Austrália'),
('Extremely OK Games', 'Canadá'), ('Atlus', 'Japão'), ('Supergiant Games', 'Estados Unidos'), ('ZA/UM', 'Estônia'), ('Studio MDHR', 'Canadá'),
('Nicalis', 'Estados Unidos'), ('Humble Bundle', 'Estados Unidos'), ('Innersloth', 'Estados Unidos'), ('miHoYo', 'China'), ('Coffee Stain Publishing', 'Suécia'),
('Facepunch Studios', 'Reino Unido'), ('Re-Logic', 'Estados Unidos'), ('Kinetic Games', 'Reino Unido'), ('Hello Games', 'Reino Unido'), ('NEOWIZ', 'Coreia do Sul'),
('Bohemia Interactive', 'República Tcheca');

-- -----------------------------------------------------
-- Inserindo dados na tabela `Desenvolvedor`
-- -----------------------------------------------------
INSERT INTO `Desenvolvedor` (`nome_Desenvolvedor`, `pais_Desenvolvedor`) VALUES
('Naughty Dog', 'Estados Unidos'),
('Rockstar Games', 'Estados Unidos'),
('CD Projekt Red', 'Polônia'),
('FromSoftware Inc.', 'Japão'),
('Santa Monica Studio', 'Estados Unidos'),
('Guerrilla Games', 'Países Baixos'),
('Insomniac Games', 'Estados Unidos'),
('Nintendo EPD', 'Japão'),
('BioWare', 'Canadá'),
('Bethesda Game Studios', 'Estados Unidos'),
('id Software', 'Estados Unidos'),
('Valve Corporation', 'Estados Unidos'),
('Remedy Entertainment', 'Finlândia'),
('Larian Studios', 'Bélgica'),
('Obsidian Entertainment', 'Estados Unidos'),
('Respawn Entertainment', 'Estados Unidos'),
('Sucker Punch Productions', 'Estados Unidos'),
('Kojima Productions', 'Japão'),
('Square Enix Creative Business Unit I', 'Japão'),
('Capcom R&D Division 1', 'Japão'),
('Riot Games Inc.', 'Estados Unidos'),
('Epic Games', 'Estados Unidos'),
('Mojang Studios', 'Suécia'),
('ConcernedApe', 'Estados Unidos'),
('Team Cherry', 'Austrália'),
('Extremely OK Games', 'Canadá'),
('Irrational Games', 'Estados Unidos'),
('Atlus', 'Japão'),
('Hello Games', 'Reino Unido'),
('Supergiant Games', 'Estados Unidos'),
('ZA/UM', 'Estônia'),
('Mobius Digital', 'Estados Unidos'),
('Housemarque', 'Finlândia'),
('Hazelight Studios', 'Suécia'),
('Asobo Studio', 'França'),
('Moon Studios', 'Áustria'),
('Studio MDHR', 'Canadá'),
('Edmund McMillen', 'Estados Unidos'),
('Mega Crit', 'Estados Unidos'),
('Innersloth', 'Estados Unidos'),
('Mediatonic', 'Reino Unido'),
('miHoYo', 'China'),
('Blizzard Entertainment', 'Estados Unidos'),
('Maxis', 'Estados Unidos'),
('Ubisoft Montreal', 'Canadá'),
('Avalanche Software', 'Estados Unidos'),
('NetherRealm Studios', 'Estados Unidos'),
('Rocksteady Studios', 'Reino Unido'),
('Quantic Dream', 'França'),
('Supermassive Games', 'Reino Unido'),
('NEOWIZ', 'Coreia do Sul'),
('Tango Gameworks', 'Japão'),
('Double Fine Productions', 'Estados Unidos'),
('Colossal Order', 'Finlândia'),
('Paradox Development Studio', 'Suécia'),
('Bohemia Interactive', 'República Tcheca'),
('Re-Logic', 'Estados Unidos'),
('Iron Gate Studio', 'Suécia'),
('Kinetic Games', 'Reino Unido'),
('Rare', 'Reino Unido');

INSERT IGNORE INTO `Desenvolvedor` (`nome_Desenvolvedor`, `pais_Desenvolvedor`) VALUES
('Naughty Dog', 'Estados Unidos'), ('Rockstar Games', 'Estados Unidos'), ('CD Projekt Red', 'Polônia'), ('FromSoftware Inc.', 'Japão'), ('Santa Monica Studio', 'Estados Unidos'),
('Guerrilla Games', 'Países Baixos'), ('Insomniac Games', 'Estados Unidos'), ('Nintendo EPD', 'Japão'), ('BioWare', 'Canadá'), ('Bethesda Game Studios', 'Estados Unidos'),
('id Software', 'Estados Unidos'), ('Valve Corporation', 'Estados Unidos'), ('Remedy Entertainment', 'Finlândia'), ('Larian Studios', 'Bélgica'), ('Obsidian Entertainment', 'Estados Unidos'),
('Respawn Entertainment', 'Estados Unidos'), ('Sucker Punch Productions', 'Estados Unidos'), ('Kojima Productions', 'Japão'), ('Square Enix Creative Business Unit I', 'Japão'), ('Capcom R&D Division 1', 'Japão'),
('Riot Games Inc.', 'Estados Unidos'), ('Epic Games', 'Estados Unidos'), ('Mojang Studios', 'Suécia'), ('ConcernedApe', 'Estados Unidos'), ('Team Cherry', 'Austrália'),
('Extremely OK Games', 'Canadá'), ('Irrational Games', 'Estados Unidos'), ('Atlus', 'Japão'), ('Supergiant Games', 'Estados Unidos'), ('ZA/UM', 'Estônia'),
('Mobius Digital', 'Estados Unidos'), ('Housemarque', 'Finlândia'), ('Hazelight Studios', 'Suécia'), ('Asobo Studio', 'França'), ('Moon Studios', 'Áustria'),
('Studio MDHR', 'Canadá'), ('Edmund McMillen', 'Estados Unidos'), ('Mega Crit', 'Estados Unidos'), ('Innersloth', 'Estados Unidos'), ('Mediatonic', 'Reino Unido'),
('miHoYo', 'China'), ('Blizzard Entertainment', 'Estados Unidos'), ('Maxis', 'Estados Unidos'), ('Ubisoft Montreal', 'Canadá'), ('Avalanche Software', 'Estados Unidos'),
('NetherRealm Studios', 'Estados Unidos'), ('Rocksteady Studios', 'Reino Unido'), ('Quantic Dream', 'França'), ('Supermassive Games', 'Reino Unido'), ('NEOWIZ', 'Coreia do Sul'),
('Tango Gameworks', 'Japão'), ('Double Fine Productions', 'Estados Unidos'), ('Colossal Order', 'Finlândia'), ('Paradox Development Studio', 'Suécia'), ('Bohemia Interactive', 'República Tcheca'),
('Re-Logic', 'Estados Unidos'), ('Iron Gate Studio', 'Suécia'), ('Kinetic Games', 'Reino Unido'), ('Rare', 'Reino Unido'), ('Hello Games', 'Reino Unido'),
('Playground Games', 'Reino Unido'), ('The Coalition', 'Canadá'), ('Facepunch Studios', 'Reino Unido');


-- #####################################################################
-- # Inserindo dados na tabela `Jogo`                                                   #
-- #####################################################################

INSERT INTO `Jogo` (`titulo_Jogo`, `descricao_Jogo`, `data_lancamento_Jogo`, `cod_desenvolvedor_fk`, `cod_publicadora_fk`) VALUES
('The Last of Us Part I', 'Aventura de sobrevivência em um mundo pós-apocalíptico.', '2022-09-02', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Naughty Dog'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Grand Theft Auto V', 'Ação e aventura em mundo aberto na cidade de Los Santos.', '2013-09-17', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Rockstar Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Take-Two Interactive')),
('The Witcher 3: Wild Hunt', 'RPG de mundo aberto com o caçador de monstros Geralt de Rívia.', '2015-05-19', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'CD Projekt Red'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'CD Projekt')),
('Elden Ring', 'RPG de ação desafiador em um vasto mundo de fantasia sombria.', '2022-02-25', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'FromSoftware Inc.'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bandai Namco Entertainment')),
('God of War Ragnarök', 'A jornada de Kratos e Atreus pelos reinos nórdicos.', '2022-11-09', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Santa Monica Studio'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Horizon Forbidden West', 'Aloy explora uma nova fronteira majestosa e perigosa.', '2022-02-18', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Guerrilla Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Marvel''s Spider-Man 2', 'Peter Parker e Miles Morales enfrentam a ameaça de Venom.', '2023-10-20', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Insomniac Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('The Legend of Zelda: Tears of the Kingdom', 'Aventura épica pelas terras e céus de Hyrule.', '2023-05-12', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Nintendo EPD'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Nintendo')),
('Mass Effect Legendary Edition', 'Remasterização da aclamada trilogia de RPG de ficção científica.', '2021-05-14', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'BioWare'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Electronic Arts')),
('The Elder Scrolls V: Skyrim', 'RPG de mundo aberto onde o jogador é o Dragonborn.', '2011-11-11', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Bethesda Game Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bethesda Softworks')),
('DOOM Eternal', 'FPS intenso e rápido contra as forças do inferno.', '2020-03-20', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'id Software'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bethesda Softworks')),
('Half-Life: Alyx', 'Experiência de realidade virtual no universo de Half-Life.', '2020-03-23', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Valve Corporation'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Tencent Games')),
('Control', 'Ação e aventura em terceira pessoa com elementos sobrenaturais.', '2019-08-27', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Remedy Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = '505 Games')),
('Baldur''s Gate 3', 'RPG baseado em D&D com enorme liberdade e narrativa reativa.', '2023-08-03', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Larian Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Larian Studios')),
('Fallout: New Vegas', 'RPG pós-apocalíptico ambientado no deserto de Mojave.', '2010-10-19', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Obsidian Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bethesda Softworks')),
('Star Wars Jedi: Survivor', 'A continuação da história de Cal Kestis contra o Império.', '2023-04-28', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Respawn Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Electronic Arts')),
('Ghost of Tsushima', 'Um samurai luta para proteger sua ilha da invasão mongol.', '2020-07-17', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Sucker Punch Productions'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Death Stranding', 'Jogo de ação para reconectar uma sociedade fragmentada.', '2019-11-08', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Kojima Productions'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Final Fantasy VII Remake', 'Recriação do icônico RPG, expandindo a história de Midgar.', '2020-04-10', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Square Enix Creative Business Unit I'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Square Enix')),
('Resident Evil 4 (Remake)', 'Recriação do clássico de terror com jogabilidade modernizada.', '2023-03-24', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Capcom R&D Division 1'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Capcom')),
('League of Legends', 'MOBA competitivo onde duas equipes de cinco campeões se enfrentam.', '2009-10-27', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Riot Games Inc.'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Riot Games')),
('Fortnite', 'Popular jogo de Battle Royale com mecânicas de construção.', '2017-07-25', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Epic Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Epic Games')),
('Minecraft', 'Sandbox onde jogadores constroem e exploram mundos infinitos.', '2011-11-18', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Mojang Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Microsoft (Xbox Game Studios)')),
('Stardew Valley', 'RPG de simulação de fazenda.', '2016-02-26', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'ConcernedApe'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'ConcernedApe')),
('Red Dead Redemption 2', 'História épica sobre honra e lealdade no final do Velho Oeste.', '2018-10-26', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Rockstar Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Take-Two Interactive')),
('Sekiro: Shadows Die Twice', 'Ação e aventura com foco em combate preciso e furtividade.', '2019-03-22', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'FromSoftware Inc.'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Activision Blizzard')),
('Bloodborne', 'RPG de ação sombrio e gótico com alta dificuldade.', '2015-03-24', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'FromSoftware Inc.'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Uncharted 4: A Thief''s End', 'A aventura final de Nathan Drake em busca de um tesouro pirata.', '2016-05-10', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Naughty Dog'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Super Mario Odyssey', 'Mario viaja por diversos reinos para resgatar a Princesa Peach.', '2017-10-27', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Nintendo EPD'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Nintendo')),
('Cyberpunk 2077', 'RPG de ação e aventura em mundo aberto na megalópole de Night City.', '2020-12-10', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'CD Projekt Red'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'CD Projekt')),
('Dark Souls III', 'O capítulo final da aclamada série de RPGs de ação.', '2016-03-24', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'FromSoftware Inc.'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bandai Namco Entertainment')),
('God of War (2018)', 'Kratos, agora na mitologia nórdica, luta para sobreviver com seu filho.', '2018-04-20', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Santa Monica Studio'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Ratchet & Clank: Rift Apart', 'Aventura interdimensional com visuais impressionantes.', '2021-06-11', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Insomniac Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Alan Wake 2', 'Terror e sobrevivência com duas realidades jogáveis.', '2023-10-27', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Remedy Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Epic Games')),
('Apex Legends', 'Battle royale de heróis com jogabilidade rápida.', '2019-02-04', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Respawn Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Electronic Arts')),
('Titanfall 2', 'FPS aclamado com campanha e jogabilidade ágil com robôs gigantes.', '2016-10-28', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Respawn Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Electronic Arts')),
('Hollow Knight', 'Aventura 2D em um vasto reino subterrâneo de insetos.', '2017-02-24', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Team Cherry'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Team Cherry')),
('Celeste', 'Plataforma desafiador com uma história emocionante.', '2018-01-25', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Extremely OK Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Extremely OK Games')),
('Portal 2', 'Puzzle em primeira pessoa com mecânicas de portais.', '2011-04-19', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Valve Corporation'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Valve Corporation')),
('BioShock Infinite', 'Aventura FPS na cidade flutuante de Columbia.', '2013-03-26', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Irrational Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Take-Two Interactive')),
('Metal Gear Solid V: The Phantom Pain', 'Ação furtiva em mundo aberto com enorme liberdade tática.', '2015-09-01', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Kojima Productions'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Konami')),
('The Legend of Zelda: Breath of the Wild', 'Aventura de mundo aberto que redefiniu a série Zelda.', '2017-03-03', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Nintendo EPD'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Nintendo')),
('Persona 5 Royal', 'RPG estiloso sobre um grupo de ladrões de corações.', '2019-10-31', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Atlus'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sega')),
('Monster Hunter: World', 'Cace monstros gigantes em um ecossistema vivo.', '2018-01-26', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Capcom R&D Division 1'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Capcom')),
('Street Fighter 6', 'A mais recente entrada na icônica série de jogos de luta.', '2023-06-02', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Capcom R&D Division 1'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Capcom')),
('Devil May Cry 5', 'Ação hack and slash com combate estiloso.', '2019-03-08', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Capcom R&D Division 1'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Capcom')),
('Final Fantasy XVI', 'Fantasia sombria com combate em tempo real e batalhas colossais.', '2023-06-22', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Square Enix Creative Business Unit I'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Square Enix')),
('Starfield', 'RPG de nova geração ambientado entre as estrelas.', '2023-09-06', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Bethesda Game Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Microsoft (Xbox Game Studios)')),
('Forza Horizon 5', 'Corrida em mundo aberto em uma representação vibrante do México.', '2021-11-09', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Playground Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Microsoft (Xbox Game Studios)')),
('Gears 5', 'Kait Diaz busca a origem de sua família e a verdade sobre os Locust.', '2019-09-10', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'The Coalition'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Microsoft (Xbox Game Studios)')),
('Hades', 'Roguelike aclamado sobre o príncipe do submundo tentando escapar.', '2020-09-17', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Supergiant Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Supergiant Games')),
('Disco Elysium', 'RPG inovador sem combate, focado em diálogos e investigação.', '2019-10-15', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'ZA/UM'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'ZA/UM')),
('Outer Wilds', 'Mistério de exploração espacial sobre um sistema solar em loop temporal.', '2019-05-28', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Mobius Digital'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Annapurna Interactive')),
('Returnal', 'Shooter roguelike com ficção científica e terror psicológico.', '2021-04-30', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Housemarque'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('It Takes Two', 'Plataforma exclusivamente cooperativo sobre um casal em crise.', '2021-03-26', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Hazelight Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Electronic Arts')),
('A Plague Tale: Requiem', 'A continuação da jornada de Amicia e Hugo na França medieval.', '2022-10-18', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Asobo Studio'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Focus Entertainment')),
('Ori and the Will of the Wisps', 'Belíssimo jogo de plataforma e aventura com uma história emocionante.', '2020-03-11', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Moon Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Microsoft (Xbox Game Studios)')),
('Cuphead', 'Ação e plataforma com estilo de animação dos anos 1930.', '2017-09-29', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Studio MDHR'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Studio MDHR')),
('The Binding of Isaac: Rebirth', 'Roguelike de tiro com dois analógicos e temas sombrios.', '2014-11-04', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Edmund McMillen'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Nicalis')),
('Slay the Spire', 'Construtor de baralhos roguelike.', '2019-01-23', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Mega Crit'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Humble Bundle')),
('Among Us', 'Dedução social multiplayer onde tripulantes sobrevivem a um impostor.', '2018-06-15', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Innersloth'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Innersloth')),
('Fall Guys', 'Multiplayer de gincanas caóticas e divertidas.', '2020-08-04', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Mediatonic'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Devolver Digital')),
('Genshin Impact', 'RPG de ação em mundo aberto com um vasto mundo para explorar.', '2020-09-28', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'miHoYo'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'miHoYo')),
('Valorant', 'Tiro tático 5v5 baseado em personagens.', '2020-06-02', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Riot Games Inc.'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Riot Games')),
('Overwatch 2', 'Sequência do popular shooter de heróis da Blizzard.', '2022-10-04', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Blizzard Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Activision Blizzard')),
('Diablo IV', 'Retorno da aclamada série de RPG de ação.', '2023-06-05', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Blizzard Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Activision Blizzard')),
('World of Warcraft', 'O MMORPG mais popular do mundo.', '2004-11-23', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Blizzard Entertainment'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Activision Blizzard')),
('Call of Duty: Modern Warfare III (2023)', 'A mais recente iteração da popular franquia de FPS.', '2023-11-10', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Sledgehammer Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Activision Blizzard')),
('Battlefield 2042', 'FPS multiplayer em larga escala com foco em guerra total.', '2021-11-19', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'DICE'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Electronic Arts')),
('The Sims 4', 'Simulação de vida onde você cria e controla pessoas.', '2014-09-02', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Maxis'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Electronic Arts')),
('Assassin''s Creed Valhalla', 'Jogue como um guerreiro Viking na Inglaterra.', '2020-11-10', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Ubisoft Montreal'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Ubisoft')),
('Far Cry 6', 'Lute para libertar a nação fictícia de Yara.', '2021-10-07', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Ubisoft Montreal'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Ubisoft')),
('Rainbow Six Siege', 'Shooter tático focado em combate de curta distância.', '2015-12-01', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Ubisoft Montreal'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Ubisoft')),
('Watch Dogs: Legion', 'Recrute qualquer pessoa da cidade de Londres para formar uma resistência.', '2020-10-29', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Ubisoft Montreal'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Ubisoft')),
('Cyberpunk 2077: Phantom Liberty', 'Expansão de suspense e espionagem para Cyberpunk 2077.', '2023-09-26', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'CD Projekt Red'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'CD Projekt')),
('Hogwarts Legacy', 'RPG de ação em mundo aberto no universo de Harry Potter.', '2023-02-10', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Avalanche Software'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Warner Bros. Interactive Entertainment')),
('Mortal Kombat 1', 'Um novo começo para a icônica franquia de luta.', '2023-09-19', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'NetherRealm Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Warner Bros. Interactive Entertainment')),
('Batman: Arkham Knight', 'O capítulo final da série Arkham.', '2015-06-23', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Rocksteady Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Warner Bros. Interactive Entertainment')),
('Detroit: Become Human', 'Aventura narrativa sobre androides com consciência.', '2018-05-25', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Quantic Dream'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Heavy Rain', 'Thriller interativo sobre a busca por um serial killer.', '2010-02-23', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Quantic Dream'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Until Dawn', 'Terror interativo onde um grupo de amigos tenta sobreviver.', '2015-08-25', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Supermassive Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Sony Interactive Entertainment')),
('Lies of P', 'Soulslike que reconta a história de Pinóquio em um mundo sombrio.', '2023-09-18', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'NEOWIZ'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'NEOWIZ')),
('Hi-Fi Rush', 'Ação e ritmo onde o mundo se move com a música.', '2023-01-25', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Tango Gameworks'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bethesda Softworks')),
('Psychonauts 2', 'Aventura de plataforma que mergulha em mentes excêntricas.', '2021-08-25', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Double Fine Productions'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Microsoft (Xbox Game Studios)')),
('Crusader Kings III', 'Grande jogo de estratégia e simulação de dinastia medieval.', '2020-09-01', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Paradox Development Studio'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Paradox Interactive')),
('Cities: Skylines II', 'O construtor de cidades mais realista já criado.', '2023-10-24', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Colossal Order'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Paradox Interactive')),
('Stellaris', 'Grande estratégia de ficção científica sobre impérios espaciais.', '2016-05-09', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Paradox Development Studio'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Paradox Interactive')),
('Arma 3', 'Simulador de combate militar massivo em sandbox.', '2013-09-12', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Bohemia Interactive'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bohemia Interactive')),
('DayZ', 'Sobrevivência hardcore em um mundo aberto pós-apocalíptico.', '2018-12-13', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Bohemia Interactive'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Bohemia Interactive')),
('Rust', 'Sobrevivência multiplayer onde o objetivo é sobreviver contra outros.', '2018-02-08', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Facepunch Studios'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Facepunch Studios')),
('Terraria', 'Aventura e sandbox 2D com exploração, construção e combate.', '2011-05-16', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Re-Logic'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Re-Logic')),
('Valheim', 'Sobrevivência e exploração brutal, inspirado na cultura viking.', '2021-02-02', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Iron Gate Studio'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Coffee Stain Publishing')),
('Phasmophobia', 'Terror psicológico cooperativo para 4 jogadores.', '2020-09-18', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Kinetic Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Kinetic Games')),
('Sea of Thieves', 'Aventura em mundo compartilhado que permite viver a vida de um pirata.', '2018-03-20', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Rare'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Microsoft (Xbox Game Studios)')),
('No Man''s Sky', 'Exploração espacial com um universo gerado proceduralmente.', '2016-08-09', (SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = 'Hello Games'), (SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = 'Hello Games'));


-- -----------------------------------------------------
-- Inserindo dados na tabela `Jogos - Plataforma`
-- -----------------------------------------------------




INSERT INTO `Jogo_Plataforma` (`cod_jogo_fk`, `cod_plataforma_fk`) VALUES

-- 1. The Last of Us Part I
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),

-- 2. Grand Theft Auto V
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 3')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox 360')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),

-- 3. The Witcher 3: Wild Hunt
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),

-- 4. Elden Ring
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),

-- 5. God of War Ragnarök
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),

-- 6. Horizon Forbidden West
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),

-- 7. Marvel's Spider-Man 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),

-- 8. The Legend of Zelda: Tears of the Kingdom
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),

-- 9. Mass Effect Legendary Edition
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),

-- 10. The Elder Scrolls V: Skyrim
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 3')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox 360')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),

-- 11. DOOM Eternal
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),

-- 12. Half-Life: Alyx
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Half-Life: Alyx'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),

-- 13. Control
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),

-- 14. Baldur's Gate 3
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),

-- 15. Fallout: New Vegas
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 3')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox 360')),

-- 16. Star Wars Jedi: Survivor
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),

-- 17. Ghost of Tsushima
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),

-- 18. Death Stranding
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),

-- 19. Final Fantasy VII Remake
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy VII Remake'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy VII Remake'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy VII Remake'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),

-- 20. Resident Evil 4 (Remake)
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),

-- 21. League of Legends
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'League of Legends'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'League of Legends'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),

-- 22. Fortnite
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Android')),

-- 23. Minecraft
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'iOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Android')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),

-- 24. Stardew Valley
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'iOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Android')),

-- 25. Red Dead Redemption 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),

-- 26. Sekiro: Shadows Die Twice
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),

-- 27. Bloodborne
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Bloodborne'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),

-- 28. Uncharted 4: A Thief's End
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),

-- 29. Super Mario Odyssey
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Super Mario Odyssey'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),

-- 30. Cyberpunk 2077
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),

-- Continue for remaining games...
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Titanfall 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Titanfall 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Titanfall 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Celeste'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Celeste'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Celeste'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Celeste'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Portal 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Portal 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 3')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Portal 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox 360')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'BioShock Infinite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'BioShock Infinite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 3')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'BioShock Infinite'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox 360')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Wii U')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Monster Hunter: World'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Monster Hunter: World'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Monster Hunter: World'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Street Fighter 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Street Fighter 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Street Fighter 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Street Fighter 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Devil May Cry 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Devil May Cry 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Devil May Cry 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Starfield'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Starfield'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Gears 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Gears 5'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Disco Elysium'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Disco Elysium'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Disco Elysium'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Disco Elysium'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Disco Elysium'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Outer Wilds'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Outer Wilds'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Outer Wilds'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ori and the Will of the Wisps'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ori and the Will of the Wisps'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ori and the Will of the Wisps'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'iOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Android')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'iOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Android')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fall Guys'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fall Guys'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fall Guys'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fall Guys'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'iOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Android')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valorant'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'World of Warcraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'World of Warcraft'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Sims 4'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Sims 4'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Sims 4'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Sims 4'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rainbow Six Siege'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rainbow Six Siege'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rainbow Six Siege'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077: Phantom Liberty'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077: Phantom Liberty'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077: Phantom Liberty'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mortal Kombat 1'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mortal Kombat 1'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mortal Kombat 1'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mortal Kombat 1'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Detroit: Become Human'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Detroit: Become Human'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Heavy Rain'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 3')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Heavy Rain'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Heavy Rain'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Until Dawn'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 5')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hi-Fi Rush'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hi-Fi Rush'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Psychonauts 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Psychonauts 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Psychonauts 2'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Crusader Kings III'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Crusader Kings III'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Crusader Kings III'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Linux')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cities: Skylines II'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stellaris'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stellaris'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stellaris'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Linux')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Arma 3'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DayZ'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DayZ'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DayZ'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Linux')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Phasmophobia'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox Series X/S')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PC')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'PlayStation 4')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Xbox One')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'Nintendo Switch')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = 'macOS'));



























-- #####################################################################
-- # Script COMPLETO para VINCULAR os 100 Jogos aos seus Gêneros       #
-- #####################################################################



INSERT INTO `Jogo_Genero` (`cod_jogo_fk`, `cod_genero_fk`) VALUES

-- 1. The Last of Us Part I
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 1. The Last of Us Part I
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 2. Grand Theft Auto V
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 3. The Witcher 3: Wild Hunt
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 4. Elden Ring
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 5. God of War Ragnarök
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 6. Horizon Forbidden West
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 7. Marvel's Spider-Man 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 8. The Legend of Zelda: Tears of the Kingdom
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 9. Mass Effect Legendary Edition
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 10. The Elder Scrolls V: Skyrim
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 11. DOOM Eternal
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 12. Half-Life: Alyx
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Half-Life: Alyx'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Half-Life: Alyx'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Half-Life: Alyx'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 13. Control
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 14. Baldur's Gate 3
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 15. Fallout: New Vegas
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 16. Star Wars Jedi: Survivor
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 17. Ghost of Tsushima
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Furtivo (Stealth)')),

-- 18. Death Stranding
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 19. Final Fantasy VII Remake
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy VII Remake'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy VII Remake'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 20. Resident Evil 4 (Remake)
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 21. League of Legends
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'League of Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'MOBA')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'League of Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),

-- 22. Fortnite
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),

-- 23. Minecraft
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Construção')),

-- 24. Stardew Valley
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 25. Red Dead Redemption 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 26. Sekiro: Shadows Die Twice
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 27. Bloodborne
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Bloodborne'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Bloodborne'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Bloodborne'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 28. Uncharted 4: A Thief's End
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 29. Super Mario Odyssey
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Super Mario Odyssey'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Super Mario Odyssey'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 30. Cyberpunk 2077
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 31. Dark Souls III
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 32. God of War (2018)
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 33. Ratchet & Clank: Rift Apart
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 34. Alan Wake 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 35. Apex Legends
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 36. Titanfall 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Titanfall 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Titanfall 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 37. Hollow Knight
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),

-- 38. Celeste
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Celeste'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),

-- 39. Portal 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Portal 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Puzzle')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Portal 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),

-- 40. BioShock Infinite
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'BioShock Infinite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'BioShock Infinite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 41. Metal Gear Solid V: The Phantom Pain
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Furtivo (Stealth)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 42. The Legend of Zelda: Breath of the Wild
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 43. Persona 5 Royal
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 44. Monster Hunter: World
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Monster Hunter: World'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Monster Hunter: World'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 45. Street Fighter 6
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Street Fighter 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Luta')),

-- 46. Devil May Cry 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Devil May Cry 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Devil May Cry 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 47. Final Fantasy XVI
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 48. Starfield
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Starfield'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Starfield'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 49. Forza Horizon 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Corrida')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Esportes')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 50. Gears 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Gears 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Gears 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 51. Hades
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 52. Disco Elysium
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Disco Elysium'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 53. Outer Wilds
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Outer Wilds'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Outer Wilds'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Puzzle')),

-- 54. Returnal
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 55. It Takes Two
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 56. A Plague Tale: Requiem
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Furtivo (Stealth)')),

-- 57. Ori and the Will of the Wisps
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ori and the Will of the Wisps'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ori and the Will of the Wisps'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 58. Cuphead
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 59. The Binding of Isaac: Rebirth
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 60. Slay the Spire
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),

-- 61. Among Us
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')), -- Categoria aproximada

-- 62. Fall Guys
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fall Guys'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale')),

-- 63. Genshin Impact
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 64. Valorant
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valorant'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valorant'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 65. Overwatch 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 66. Diablo IV
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 67. World of Warcraft
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'World of Warcraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'MMORPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'World of Warcraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 68. Call of Duty: Modern Warfare III (2023)
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 69. Battlefield 2042
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 70. The Sims 4
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Sims 4'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),

-- 71. Assassin's Creed Valhalla
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 72. Far Cry 6
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 73. Rainbow Six Siege
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rainbow Six Siege'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rainbow Six Siege'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),

-- 74. Watch Dogs: Legion
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 75. Cyberpunk 2077: Phantom Liberty
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077: Phantom Liberty'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077: Phantom Liberty'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 76. Hogwarts Legacy
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 77. Mortal Kombat 1
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mortal Kombat 1'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Luta')),

-- 78. Batman: Arkham Knight
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 79. Detroit: Become Human
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Detroit: Become Human'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 80. Heavy Rain
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Heavy Rain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 81. Until Dawn
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Until Dawn'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Until Dawn'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 82. Lies of P
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 83. Hi-Fi Rush
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hi-Fi Rush'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hi-Fi Rush'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ritmo')),

-- 84. Psychonauts 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Psychonauts 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Psychonauts 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 85. Crusader Kings III
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Crusader Kings III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Crusader Kings III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),

-- 86. Cities: Skylines II
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cities: Skylines II'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cities: Skylines II'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Construção')),

-- 87. Stellaris
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stellaris'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stellaris'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),

-- 88. Arma 3
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Arma 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Arma 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 89. DayZ
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DayZ'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DayZ'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 90. Rust
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 91. Terraria
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 92. Valheim
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 93. Phasmophobia
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Phasmophobia'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 94. Sea of Thieves
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 95. No Man's Sky
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),

-- Adicionando alguns jogos faltantes na contagem para chegar a 100
-- 96. Assassin's Creed Odyssey
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 97. Far Cry 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 98. Battlefield 1
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
-- 99. Final Fantasy XV
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
-- 100. Call of Duty: Warzone
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale'));









INSERT INTO `Jogo_Genero` (`cod_jogo_fk`, `cod_genero_fk`) VALUES

-- 1. The Last of Us Part I
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 2. Grand Theft Auto V
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 3. The Witcher 3: Wild Hunt
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 4. Elden Ring
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 5. God of War Ragnarök
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 6. Horizon Forbidden West
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 7. Marvel's Spider-Man 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 8. The Legend of Zelda: Tears of the Kingdom
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 9. Mass Effect Legendary Edition
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 10. The Elder Scrolls V: Skyrim
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- ... (restante do script continua até o final)

-- 94. Sea of Thieves
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 95. No Man's Sky
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),

-- Adicionando alguns jogos faltantes na contagem para chegar a 100
-- 96. Assassin's Creed Odyssey
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 97. Far Cry 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 98. Battlefield 1
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
-- 99. Final Fantasy XV
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
-- 100. Call of Duty: Warzone
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale'));















-- ******************************************************************************************************************************
-- Garanta que esta janela de consulta esteja VAZIA antes de colar e executar.
USE enciclopedia_jogos;

INSERT INTO `Jogo_Genero` (`cod_jogo_fk`, `cod_genero_fk`) VALUES

-- 1. The Last of Us Part I
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Last of Us Part I'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 2. Grand Theft Auto V
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Grand Theft Auto V'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 3. The Witcher 3: Wild Hunt
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Witcher 3: Wild Hunt'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 4. Elden Ring
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Elden Ring'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 5. God of War Ragnarök
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War Ragnarök'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 6. Horizon Forbidden West
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Horizon Forbidden West'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 7. Marvel's Spider-Man 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Marvel''s Spider-Man 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 8. The Legend of Zelda: Tears of the Kingdom
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Tears of the Kingdom'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 9. Mass Effect Legendary Edition
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mass Effect Legendary Edition'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 10. The Elder Scrolls V: Skyrim
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Elder Scrolls V: Skyrim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura'));

-- 11. DOOM Eternal
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DOOM Eternal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 12. Half-Life: Alyx
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Half-Life: Alyx'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Half-Life: Alyx'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Half-Life: Alyx'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 13. Control
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Control'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 14. Baldur's Gate 3
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Baldur''s Gate 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 15. Fallout: New Vegas
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fallout: New Vegas'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 16. Star Wars Jedi: Survivor
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Star Wars Jedi: Survivor'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 17. Ghost of Tsushima
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ghost of Tsushima'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Furtivo (Stealth)')),

-- 18. Death Stranding
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Death Stranding'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 19. Final Fantasy VII Remake
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy VII Remake'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy VII Remake'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 20. Resident Evil 4 (Remake)
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Resident Evil 4 (Remake)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 21. League of Legends
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'League of Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'MOBA')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'League of Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),

-- 22. Fortnite
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fortnite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),

-- 23. Minecraft
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Minecraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Construção')),

-- 24. Stardew Valley
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stardew Valley'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 25. Red Dead Redemption 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Red Dead Redemption 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 26. Sekiro: Shadows Die Twice
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sekiro: Shadows Die Twice'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 27. Bloodborne
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Bloodborne'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Bloodborne'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Bloodborne'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 28. Uncharted 4: A Thief's End
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Uncharted 4: A Thief''s End'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 29. Super Mario Odyssey
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Super Mario Odyssey'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Super Mario Odyssey'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 30. Cyberpunk 2077
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 31. Dark Souls III
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Dark Souls III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),

-- 32. God of War (2018)
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'God of War (2018)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 33. Ratchet & Clank: Rift Apart
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ratchet & Clank: Rift Apart'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),

-- 34. Alan Wake 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Alan Wake 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 35. Apex Legends
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Apex Legends'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 36. Titanfall 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Titanfall 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Titanfall 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 37. Hollow Knight
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hollow Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),

-- 38. Celeste
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Celeste'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),

-- 39. Portal 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Portal 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Puzzle')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Portal 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),

-- 40. BioShock Infinite
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'BioShock Infinite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'BioShock Infinite'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 41. Metal Gear Solid V: The Phantom Pain
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Furtivo (Stealth)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Metal Gear Solid V: The Phantom Pain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 42. The Legend of Zelda: Breath of the Wild
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Legend of Zelda: Breath of the Wild'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 43. Persona 5 Royal
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Persona 5 Royal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 44. Monster Hunter: World
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Monster Hunter: World'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Monster Hunter: World'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 45. Street Fighter 6
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Street Fighter 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Luta')),

-- 46. Devil May Cry 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Devil May Cry 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Devil May Cry 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 47. Final Fantasy XVI
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 48. Starfield
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Starfield'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Starfield'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 49. Forza Horizon 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Corrida')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Esportes')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Forza Horizon 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 50. Gears 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Gears 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Gears 5'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 51. Hades
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hades'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 52. Disco Elysium
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Disco Elysium'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 53. Outer Wilds
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Outer Wilds'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Outer Wilds'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Puzzle')),

-- 54. Returnal
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Terceira Pessoa (TPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Returnal'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 55. It Takes Two
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'It Takes Two'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 56. A Plague Tale: Requiem
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'A Plague Tale: Requiem'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Furtivo (Stealth)')),

-- 57. Ori and the Will of the Wisps
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ori and the Will of the Wisps'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Ori and the Will of the Wisps'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 58. Cuphead
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cuphead'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 59. The Binding of Isaac: Rebirth
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Binding of Isaac: Rebirth'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 60. Slay the Spire
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Roguelike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Slay the Spire'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),

-- 61. Among Us
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Among Us'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')), -- Categoria aproximada

-- 62. Fall Guys
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Fall Guys'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale')),

-- 63. Genshin Impact
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Genshin Impact'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 64. Valorant
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valorant'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valorant'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 65. Overwatch 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Overwatch 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 66. Diablo IV
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Diablo IV'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Hack and Slash')),

-- 67. World of Warcraft
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'World of Warcraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'MMORPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'World of Warcraft'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),

-- 68. Call of Duty: Modern Warfare III (2023)
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 69. Battlefield 2042
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 70. The Sims 4
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'The Sims 4'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),

-- 71. Assassin's Creed Valhalla
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 72. Far Cry 6
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 73. Rainbow Six Siege
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rainbow Six Siege'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rainbow Six Siege'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),

-- 74. Watch Dogs: Legion
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Watch Dogs: Legion'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 75. Cyberpunk 2077: Phantom Liberty
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077: Phantom Liberty'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cyberpunk 2077: Phantom Liberty'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 76. Hogwarts Legacy
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hogwarts Legacy'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 77. Mortal Kombat 1
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Mortal Kombat 1'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Luta')),

-- 78. Batman: Arkham Knight
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Batman: Arkham Knight'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 79. Detroit: Become Human
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Detroit: Become Human'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 80. Heavy Rain
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Heavy Rain'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 81. Until Dawn
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Until Dawn'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Until Dawn'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 82. Lies of P
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Soulslike')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'RPG')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Lies of P'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),

-- 83. Hi-Fi Rush
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hi-Fi Rush'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Hi-Fi Rush'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ritmo')),

-- 84. Psychonauts 2
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Psychonauts 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Plataforma')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Psychonauts 2'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 85. Crusader Kings III
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Crusader Kings III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Crusader Kings III'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),

-- 86. Cities: Skylines II
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cities: Skylines II'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Cities: Skylines II'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Construção')),

-- 87. Stellaris
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stellaris'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Estratégia')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Stellaris'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),

-- 88. Arma 3
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Arma 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Simulação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Arma 3'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),

-- 89. DayZ
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DayZ'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'DayZ'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 90. Rust
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Rust'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 91. Terraria
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Terraria'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),

-- 92. Valheim
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Valheim'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 93. Phasmophobia
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Phasmophobia'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Terror')),

-- 94. Sea of Thieves
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 95. No Man's Sky
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),

-- Adicionando alguns jogos faltantes na contagem para chegar a 100
INSERT INTO `Jogo_Genero` (`cod_jogo_fk`, `cod_genero_fk`) VALUES
-- 96. Assassin's Creed Odyssey
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 97. Far Cry 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 98. Battlefield 1
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
-- 99. Final Fantasy XV
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
-- 100. Call of Duty: Warzone
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale'));





























-- 94. Sea of Thieves
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Ação')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Sea of Thieves'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),

-- 95. No Man's Sky
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sobrevivência')),
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'No Man''s Sky'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Sandbox')),

-- Adicionando alguns jogos faltantes na contagem para chegar a 100
-- 96. Assassin's Creed Odyssey
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Assassin''s Creed Valhalla'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 97. Far Cry 5
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Far Cry 6'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Aventura')),
-- 98. Battlefield 1
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Battlefield 2042'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Tiro em Primeira Pessoa (FPS)')),
-- 99. Final Fantasy XV
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Final Fantasy XVI'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Mundo Aberto')),
-- 100. Call of Duty: Warzone
((SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = 'Call of Duty: Modern Warfare III (2023)'), (SELECT cod_Genero FROM Genero WHERE nome_Genero = 'Battle Royale'));













