-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 29/09/2025 às 11:30
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `eg`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `avaliacao`
--

CREATE TABLE `avaliacao` (
  `cod_Avaliacao` int(11) NOT NULL,
  `nota_Avaliacao` decimal(3,1) NOT NULL,
  `texto_Avaliacao` text DEFAULT NULL,
  `data_criacao_Avaliacao` datetime NOT NULL DEFAULT current_timestamp(),
  `cod_usuario_fk` int(11) NOT NULL,
  `cod_jogo_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `avaliacao`
--

INSERT INTO `avaliacao` (`cod_Avaliacao`, `nota_Avaliacao`, `texto_Avaliacao`, `data_criacao_Avaliacao`, `cod_usuario_fk`, `cod_jogo_fk`) VALUES
(2, 4.0, NULL, '2025-09-28 17:51:58', 1, 56),
(4, 4.0, NULL, '2025-09-28 17:52:46', 1, 61),
(5, 4.0, NULL, '2025-09-28 17:53:53', 1, 90),
(15, 5.0, NULL, '2025-09-28 18:32:58', 1, 95),
(17, 3.0, NULL, '2025-09-28 18:38:32', 1, 93),
(19, 5.0, NULL, '2025-09-28 18:39:38', 1, 94),
(21, 3.0, NULL, '2025-09-28 18:49:22', 2, 95),
(22, 4.0, NULL, '2025-09-28 18:56:37', 2, 35);

-- --------------------------------------------------------

--
-- Estrutura para tabela `captura_tela`
--

CREATE TABLE `captura_tela` (
  `cod_Captura_Tela` int(11) NOT NULL,
  `url_imagem_Captura_Tela` varchar(512) NOT NULL,
  `legenda_Captura_Tela` varchar(255) DEFAULT NULL,
  `cod_jogo_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `comentario`
--

CREATE TABLE `comentario` (
  `cod_Comentario` int(11) NOT NULL,
  `cod_postagem_fk` int(11) NOT NULL,
  `cod_usuario_fk` int(11) NOT NULL,
  `texto_Comentario` text NOT NULL,
  `data_criacao_Comentario` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `desenvolvedor`
--

CREATE TABLE `desenvolvedor` (
  `cod_Desenvolvedor` int(11) NOT NULL,
  `nome_Desenvolvedor` varchar(255) NOT NULL,
  `pais_Desenvolvedor` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `desenvolvedor`
--

INSERT INTO `desenvolvedor` (`cod_Desenvolvedor`, `nome_Desenvolvedor`, `pais_Desenvolvedor`) VALUES
(1, 'Naughty Dog', 'Estados Unidos'),
(2, 'Rockstar Games', 'Estados Unidos'),
(3, 'CD Projekt Red', 'Polônia'),
(4, 'FromSoftware Inc.', 'Japão'),
(5, 'Santa Monica Studio', 'Estados Unidos'),
(6, 'Guerrilla Games', 'Países Baixos'),
(7, 'Insomniac Games', 'Estados Unidos'),
(8, 'Nintendo EPD', 'Japão'),
(9, 'BioWare', 'Canadá'),
(10, 'Bethesda Game Studios', 'Estados Unidos'),
(11, 'id Software', 'Estados Unidos'),
(12, 'Valve Corporation', 'Estados Unidos'),
(13, 'Remedy Entertainment', 'Finlândia'),
(14, 'Larian Studios', 'Bélgica'),
(15, 'Obsidian Entertainment', 'Estados Unidos'),
(16, 'Respawn Entertainment', 'Estados Unidos'),
(17, 'Sucker Punch Productions', 'Estados Unidos'),
(18, 'Kojima Productions', 'Japão'),
(19, 'Square Enix Creative Business Unit I', 'Japão'),
(20, 'Capcom R&D Division 1', 'Japão'),
(21, 'Riot Games Inc.', 'Estados Unidos'),
(22, 'Epic Games', 'Estados Unidos'),
(23, 'Mojang Studios', 'Suécia'),
(24, 'ConcernedApe', 'Estados Unidos'),
(25, 'Team Cherry', 'Austrália'),
(26, 'Extremely OK Games', 'Canadá'),
(27, 'Irrational Games', 'Estados Unidos'),
(28, 'Atlus', 'Japão'),
(29, 'Hello Games', 'Reino Unido'),
(30, 'Supergiant Games', 'Estados Unidos'),
(31, 'ZA/UM', 'Estônia'),
(32, 'Mobius Digital', 'Estados Unidos'),
(33, 'Housemarque', 'Finlândia'),
(34, 'Hazelight Studios', 'Suécia'),
(35, 'Asobo Studio', 'França'),
(36, 'Moon Studios', 'Áustria'),
(37, 'Studio MDHR', 'Canadá'),
(38, 'Edmund McMillen', 'Estados Unidos'),
(39, 'Mega Crit', 'Estados Unidos'),
(40, 'Innersloth', 'Estados Unidos'),
(41, 'Mediatonic', 'Reino Unido'),
(42, 'miHoYo', 'China'),
(43, 'Blizzard Entertainment', 'Estados Unidos'),
(44, 'Maxis', 'Estados Unidos'),
(45, 'Ubisoft Montreal', 'Canadá'),
(46, 'Avalanche Software', 'Estados Unidos'),
(47, 'NetherRealm Studios', 'Estados Unidos'),
(48, 'Rocksteady Studios', 'Reino Unido'),
(49, 'Quantic Dream', 'França'),
(50, 'Supermassive Games', 'Reino Unido'),
(51, 'NEOWIZ', 'Coreia do Sul'),
(52, 'Tango Gameworks', 'Japão'),
(53, 'Double Fine Productions', 'Estados Unidos'),
(54, 'Colossal Order', 'Finlândia'),
(55, 'Paradox Development Studio', 'Suécia'),
(56, 'Bohemia Interactive', 'República Tcheca'),
(57, 'Re-Logic', 'Estados Unidos'),
(58, 'Iron Gate Studio', 'Suécia'),
(59, 'Kinetic Games', 'Reino Unido'),
(60, 'Rare', 'Reino Unido'),
(61, 'Playground Games', 'Reino Unido'),
(62, 'The Coalition', 'Canadá'),
(63, 'Facepunch Studios', 'Reino Unido');

-- --------------------------------------------------------

--
-- Estrutura para tabela `genero`
--

CREATE TABLE `genero` (
  `cod_Genero` int(11) NOT NULL,
  `nome_Genero` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `genero`
--

INSERT INTO `genero` (`cod_Genero`, `nome_Genero`) VALUES
(1, 'Ação'),
(2, 'Aventura'),
(17, 'Battle Royale'),
(23, 'Construção'),
(7, 'Corrida'),
(6, 'Esportes'),
(4, 'Estratégia'),
(16, 'Furtivo (Stealth)'),
(22, 'Hack and Slash'),
(8, 'Luta'),
(19, 'MMORPG'),
(18, 'MOBA'),
(15, 'Mundo Aberto'),
(9, 'Plataforma'),
(10, 'Puzzle'),
(25, 'Ritmo'),
(20, 'Roguelike'),
(3, 'RPG'),
(24, 'Sandbox'),
(5, 'Simulação'),
(13, 'Sobrevivência'),
(21, 'Soulslike'),
(14, 'Terror'),
(11, 'Tiro em Primeira Pessoa (FPS)'),
(12, 'Tiro em Terceira Pessoa (TPS)');

-- --------------------------------------------------------

--
-- Estrutura para tabela `jogo`
--

CREATE TABLE `jogo` (
  `cod_Jogo` int(11) NOT NULL,
  `titulo_Jogo` varchar(255) NOT NULL,
  `descricao_Jogo` text DEFAULT NULL,
  `data_lancamento_Jogo` date DEFAULT NULL,
  `url_imagem_capa_Jogo` varchar(512) DEFAULT NULL,
  `cod_desenvolvedor_fk` int(11) DEFAULT NULL,
  `cod_publicadora_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `jogo`
--

INSERT INTO `jogo` (`cod_Jogo`, `titulo_Jogo`, `descricao_Jogo`, `data_lancamento_Jogo`, `url_imagem_capa_Jogo`, `cod_desenvolvedor_fk`, `cod_publicadora_fk`) VALUES
(1, 'The Last of Us Part I', 'Em um mundo pós-apocalíptico devastado por uma infecção fúngica, o contrabandista Joel é contratado para escoltar a jovem Ellie através dos Estados Unidos. O que começa como um trabalho se transforma em uma jornada brutal e emocionante sobre sobrevivência, lealdade e o significado de família.', '2022-09-02', 'https://www.mobygames.com/images/covers/l/557757-the-last-of-us-part-i-front-cover.jpg', 1, 4),
(2, 'Grand Theft Auto V', 'Explore a vasta e ensolarada metrópole de Los Santos e Blaine County enquanto alterna entre as vidas de três criminosos muito diferentes: Franklin, Michael e Trevor. Planeje e execute uma série de assaltos ousados em um dos jogos de mundo aberto mais aclamados de todos os tempos.', '2013-09-17', 'https://www.mobygames.com/images/covers/l/569029-grand-theft-auto-v-front-cover.jpg', 2, 6),
(3, 'The Witcher 3: Wild Hunt', 'Assuma o papel de Geralt de Rívia, um caçador de monstros profissional, em um vasto mundo aberto em busca de sua filha adotiva, Ciri, que é perseguida pela Caçada Selvagem. Conhecido por sua narrativa madura, personagens complexos e decisões com consequências significativas.', '2015-05-19', 'https://www.mobygames.com/images/covers/l/978253-the-witcher-3-wild-hunt-front-cover.jpg', 3, 18),
(4, 'Elden Ring', 'Explore as Terras Intermédias, um vasto mundo de fantasia sombria criado por Hidetaka Miyazaki e George R. R. Martin. Como um Maculado, sua missão é encontrar todos os Grandes Runas, restaurar o Anel Prístino e se tornar o Lorde Prístino, enfrentando criaturas colossais e chefes desafiadores.', '2022-02-25', 'https://www.mobygames.com/images/covers/l/771713-elden-ring-front-cover.jpg', 4, 8),
(5, 'God of War Ragnarök', 'Kratos e seu filho Atreus devem viajar pelos Nove Reinos para encontrar respostas enquanto as forças de Asgard se preparam para a batalha profetizada que acabará com o mundo. Nesta jornada épica, eles enfrentarão deuses nórdicos e monstros temíveis.', '2022-11-09', 'https://www.mobygames.com/images/covers/l/754010-god-of-war-ragnarök-front-cover.jpg', 5, 4),
(6, 'Horizon Forbidden West', 'Junte-se a Aloy enquanto ela desbrava o Oeste Proibido, uma fronteira majestosa, mas perigosa, que esconde novas e misteriosas ameaças. Explore terras distantes, lute contra máquinas ainda maiores e mais imponentes e encontre novas tribos surpreendentes.', '2022-02-18', 'https://www.mobygames.com/images/covers/l/69853-horizon-forbidden-west-front-cover.jpg', 6, 4),
(7, 'Marvel\'s Spider-Man 2', 'Peter Parker e Miles Morales retornam para uma nova e emocionante aventura. Enquanto tentam equilibrar suas vidas pessoais e de super-heróis, eles devem enfrentar a ameaça definitiva de Venom, que coloca em risco a cidade de Nova York e todos que amam.', '2023-10-20', 'https://images.igdb.com/igdb/image/upload/t_cover_big/co6myz.png', 7, 4),
(8, 'The Legend of Zelda: Tears of the Kingdom', 'Uma aventura épica que se desenrola nas terras e nos vastos céus de Hyrule. Link deve usar suas novas habilidades para lutar contra as forças malévolas que ameaçam o reino, em uma sequência que expande massivamente o mundo de Breath of the Wild.', '2023-05-12', 'https://www.mobygames.com/images/covers/l/177234-the-legend-of-zelda-tears-of-the-kingdom-front-cover.jpg', 8, 3),
(9, 'Mass Effect Legendary Edition', 'Reviva a lenda do Comandante Shepard e lidere um esquadrão de elite em uma galáxia em guerra para deter um inimigo antigo e implacável. Esta edição remasterizada inclui todo o conteúdo single-player e mais de 40 DLCs da trilogia Mass Effect.', '2021-05-14', 'https://www.mobygames.com/images/covers/l/19186-mass-effect-legendary-edition-front-cover.jpg', 9, 1),
(10, 'The Elder Scrolls V: Skyrim', 'Como o último Dragonborn, o jogador é a única pessoa capaz de deter Alduin, o Devorador de Mundos, de destruir o mundo. Explore um vasto mundo aberto, junte-se a facções, aprenda magias e gritos poderosos e forje seu próprio destino na terra de Skyrim.', '2011-11-11', 'https://www.mobygames.com/images/covers/l/223402-the-elder-scrolls-v-skyrim-front-cover.jpg', 10, 14),
(11, 'DOOM Eternal', 'Assuma o papel do Doom Slayer e retorne à Terra para encontrar seu lar consumido por uma invasão demoníaca. Com um arsenal poderoso e habilidades ágeis, aniquile demônios em várias dimensões em uma experiência de tiro em primeira pessoa visceral e implacável.', '2020-03-20', 'https://m.media-amazon.com/images/I/91Ma+D-vdCL._UF1000,1000_QL80_.jpg', 11, 14),
(12, 'Half-Life: Alyx', 'Situado antes dos eventos de Half-Life 2, este jogo de realidade virtual coloca você no papel de Alyx Vance. Lute contra a ocupação brutal da Terra pela raça alienígena Combine em uma experiência imersiva e aclamada pela crítica.', '2020-03-23', 'https://www.mobygames.com/images/covers/l/293227-half-life-alyx-front-cover.jpg', 12, 12),
(13, 'Control', 'Após uma agência secreta em Nova York ser invadida por uma ameaça de outro mundo, você se torna a nova Diretora, Jesse Faden, lutando para recuperar o controle. Domine habilidades sobrenaturais e explore um mundo imprevisível neste jogo de ação e aventura.', '2019-08-27', 'https://upload.wikimedia.org/wikipedia/pt/7/73/Control_capa.png', 13, 22),
(14, 'Baldur\'s Gate 3', 'Reúna seu grupo e retorne aos Reinos Esquecidos em um conto de companheirismo, traição, sacrifício e sobrevivência. Baseado em Dungeons & Dragons, este RPG oferece liberdade sem precedentes para explorar, experimentar e interagir com um mundo que reage a você.', '2023-08-03', 'https://images.igdb.com/igdb/image/upload/t_cover_big/co670h.png', 14, NULL),
(15, 'Fallout: New Vegas', 'No deserto de Mojave pós-apocalíptico, você é um mensageiro deixado para morrer que busca vingança e se envolve em um conflito complexo entre facções que disputam o controle da cidade de New Vegas e seus recursos. Um RPG aclamado por suas escolhas e narrativa.', '2010-10-19', 'https://www.mobygames.com/images/covers/l/120298-fallout-new-vegas-front-cover.jpg', 15, 14),
(16, 'Star Wars Jedi: Survivor', 'Cinco anos após os eventos de Fallen Order, o agora mais poderoso Cavaleiro Jedi Cal Kestis continua sua luta contra o Império. Explore novos planetas, aprenda novas habilidades da Força e enfrente inimigos ainda mais perigosos para manter a esperança viva na galáxia.', '2023-04-28', 'https://www.mobygames.com/images/covers/l/720950-star-wars-jedi-survivor-front-cover.jpg', 16, 1),
(17, 'Ghost of Tsushima', 'No final do século XIII, a ilha de Tsushima é invadida pelo exército mongol. Como Jin Sakai, um dos últimos samurais sobreviventes, você deve abandonar as tradições e forjar um novo caminho, o do Fantasma, para lutar pela liberdade do Japão.', '2020-07-17', 'https://www.mobygames.com/images/covers/l/51356-ghost-of-tsushima-front-cover.jpg', 17, 4),
(18, 'Death Stranding', 'No papel de Sam Porter Bridges, sua missão é entregar cargas e reconectar as cidades isoladas de uma América fragmentada e assombrada por criaturas de outro mundo. Uma experiência única que desafia gêneros, criada por Hideo Kojima.', '2019-11-08', 'https://upload.wikimedia.org/wikipedia/pt/e/eb/Death-Stranding-poster.jpg', 18, 4),
(19, 'Final Fantasy VII Remake', 'A primeira parte da recriação do lendário RPG, focada na cidade distópica de Midgar. Jogue como o mercenário Cloud Strife e junte-se ao grupo de resistência AVALANCHE para lutar contra a megacorporação Shinra em um sistema de batalha que mescla ação em tempo real e comandos estratégicos.', '2020-04-10', 'https://www.mobygames.com/images/covers/l/518179-final-fantasy-vii-remake-front-cover.jpg', 19, 7),
(20, 'Resident Evil 4 (Remake)', 'O agente Leon S. Kennedy é enviado em uma missão para resgatar a filha do presidente dos EUA de um misterioso culto em uma vila europeia. Esta recriação moderniza o clássico de terror de sobrevivência com gráficos aprimorados, jogabilidade refinada e uma atmosfera ainda mais tensa.', '2023-03-24', 'https://www.mobygames.com/images/covers/l/591984-resident-evil-4-remake-front-cover.jpg', 20, 9),
(21, 'League of Legends', 'Um dos MOBAs mais populares do mundo, onde duas equipes de cinco jogadores, cada um controlando um \"Campeão\" com habilidades únicas, batalham para destruir a base inimiga. Um jogo de alta estratégia, trabalho em equipe e competição intensa.', '2009-10-27', 'https://www.mobygames.com/images/covers/l/386351-league-of-legends-front-cover.jpg', 21, 23),
(22, 'Fortnite', 'Um fenômeno cultural que combina um jogo de tiro no estilo Battle Royale com mecânicas de construção únicas. Lute para ser o último sobrevivente em uma ilha, construindo estruturas para defesa e vantagem tática, em um ambiente vibrante e em constante mudança.', '2017-07-25', 'https://www.mobygames.com/images/covers/l/973554-fortnite-front-cover.jpg', 22, NULL),
(23, 'Minecraft', 'Um jogo de sandbox sobre colocar blocos e viver aventuras. Explore mundos gerados aleatoriamente, construa desde casas simples a castelos grandiosos, jogue no modo criativo com recursos ilimitados ou minere fundo no modo de sobrevivência.', '2011-11-18', 'https://www.mobygames.com/images/covers/l/516941-minecraft-front-cover.jpg', 23, 11),
(24, 'Stardew Valley', 'Herde a velha fazenda do seu avô e transforme-a em um lar próspero. Neste RPG de simulação de vida rural, você pode cultivar, criar animais, pescar, minerar e construir relacionamentos com os habitantes da cidade de Pelican Town.', '2016-02-26', 'https://www.mobygames.com/images/covers/l/791991-stardew-valley-front-cover.jpg', 24, 33),
(25, 'Red Dead Redemption 2', 'América, 1899. O fim da era do Velho Oeste começou. Após um assalto dar errado, Arthur Morgan e a gangue Van der Linde são forçados a fugir. Uma história épica sobre honra e lealdade em um vasto e detalhado mundo aberto.', '2018-10-26', 'https://www.mobygames.com/images/covers/l/467051-red-dead-redemption-2-front-cover.jpg', 2, 6),
(26, 'Sekiro: Shadows Die Twice', 'No Japão do final do século XVI, você é um \"lobo de um braço só\", um shinobi desonrado resgatado da beira da morte. Sua missão é proteger um jovem lorde, enfrentando inimigos mortais com um arsenal de ferramentas protéticas e um combate focado em postura e precisão.', '2019-03-22', 'https://www.mobygames.com/images/covers/l/759166-sekiro-shadows-die-twice-front-cover.jpg', 4, 5),
(27, 'Bloodborne', 'Viaje para a antiga cidade de Yharnam, amaldiçoada com uma estranha doença endêmica. Como um caçador, você deve desvendar os segredos sombrios da cidade e lutar contra criaturas aterrorizantes neste RPG de ação gótico e desafiador.', '2015-03-24', 'https://upload.wikimedia.org/wikipedia/pt/2/29/Bloodborne_capa.png', 4, 4),
(28, 'Uncharted 4: A Thief\'s End', 'Vários anos após sua última aventura, o caçador de tesouros aposentado Nathan Drake é forçado a voltar ao mundo dos ladrões. Nesta jornada final e mais pessoal, Drake embarca em uma caçada por uma conspiração histórica por trás de um tesouro pirata.', '2016-05-10', 'https://images.igdb.com/igdb/image/upload/t_cover_big/co483e.png', 1, 4),
(29, 'Super Mario Odyssey', 'Junte-se a Mario em uma enorme aventura 3D ao redor do mundo! Usando seu novo companheiro, Cappy, Mario tem novas habilidades para coletar Luas de Poder e resgatar a Princesa Peach das garras de Bowser.', '2017-10-27', 'https://www.mobygames.com/images/covers/l/788950-super-mario-odyssey-front-cover.jpg', 8, 3),
(30, 'Cyberpunk 2077', 'Um RPG de ação e aventura em mundo aberto ambientado em Night City, uma megalópole obcecada por poder, glamour e modificações corporais. Jogue como V, um mercenário fora da lei em busca de um implante único que é a chave para a imortalidade.', '2020-12-10', 'https://upload.wikimedia.org/wikipedia/en/9/9f/Cyberpunk_2077_box_art.jpg', 3, 18),
(31, 'Dark Souls III', 'O capítulo final da aclamada série de RPGs de ação. Viaje para o Reino de Lothric em busca dos Senhores das Cinzas para reacender a Primeira Chama. Famoso por seu level design intrincado e combate brutalmente desafiador.', '2016-03-24', 'https://upload.wikimedia.org/wikipedia/pt/e/e9/Dark_Souls_3_capa.png', 4, 8),
(32, 'God of War (2018)', 'Longe da sombra dos deuses, Kratos vive como um homem na terra da mitologia nórdica. Como mentor e protetor de seu filho, Atreus, ele deve lutar para sobreviver em um mundo hostil e ensinar seu filho a fazer o mesmo, enquanto controla a raiva que o definiu por tanto tempo.', '2018-04-20', 'https://www.mobygames.com/images/covers/l/165508-god-of-war-2018-front-cover.jpg', 5, 4),
(33, 'Ratchet & Clank: Rift Apart', 'Atravesse dimensões com Ratchet e Clank enquanto eles enfrentam um imperador maligno de outra realidade. Salte entre mundos cheios de ação em velocidades alucinantes, com um arsenal de armas insanas, em uma aventura visualmente deslumbrante.', '2021-06-11', 'https://www.mobygames.com/images/covers/l/485332-ratchet-and-clank-rift-apart-front-cover.jpg', 7, 4),
(34, 'Alan Wake 2', 'Uma sequência do aclamado jogo de terror psicológico. A história segue a agente do FBI Saga Anderson, que investiga assassinatos ritualísticos, e o escritor Alan Wake, que tenta escapar de uma dimensão de pesadelo escrevendo uma história de terror.', '2023-10-27', 'https://cdn1.epicgames.com/offer/c4763f236d08423eb47b4c3008779c84/EGS_AlanWake2_RemedyEntertainment_S2_1200x1600-c7c8091ddac0f9669c8e5905bca88aaa', 13, NULL),
(35, 'Apex Legends', 'Um battle royale de tiro com heróis, onde personagens lendários com habilidades poderosas se unem para lutar por fama e fortuna nos confins da Fronteira. Domine um elenco crescente de Lendas, jogabilidade tática em esquadrão e inovações ousadas.', '2019-02-04', 'https://upload.wikimedia.org/wikipedia/pt/a/ad/Apex_legends_capa.jpg?20190208222841\', 16, 1)', 16, 1),
(36, 'Titanfall 2', 'Um FPS que combina jogabilidade rápida e ágil de pilotos com combates estratégicos de titãs (robôs gigantes). Aclamado por sua campanha single-player envolvente e um modo multiplayer profundo e recompensador.', '2016-10-28', 'https://www.mobygames.com/images/covers/l/614540-titanfall-2-front-cover.jpg', 16, 1),
(37, 'Hollow Knight', 'Explore o vasto reino interconectado de Hallownest, um mundo de insetos e heróis. Este jogo de ação e aventura 2D no estilo Metroidvania é conhecido por sua atmosfera, combate desafiador e segredos escondidos.', '2017-02-24', 'https://www.mobygames.com/images/covers/l/696990-hollow-knight-front-cover.jpg', 25, 24),
(38, 'Celeste', 'Ajude Madeline a sobreviver a seus demônios internos em sua jornada até o topo da Montanha Celeste. Um jogo de plataforma super afiado e desafiador, com uma narrativa surpreendentemente emocionante sobre perseverança e saúde mental.', '2018-01-25', 'https://cdn1.epicgames.com/offer/b671fbc7be424e888c9346a9a6d3d9db/CodeRedemption_Celeste-340x440-873dacb76be8c59d659757b4b5284a611_1200x1600-9e39079f1ce19738e65d349a8bc98650', 26, 34),
(39, 'Portal 2', 'Retorne aos laboratórios da Aperture Science e encare novamente a inteligência artificial mortalmente inventiva, GLaDOS. Este jogo de puzzle em primeira pessoa expande a jogabilidade de portais com novas mecânicas e uma campanha cooperativa para dois jogadores.', '2011-04-19', 'https://www.mobygames.com/images/covers/l/177443-portal-2-front-cover.jpg', 12, NULL),
(40, 'BioShock Infinite', 'Na cidade flutuante de Columbia, o ex-detetive Booker DeWitt é contratado para resgatar uma jovem misteriosa chamada Elizabeth. Uma aventura em primeira pessoa com uma narrativa complexa que explora temas de excepcionalismo americano, religião e realidades paralelas.', '2013-03-26', 'https://upload.wikimedia.org/wikipedia/pt/a/a3/Official_cover_art_for_Bioshock_Infinite.jpg', 27, 6),
(41, 'Metal Gear Solid V: The Phantom Pain', 'Na pele de \"Venom Snake\", estabeleça um novo exército privado e busque vingança contra a organização Cipher. Um jogo de ação furtiva em mundo aberto que oferece liberdade tática sem precedentes para abordar missões e uma narrativa cinematográfica profunda.', '2015-09-01', 'https://www.mobygames.com/images/covers/l/199932-metal-gear-solid-v-the-phantom-pain-front-cover.jpg', 18, 13),
(42, 'The Legend of Zelda: Breath of the Wild', 'Explore as vastas terras de Hyrule em uma aventura de mundo aberto que quebrou convenções. Escale torres e montanhas, descubra santuários escondidos e lute contra inimigos de várias formas, com um sistema de física e química que permite soluções criativas.', '2017-03-03', 'https://www.mobygames.com/images/covers/l/236436-the-legend-of-zelda-breath-of-the-wild-front-cover.jpg', 8, 3),
(43, 'Persona 5 Royal', 'Como líder dos Phantom Thieves of Hearts, um grupo de estudantes que despertam seus Personas, você deve realizar grandes assaltos para roubar os desejos maliciosos dos corações dos adultos. Um RPG japonês aclamado por seu estilo visual, trilha sonora e narrativa social.', '2019-10-31', 'https://www.mobygames.com/images/covers/l/849086-persona-5-royal-front-cover.jpg', 28, 10),
(44, 'Monster Hunter: World', 'Como um caçador da Quinta Frota, viaje para o \"Novo Mundo\" em busca de um Dragão Ancião. Cace e derrote monstros gigantescos em um ecossistema vivo e dinâmico, usando o ambiente a seu favor. Colete materiais para forjar armas e armaduras mais fortes.', '2018-01-26', 'https://www.mobygames.com/images/covers/l/139687-monster-hunter-world-front-cover.jpg', 20, 9),
(45, 'Street Fighter 6', 'A mais nova evolução da icônica série de jogos de luta. Com três modos de jogo distintos (Fighting Ground, World Tour e Battle Hub), o jogo oferece uma experiência robusta tanto para jogadores casuais quanto competitivos, com um sistema de combate inovador.', '2023-06-02', 'https://www.mobygames.com/images/covers/l/605454-street-fighter-6-front-cover.jpg', 20, 9),
(46, 'Devil May Cry 5', 'Os caçadores de demônios Dante, Nero e o misterioso V unem forças para enfrentar uma nova e avassaladora ameaça demoníaca. Um jogo de ação hack and slash de alta octanagem, aclamado por seu combate fluido, profundo e extremamente estiloso.', '2019-03-08', 'https://upload.wikimedia.org/wikipedia/pt/c/cb/Devil_May_Cry_5.jpg', 20, 9),
(47, 'Final Fantasy XVI', 'Embarque em uma jornada de fantasia com seus melhores amigos em um mundo aberto. Após anos de luta, o príncipe Noctis e seus companheiros viajam para se casar com sua noiva, mas acabam em uma luta para recuperar sua pátria de um império hostil.', '2023-06-22', 'https://www.mobygames.com/images/covers/l/691673-final-fantasy-xvi-front-cover.jpg', 19, 7),
(48, 'Starfield', 'Crie seu personagem e explore com liberdade sem igual enquanto embarca em uma jornada épica para desvendar o maior mistério da humanidade. Da Bethesda Game Studios, criadores de Skyrim e Fallout 4, este é um RPG de nova geração ambientado entre as estrelas.', '2023-09-06', 'https://www.mobygames.com/images/covers/l/419343-starfield-front-cover.jpg', 10, 11),
(49, 'Forza Horizon 5', 'Explore as paisagens vibrantes e em constante evolução do mundo aberto do México com ação de direção ilimitada e divertida em centenas dos melhores carros do mundo. Um festival de corrida aclamado por sua liberdade e diversidade de eventos.', '2021-11-09', 'https://www.mobygames.com/images/covers/l/403661-forza-horizon-5-front-cover.jpg', 61, 11),
(50, 'Gears 5', 'Com a guerra total se aproximando, Kait Diaz se desprende para descobrir sua conexão com o inimigo e descobre o verdadeiro perigo para Sera – ela mesma. Uma campanha intensa e modos multiplayer robustos marcam esta entrada na série de tiro em terceira pessoa.', '2019-09-10', 'https://www.mobygames.com/images/covers/l/907522-gears-5-front-cover.jpg', 62, 11),
(51, 'Hades', 'Desafie a morte como Zagreus, o príncipe do Submundo, em uma tentativa de escapar do domínio de seu pai, Hades. Um roguelike de ação aclamado pela crítica, com combate rápido, narrativa emergente e personagens memoráveis da mitologia grega.', '2020-09-17', 'https://www.mobygames.com/images/covers/l/233122-hades-front-cover.jpg', 30, 26),
(52, 'Disco Elysium', 'Um RPG inovador no qual você é um detetive com um sistema de habilidades único à sua disposição e um quarteirão inteiro para desvendar um assassinato. Interrogue personagens inesquecíveis, quebre casos ou aceite subornos. Torne-se um herói ou um desastre absoluto.', '2019-10-15', 'https://bdjogos.com.br/capas/5604-disco-elysium-pc-capa-1.webp', 31, 27),
(53, 'Outer Wilds', 'Você é o mais novo recruta do Outer Wilds Ventures, um programa espacial novato em busca de respostas em um sistema solar estranho e em constante evolução. Preso em um loop temporal de 22 minutos, você deve desvendar um mistério intergaláctico antes que o sol exploda.', '2019-05-28', 'https://www.mobygames.com/images/covers/l/64623-outer-wilds-front-cover.jpg', 32, 17),
(54, 'Returnal', 'Após um pouso forçado em um planeta alienígena que muda de forma, a astronauta Selene se vê presa em um ciclo interminável de morte e ressurreição. Um desafiador jogo de tiro em terceira pessoa no estilo roguelike, com uma narrativa de ficção científica e terror psicológico.', '2021-04-30', 'https://www.mobygames.com/images/covers/l/561730-returnal-front-cover.jpg', 33, 4),
(55, 'It Takes Two', 'Embarque na jornada mais maluca da sua vida neste jogo de aventura e plataforma exclusivamente cooperativo. Jogue como o casal em conflito Cody e May, dois humanos transformados em bonecos por um feitiço mágico, que devem trabalhar juntos para consertar seu relacionamento.', '2021-03-26', 'https://www.mobygames.com/images/covers/l/182758-it-takes-two-front-cover.jpg', 34, 1),
(56, 'A Plague Tale: Requiem', 'Siga a jornada de Amicia e seu irmão Hugo em uma busca desesperada por uma nova casa ao sul da França do século XIV. Após escaparem de sua terra natal devastada, eles tentam começar uma nova vida e controlar a maldição de Hugo, mas a morte e a destruição retornam na forma de uma praga de ratos.', '2022-10-18', 'https://upload.wikimedia.org/wikipedia/pt/9/90/A_Plague_Tale_Requiem_capa.jpg', 35, 20),
(57, 'Ori and the Will of the Wisps', 'Embarque em uma nova jornada em um mundo vasto e exótico, onde você enfrentará inimigos imponentes e quebra-cabeças desafiadores. Ori and the Will of the Wisps é um aclamado jogo de plataforma e aventura, conhecido por sua arte deslumbrante e história emocionante.', '2020-03-11', 'https://www.mobygames.com/images/covers/l/879331-ori-and-the-will-of-the-wisps-front-cover.jpg', 36, 11),
(58, 'Cuphead', 'Um jogo de ação e plataforma no estilo \"corra e atire\", com uma estética inspirada nos desenhos animados da década de 1930. Jogue como Cuphead ou Mugman enquanto atravessa mundos estranhos e enfrenta chefes desafiadores para pagar sua dívida com o diabo.', '2017-09-29', 'https://upload.wikimedia.org/wikipedia/pt/c/c1/Cuphead_capa.png', 37, 36),
(59, 'The Binding of Isaac: Rebirth', 'Um roguelike de tiro com dois analógicos gerado aleatoriamente com fortes elementos de RPG. Siga Isaac em sua jornada para encontrar um lugar seguro enquanto ele desce em um porão cheio de monstros, descobre segredos e luta para sobreviver.', '2014-11-04', 'https://www.mobygames.com/images/covers/l/842500-the-binding-of-isaac-rebirth-front-cover.jpg', 38, 37),
(60, 'Slay the Spire', 'Uma fusão de construção de baralhos e roguelike. Crie um baralho único, encontre criaturas bizarras, descubra relíquias de imenso poder e lute para chegar ao topo da Torre. Cada jornada oferece um layout diferente e novos desafios.', '2019-01-23', 'https://www.mobygames.com/images/covers/l/678286-slay-the-spire-front-cover.jpg', 39, 28),
(61, 'Among Us', 'Um jogo online de trabalho em equipe e traição para 4 a 15 jogadores. Enquanto os tripulantes tentam preparar sua nave para a partida, um ou mais impostores estão a bordo tentando sabotar e eliminar a todos. Um jogo de dedução social e sobrevivência.', '2018-06-15', 'https://s2-ge.glbimg.com/s_1rjlFZP56dnqTZ6cgjrcxI1Qg=/1200x/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2021/a/t/1TE1NJRCCBri0viST5WQ/among-us-2-cancelado.jpg', 40, 30),
(62, 'Fall Guys', 'Junte-se a hordas de competidores online em uma corrida maluca através de rodadas e rodadas de caos crescente até que um vencedor permaneça! Um jogo multiplayer massivo no estilo de gincanas, onde os jogadores enfrentam obstáculos bizarros e desafiam as leis da física.', '2020-08-04', 'https://www.mobygames.com/images/covers/l/419040-fall-guys-front-cover.jpg', 41, 16),
(63, 'Genshin Impact', 'Um RPG de ação em mundo aberto com uma estética de anime. Explore o vasto mundo de Teyvat, domine os sete elementos e desvende os mistérios que ele guarda. Jogue sozinho ou com amigos em um sistema de combate dinâmico e envolvente.', '2020-09-28', 'https://www.mobygames.com/images/covers/l/834239-genshin-impact-front-cover.jpg', 42, 31),
(64, 'Valorant', 'Um jogo de tiro tático 5v5 focado em personagens, onde mira precisa e habilidades táticas são cruciais. Com um elenco diverso de Agentes, cada um com habilidades únicas, e mapas projetados para milhares de horas de jogo, a criatividade é sua melhor arma.', '2020-06-02', 'https://www.mobygames.com/images/covers/l/331550-valorant-front-cover.jpg', 21, 23),
(65, 'Overwatch 2', 'Um jogo de tiro em equipe otimista e gratuito, ambientado em um futuro vibrante. Junte-se à luta, escolha seu herói com habilidades únicas e batalhe em mapas ao redor do mundo em um combate 5v5 focado em objetivos.', '2022-10-04', 'https://www.mobygames.com/images/covers/l/624304-overwatch-2-front-cover.jpg', 43, 5),
(66, 'Diablo IV', 'O retorno da lendária série de RPG de ação. Crie seu personagem e explore o vasto e sombrio mundo de Santuário, lute contra hordas de demônios, colete equipamentos poderosos e enfrente a ameaça de Lilith em um mundo online compartilhado.', '2023-06-05', 'https://m.media-amazon.com/images/I/61LtU8b5p9L._UF1000,1000_QL80_.jpg', 43, 5),
(68, 'Call of Duty: Modern Warfare III (2023)', 'Uma experiência de battle royale gratuita em constante evolução dentro do universo de Call of Duty. Lute em mapas massivos como Verdansk e Caldera, com jogabilidade clássica de Call of Duty, em modos que suportam até 150 jogadores.', '2023-11-10', 'https://upload.wikimedia.org/wikipedia/pt/7/74/MWIII_Capa.png', NULL, 5),
(69, 'Battlefield 2042', 'Mergulhe na brutalidade da Primeira Guerra Mundial através de uma campanha global. Lute em batalhas épicas, desde combates urbanos em uma cidade francesa sitiada até os fortes fortemente defendidos nos Alpes italianos ou combates frenéticos nos desertos da Arábia.', '2021-11-19', 'https://bdjogos.com.br/capas/10994-battlefield-2042-capa-1.jpg', NULL, 1),
(70, 'The Sims 4', 'Liberte sua imaginação e crie um mundo único de Sims que é uma expressão de você! Explore e personalize cada detalhe, desde os Sims até suas casas. Um jogo de simulação de vida onde você controla as ricas e divertidas histórias de seus personagens.', '2014-09-02', 'https://www.mobygames.com/images/covers/l/467115-the-sims-4-front-cover.jpg', 44, 1),
(71, "Assassin\'s Creed Valhalla", 'Embarque em uma jornada épica para se tornar um lendário herói espartano na Grécia Antiga. Suas decisões moldam o mundo ao seu redor em um jogo onde você explora um país rico em mitos e lendas, desde a Atenas vibrante até ilhas vulcânicas.', '2020-11-10', 'https://upload.wikimedia.org/wikipedia/pt/e/e9/Assassins_Creed_Valhalla_capa.png', 45, 2),
(72, 'Far Cry 6', 'Explore um paraíso tropical congelado no tempo. Hope County, Montana, foi tomada por um culto apocalíptico fanático. Lute para libertar a comunidade sitiada, formando uma resistência e enfrentando o carismático líder do culto, Joseph Seed, e seus irmãos.', '2021-10-07', 'https://www.mobygames.com/images/covers/l/850176-far-cry-6-front-cover.jpg', 45, 2),
(73, 'Rainbow Six Siege', 'Um jogo de tiro tático de elite, onde o trabalho em equipe e a estratégia são fundamentais. Domine a arte da destruição e o uso de gadgets em combates intensos de curta distância. Enfrente um combate 5v5 de ataque contra defesa altamente tático.', '2015-12-01', 'https://www.mobygames.com/images/covers/l/487370-rainbow-six-siege-front-cover.jpg', 45, 2),
(74, 'Watch Dogs: Legion', 'Construa uma resistência a partir de praticamente qualquer pessoa que você vê enquanto hackeia, se infiltra e luta para retomar uma Londres de futuro próximo que está à beira do colapso. Recrute e jogue como qualquer um na cidade, cada um com uma história e habilidades únicas.', '2020-10-29', 'https://www.mobygames.com/images/covers/l/391674-watch-dogs-legion-front-cover.jpg', 45, 2),
(75, 'Cyberpunk 2077: Phantom Liberty', 'Uma expansão de suspense e espionagem para Cyberpunk 2077. Retorne como V e embarque em uma missão de alto risco em Dogtown, um distrito mortal de Night City, para salvar a presidente dos Novos Estados Unidos. Envolva-se em uma teia de lealdades quebradas e maquinações políticas.', '2023-09-26', 'https://cdn1.epicgames.com/offer/77f2b98e2cef40c8a7437518bf420e47/EGS_Cyberpunk2077PhantomLiberty_CDPROJEKTRED_DLC_S2_1200x1600-3acec02a8b11a2c50ba8dd3cb217f1c6', 3, 18),
(76, 'Hogwarts Legacy', 'Viva uma história não escrita no mundo de Harry Potter. Crie seu próprio personagem e embarque em uma jornada perigosa para descobrir uma verdade oculta do mundo bruxo. Domine feitiços, prepare poções e dome feras mágicas neste RPG de ação em mundo aberto.', '2023-02-10', 'https://www.mobygames.com/images/covers/l/479494-hogwarts-legacy-front-cover.jpg', 46, 15),
(77, 'Mortal Kombat 1', 'Descubra um Universo Mortal Kombat renascido, criado pelo Deus do Fogo Liu Kang. Mortal Kombat 1 inaugura uma nova era da icônica franquia com um novo sistema de luta, modos de jogo e fatalidades, apresentando versões reimaginadas de personagens clássicos.', '2023-09-19', 'https://www.mobygames.com/images/covers/l/718121-mortal-kombat-1-front-cover.jpg', 47, 15),
(78, 'Batman: Arkham Knight', 'No final explosivo da série Arkham, o Espantalho retorna para unir um grupo de supervilões e destruir o Batman para sempre. Patrulhe as ruas e os céus de Gotham City com o Batmóvel em um vasto mundo aberto e enfrente a ameaça definitiva.', '2015-06-23', 'https://upload.wikimedia.org/wikipedia/pt/5/5d/Batman_Arkham_Knight_Capa.jpg', 48, 15),
(79, 'Detroit: Become Human', 'Em um futuro próximo, explore um mundo onde androides semelhantes a humanos são tratados como ferramentas. Jogue como três androides diferentes (Kara, Connor e Markus) e veja o mundo através de seus olhos, tomando decisões que determinarão seu destino e o futuro da cidade de Detroit.', '2018-05-25', 'https://upload.wikimedia.org/wikipedia/pt/0/02/Detroit_Become_Human_capa.png', 49, 4),
(80, 'Heavy Rain', 'Um thriller psicológico interativo onde cada decisão pode ter consequências dramáticas. Cace o misterioso \"Assassino do Origami\" no papel de quatro personagens diferentes, cada um seguindo suas próprias pistas. Suas ações determinarão quem vive e quem morre.', '2010-02-23', 'https://www.mobygames.com/images/covers/l/351072-heavy-rain-front-cover.jpg', 49, 4),
(81, 'Until Dawn', 'Quando oito amigos ficam presos em um refúgio remoto na montanha, eventos sinistros começam a se desenrolar, e eles percebem que não estão sozinhos. Neste jogo de terror interativo, suas escolhas determinam quem sobrevive à noite.', '2015-08-25', 'https://www.mobygames.com/images/covers/l/959972-until-dawn-front-cover.jpg', 50, 4),
(82, 'Lies of P', 'Você é uma marionete criada por Geppetto, presa em uma teia de mentiras com monstros inimagináveis e figuras não confiáveis. Desperto em uma cidade sombria da Belle Époque, você deve adaptar a si mesmo e suas armas para enfrentar horrores indescritíveis e desvendar os segredos da cidade.', '2023-09-18', 'https://www.mobygames.com/images/covers/l/673071-lies-of-p-front-cover.jpg', 51, 41),
(83, 'Hi-Fi Rush', 'Sinta a batida como o aspirante a rockstar Chai e sua equipe de aliados desajustados enquanto lutam contra uma megacorporação tecnológica maligna. Um jogo de ação e ritmo onde tudo - desde o movimento do ambiente até os ataques - está sincronizado com a música.', '2023-01-25', 'https://www.mobygames.com/images/covers/l/415452-hi-fi-rush-front-cover.jpg', 52, 14),
(84, 'Psychonauts 2', 'Combine poderes psíquicos e habilidades de plataforma nesta aguardada sequência. Jogue como Razputin Aquato, um acrobata treinado e poderoso jovem psíquico, que realizou seu sonho de se juntar à organização internacional de espionagem psíquica conhecida como Psychonauts.', '2021-08-25', 'https://www.mobygames.com/images/covers/l/738662-psychonauts-2-front-cover.jpg', 53, 11),
(85, 'Crusader Kings III', 'Lidere sua dinastia através dos séculos em um dos jogos de estratégia mais profundos já feitos. Viva a vida de seus personagens, desde casamentos e intrigas até guerras e diplomacia, garantindo que sua linhagem real perdure.', '2020-09-01', 'https://upload.wikimedia.org/wikipedia/en/a/a3/Crusader_Kings_III.jpg?20200831221047', 55, 21),
(86, 'Cities: Skylines II', 'Construa uma cidade do zero e transforme-a em uma metrópole próspera nesta sequência do aclamado construtor de cidades. Com simulação profunda, economia viva e ferramentas de criatividade sem precedentes, este é o simulador de construção de cidades mais realista de todos os tempos.', '2023-10-24', 'https://bdjogos.com.br/capas/18798-cities-skylines-ii-pc-capa-1.jpg', 54, 21),
(87, 'Stellaris', 'Explore uma galáxia cheia de maravilhas neste jogo de grande estratégia de ficção científica. Interaja com diversas raças alienígenas, descubra novos mundos estranhos, forje um império galáctico e enfrente crises de fim de jogo que ameaçam toda a vida.', '2016-05-09', 'https://www.mobygames.com/images/covers/l/556861-stellaris-front-cover.jpg', 55, 21),
(88, 'Arma 3', 'Experimente a verdadeira jogabilidade de combate em um sandbox militar massivo. Com um terreno de mundo aberto imenso, mais de 20 veículos e 40 armas, e oportunidades ilimitadas para criação de conteúdo, este é o principal jogo militar para PC.', '2013-09-12', 'https://assets.sbnation.com/assets/2260639/arma3_artwork.jpg', 56, 42),
(89, 'DayZ', 'Lute para sobreviver em um mundo aberto pós-apocalíptico e hostil, onde cada outro jogador pode ser um inimigo. Sem tutoriais ou ajuda, você deve procurar comida, água, armas e roupas para sobreviver contra os elementos, os infectados e outros sobreviventes.', '2018-12-13', 'https://store-images.s-microsoft.com/image/apps.23097.69886306496288395.9ec42146-6037-4440-b5c7-3a44e5213cc3.0e09163e-a6c4-40f6-9fe1-24a6b4685c64', 56, 42),
(90, 'Rust', 'O único objetivo é sobreviver. Para fazer isso, você precisará superar lutas como fome, sede e frio. Construa um abrigo. Mate animais para obter carne. Proteja-se de outros jogadores e mate-os para obter carne. Crie alianças com outros jogadores e forme uma cidade.', '2018-02-08', 'https://www.comboinfinito.com.br/principal/wp-content/uploads/2018/01/Rust-capa.jpg', 63, 38),
(91, 'Terraria', 'Cave, lute, explore, construa! Nada é impossível neste jogo de aventura sandbox 2D cheio de ação. O mundo é sua tela e o próprio chão é sua pintura. Pegue suas ferramentas e vá em frente! Crie armas para lutar contra uma variedade de inimigos em biomas diversos.', '2011-05-16', 'https://upload.wikimedia.org/wikipedia/pt/e/ee/Terraria_capa.png?20240401153738', 57, 39),
(92, 'Valheim', 'Um jogo brutal de exploração e sobrevivência para 1 a 10 jogadores, ambientado em um purgatório gerado proceduralmente e inspirado na cultura viking. Lute, construa e conquiste seu caminho em uma saga digna da bênção de Odin!', '2021-02-02', 'https://www.gamers-shop.dk/images/game_img/vallheim.jpg', 58, 29),
(93, 'Phasmophobia', 'Um jogo de terror psicológico cooperativo online para 4 jogadores, onde você e sua equipe de investigadores paranormais entrarão em locais assombrados para reunir o máximo de evidências de atividade paranormal possível.', '2020-09-18', 'https://notadogame.com/uploads/game/cover/250x/5f8959f9292f2.jpg', 59, 40),
(94, 'Sea of Thieves', 'Um jogo de aventura em mundo compartilhado que oferece a experiência pirata definitiva. Navegue, lute, explore e saqueie em um vasto oceano, sozinho ou com amigos. Sem papéis definidos, você tem total liberdade para abordar o mundo e outros jogadores como quiser.', '2018-03-20', 'https://upload.wikimedia.org/wikipedia/pt/9/9d/Sea_of_thieves_box.jpg', 60, 11),
(95, "No Man\'s Sky", "Inspirado na aventura e imaginação que amamos da ficção científica clássica, No Man\'s Sky apresenta uma galáxia para explorar, cheia de planetas e formas de vida únicas, e perigo e ação constantes. Cada estrela é a luz de um sol distante, cada uma orbitada por planetas cheios de vida, e você pode ir para qualquer um deles que escolher.", '2016-08-09', 'https://upload.wikimedia.org/wikipedia/pt/5/5d/No_man_sky_cover.jpg', 29, 25);

-- --------------------------------------------------------

--
-- Estrutura para tabela `jogo_genero`
--

CREATE TABLE `jogo_genero` (
  `cod_jogo_fk` int(11) NOT NULL,
  `cod_genero_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `jogo_genero`
--

INSERT INTO `jogo_genero` (`cod_jogo_fk`, `cod_genero_fk`) VALUES
(1, 1),
(1, 2),
(1, 13),
(1, 14),
(2, 1),
(2, 2),
(2, 12),
(2, 15),
(3, 1),
(3, 3),
(3, 15),
(4, 1),
(4, 3),
(4, 15),
(4, 21),
(5, 1),
(5, 2),
(5, 22),
(6, 1),
(6, 2),
(6, 3),
(6, 15),
(7, 1),
(7, 2),
(7, 15),
(8, 1),
(8, 2),
(8, 15),
(9, 1),
(9, 3),
(9, 12),
(10, 2),
(10, 3),
(10, 15),
(11, 1),
(11, 11),
(12, 2),
(12, 11),
(12, 14),
(13, 1),
(13, 2),
(13, 12),
(14, 2),
(14, 3),
(14, 4),
(15, 3),
(15, 11),
(15, 15),
(16, 1),
(16, 2),
(16, 21),
(17, 1),
(17, 2),
(17, 15),
(17, 16),
(18, 1),
(18, 2),
(18, 15),
(19, 1),
(19, 3),
(20, 1),
(20, 13),
(20, 14),
(21, 4),
(21, 18),
(22, 12),
(22, 17),
(22, 24),
(23, 13),
(23, 23),
(23, 24),
(24, 3),
(24, 5),
(25, 1),
(25, 2),
(25, 15),
(26, 1),
(26, 2),
(26, 21),
(27, 1),
(27, 3),
(27, 21),
(28, 1),
(28, 2),
(28, 12),
(29, 2),
(29, 9),
(30, 1),
(30, 3),
(30, 11),
(30, 15),
(31, 1),
(31, 3),
(31, 21),
(32, 1),
(32, 2),
(32, 22),
(33, 1),
(33, 9),
(33, 12),
(34, 2),
(34, 13),
(34, 14),
(35, 11),
(35, 17),
(36, 1),
(36, 11),
(37, 2),
(37, 9),
(38, 9),
(39, 9),
(39, 10),
(40, 2),
(40, 11),
(41, 1),
(41, 15),
(41, 16),
(42, 1),
(42, 2),
(42, 15),
(43, 3),
(44, 1),
(44, 3),
(45, 8),
(46, 1),
(46, 22),
(47, 1),
(47, 3),
(47, 15),
(48, 3),
(48, 15),
(49, 6),
(49, 7),
(49, 15),
(50, 1),
(50, 12),
(51, 1),
(51, 3),
(51, 20),
(52, 3),
(53, 2),
(53, 10),
(54, 1),
(54, 12),
(54, 20),
(55, 1),
(55, 2),
(55, 9),
(56, 1),
(56, 2),
(56, 16),
(57, 2),
(57, 9),
(58, 1),
(58, 9),
(59, 1),
(59, 20),
(60, 4),
(60, 20),
(61, 13),
(62, 17),
(63, 1),
(63, 3),
(63, 15),
(64, 1),
(64, 11),
(65, 1),
(65, 11),
(66, 1),
(66, 3),
(66, 22),
(68, 1),
(68, 11),
(68, 17),
(69, 1),
(69, 11),
(70, 5),
(71, 1),
(71, 2),
(71, 3),
(71, 15),
(72, 1),
(72, 2),
(72, 11),
(72, 15),
(73, 4),
(73, 11),
(74, 1),
(74, 2),
(74, 15),
(75, 1),
(75, 3),
(76, 1),
(76, 3),
(76, 15),
(77, 8),
(78, 1),
(78, 2),
(78, 15),
(79, 2),
(80, 2),
(81, 2),
(81, 14),
(82, 1),
(82, 3),
(82, 21),
(83, 1),
(83, 25),
(84, 2),
(84, 9),
(85, 4),
(85, 5),
(86, 5),
(86, 23),
(87, 4),
(87, 5),
(88, 5),
(88, 11),
(89, 13),
(89, 15),
(90, 13),
(90, 15),
(91, 2),
(91, 24),
(92, 13),
(92, 15),
(92, 24),
(93, 14),
(94, 1),
(94, 2),
(94, 15),
(95, 2),
(95, 13),
(95, 24);

-- --------------------------------------------------------

--
-- Estrutura para tabela `jogo_plataforma`
--

CREATE TABLE `jogo_plataforma` (
  `cod_jogo_fk` int(11) NOT NULL,
  `cod_plataforma_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `jogo_plataforma`
--

INSERT INTO `jogo_plataforma` (`cod_jogo_fk`, `cod_plataforma_fk`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(3, 1),
(3, 3),
(3, 6),
(3, 8),
(4, 1),
(4, 2),
(4, 3),
(4, 5),
(4, 6),
(5, 2),
(5, 3),
(6, 2),
(6, 3),
(7, 2),
(8, 8),
(9, 1),
(9, 3),
(9, 6),
(10, 1),
(10, 3),
(10, 4),
(10, 6),
(10, 7),
(10, 8),
(11, 1),
(11, 2),
(11, 3),
(11, 5),
(11, 6),
(11, 8),
(12, 1),
(13, 1),
(13, 3),
(13, 6),
(14, 1),
(14, 2),
(14, 5),
(14, 14),
(15, 1),
(15, 4),
(15, 7),
(16, 1),
(16, 2),
(16, 5),
(17, 1),
(17, 2),
(17, 3),
(18, 1),
(18, 2),
(18, 3),
(19, 1),
(19, 2),
(19, 3),
(20, 1),
(20, 2),
(20, 3),
(20, 5),
(21, 1),
(21, 14),
(22, 1),
(22, 2),
(22, 3),
(22, 5),
(22, 6),
(22, 8),
(22, 13),
(23, 1),
(23, 3),
(23, 6),
(23, 8),
(23, 12),
(23, 13),
(23, 14),
(24, 1),
(24, 3),
(24, 6),
(24, 8),
(24, 12),
(24, 13),
(25, 1),
(25, 3),
(25, 6),
(26, 1),
(26, 3),
(26, 6),
(27, 3),
(28, 1),
(28, 2),
(28, 3),
(29, 8),
(30, 1),
(30, 2),
(30, 3),
(30, 5),
(30, 6),
(31, 1),
(31, 3),
(31, 6),
(32, 1),
(32, 3),
(33, 1),
(33, 2),
(34, 1),
(34, 2),
(34, 5),
(35, 1),
(35, 3),
(35, 6),
(35, 8),
(36, 1),
(36, 3),
(36, 6),
(37, 1),
(37, 3),
(37, 6),
(37, 8),
(38, 1),
(38, 3),
(38, 6),
(38, 8),
(39, 1),
(39, 4),
(39, 7),
(40, 1),
(40, 4),
(40, 7),
(41, 1),
(41, 3),
(41, 6),
(42, 8),
(42, 9),
(43, 1),
(43, 2),
(43, 3),
(43, 5),
(43, 6),
(43, 8),
(44, 1),
(44, 3),
(44, 6),
(45, 1),
(45, 2),
(45, 3),
(45, 5),
(46, 1),
(46, 3),
(46, 6),
(47, 2),
(48, 1),
(48, 5),
(49, 1),
(49, 5),
(49, 6),
(50, 1),
(50, 6),
(51, 1),
(51, 3),
(51, 6),
(51, 8),
(51, 14),
(52, 1),
(52, 3),
(52, 6),
(52, 8),
(52, 14),
(53, 1),
(53, 3),
(53, 6),
(54, 1),
(54, 2),
(55, 1),
(55, 2),
(55, 3),
(55, 5),
(55, 6),
(55, 8),
(56, 1),
(56, 2),
(56, 5),
(57, 1),
(57, 6),
(57, 8),
(58, 1),
(58, 3),
(58, 6),
(58, 8),
(59, 1),
(59, 3),
(59, 6),
(59, 8),
(60, 1),
(60, 3),
(60, 6),
(60, 8),
(60, 12),
(60, 13),
(61, 1),
(61, 3),
(61, 6),
(61, 8),
(61, 12),
(61, 13),
(62, 1),
(62, 3),
(62, 6),
(62, 8),
(63, 1),
(63, 2),
(63, 3),
(63, 12),
(63, 13),
(64, 1),
(65, 1),
(65, 3),
(65, 6),
(65, 8),
(66, 1),
(66, 2),
(66, 5),
(68, 1),
(68, 2),
(68, 5),
(69, 1),
(69, 2),
(69, 5),
(70, 1),
(70, 3),
(70, 6),
(70, 14),
(71, 1),
(71, 2),
(71, 3),
(71, 5),
(71, 6),
(72, 1),
(72, 2),
(72, 3),
(72, 5),
(72, 6),
(73, 1),
(73, 3),
(73, 6),
(74, 1),
(74, 3),
(74, 6),
(75, 1),
(75, 2),
(75, 5),
(76, 1),
(76, 2),
(76, 5),
(77, 1),
(77, 2),
(77, 5),
(77, 8),
(78, 1),
(78, 3),
(78, 6),
(79, 1),
(79, 3),
(80, 1),
(80, 3),
(80, 4),
(81, 3),
(82, 1),
(82, 2),
(82, 5),
(83, 1),
(83, 5),
(84, 1),
(84, 3),
(84, 6),
(85, 1),
(85, 14),
(85, 15),
(86, 1),
(87, 1),
(87, 14),
(87, 15),
(88, 1),
(89, 1),
(89, 3),
(89, 6),
(90, 1),
(90, 3),
(90, 6),
(90, 14),
(91, 1),
(91, 3),
(91, 6),
(91, 8),
(92, 1),
(92, 15),
(93, 1),
(94, 1),
(94, 5),
(94, 6),
(95, 1),
(95, 3),
(95, 6),
(95, 8),
(95, 14);

-- --------------------------------------------------------

--
-- Estrutura para tabela `plataforma`
--

CREATE TABLE `plataforma` (
  `cod_Plataforma` int(11) NOT NULL,
  `nome_Plataforma` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `plataforma`
--

INSERT INTO `plataforma` (`cod_Plataforma`, `nome_Plataforma`) VALUES
(13, 'Android'),
(23, 'Dreamcast'),
(20, 'GameCube'),
(12, 'iOS'),
(15, 'Linux'),
(14, 'macOS'),
(11, 'Nintendo 3DS'),
(24, 'Nintendo 64'),
(19, 'Nintendo DS'),
(8, 'Nintendo Switch'),
(10, 'Nintendo Wii'),
(9, 'Nintendo Wii U'),
(1, 'PC'),
(25, 'PlayStation'),
(21, 'PlayStation 2'),
(4, 'PlayStation 3'),
(3, 'PlayStation 4'),
(2, 'PlayStation 5'),
(17, 'PlayStation Vita'),
(18, 'PSP'),
(16, 'Steam Deck'),
(22, 'Xbox'),
(7, 'Xbox 360'),
(6, 'Xbox One'),
(5, 'Xbox Series X/S');

-- --------------------------------------------------------

--
-- Estrutura para tabela `postagem`
--

CREATE TABLE `postagem` (
  `cod_Postagem` int(11) NOT NULL,
  `cod_jogo_fk` int(11) NOT NULL,
  `cod_usuario_fk` int(11) NOT NULL,
  `texto_Postagem` text NOT NULL,
  `url_anexo_Postagem` varchar(255) DEFAULT NULL,
  `data_criacao_Postagem` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `postagem`
--

INSERT INTO `postagem` (`cod_Postagem`, `cod_jogo_fk`, `cod_usuario_fk`, `texto_Postagem`, `url_anexo_Postagem`, `data_criacao_Postagem`) VALUES
(1, 56, 1, 'teste de publicação!', NULL, '2025-09-28 20:43:20'),
(2, 56, 1, 'teste 2!', NULL, '2025-09-28 20:43:33');

-- --------------------------------------------------------

--
-- Estrutura para tabela `publicadora`
--

CREATE TABLE `publicadora` (
  `cod_Publicadora` int(11) NOT NULL,
  `nome_Publicadora` varchar(255) NOT NULL,
  `pais_Publicadora` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `publicadora`
--

INSERT INTO `publicadora` (`cod_Publicadora`, `nome_Publicadora`, `pais_Publicadora`) VALUES
(1, 'Electronic Arts', 'Estados Unidos'),
(2, 'Ubisoft', 'França'),
(3, 'Nintendo', 'Japão'),
(4, 'Sony Interactive Entertainment', 'Japão'),
(5, 'Activision Blizzard', 'Estados Unidos'),
(6, 'Take-Two Interactive', 'Estados Unidos'),
(7, 'Square Enix', 'Japão'),
(8, 'Bandai Namco Entertainment', 'Japão'),
(9, 'Capcom', 'Japão'),
(10, 'Sega', 'Japão'),
(11, 'Microsoft (Xbox Game Studios)', 'Estados Unidos'),
(12, 'Tencent Games', 'China'),
(13, 'Konami', 'Japão'),
(14, 'Bethesda Softworks', 'Estados Unidos'),
(15, 'Warner Bros. Interactive Entertainment', 'Estados Unidos'),
(16, 'Devolver Digital', 'Estados Unidos'),
(17, 'Annapurna Interactive', 'Estados Unidos'),
(18, 'CD Projekt', 'Polônia'),
(19, 'FromSoftware', 'Japão'),
(20, 'Focus Entertainment', 'França'),
(21, 'Paradox Interactive', 'Suécia'),
(22, '505 Games', 'Itália'),
(23, 'Riot Games', 'Estados Unidos'),
(24, 'Team Cherry', 'Austrália'),
(25, 'Hello Games', 'Reino Unido'),
(26, 'Supergiant Games', 'Estados Unidos'),
(27, 'ZA/UM', 'Estônia'),
(28, 'Humble Bundle', 'Estados Unidos'),
(29, 'Coffee Stain Publishing', 'Suécia'),
(30, 'Innersloth', 'Estados Unidos'),
(31, 'miHoYo', 'China'),
(32, 'PlayStation PC LLC', 'Estados Unidos'),
(33, 'ConcernedApe', 'Estados Unidos'),
(34, 'Extremely OK Games', 'Canadá'),
(35, 'Atlus', 'Japão'),
(36, 'Studio MDHR', 'Canadá'),
(37, 'Nicalis', 'Estados Unidos'),
(38, 'Facepunch Studios', 'Reino Unido'),
(39, 'Re-Logic', 'Estados Unidos'),
(40, 'Kinetic Games', 'Reino Unido'),
(41, 'NEOWIZ', 'Coreia do Sul'),
(42, 'Bohemia Interactive', 'República Tcheca');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `cod_usuario` int(11) NOT NULL,
  `nome_usuario` varchar(50) DEFAULT NULL,
  `username_usuario` varchar(50) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `password_usuario` varchar(255) DEFAULT NULL,
  `foto_usuario` varchar(100) DEFAULT NULL,
  `conta_ativa` tinyint(1) NOT NULL DEFAULT 1,
  `criacao_usuario` timestamp NOT NULL DEFAULT current_timestamp(),
  `tipo_usuario` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = Usuário Normal, 1 = Administrador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`cod_usuario`, `nome_usuario`, `username_usuario`, `email_usuario`, `password_usuario`, `foto_usuario`, `conta_ativa`, `criacao_usuario`, `tipo_usuario`) VALUES
(1, 'Fábio Busnardo', 'fabio', 'fabiobusnardo@hotmail.com', 'scrypt:32768:8:1$mKVLdtOEaWxQ8G1h$2d6bea6df53a1bcdcd961b4736cf0d02c8898a8364370fc80e09909acc6bf58ecc203a6db17d1b5efba81ad0ce9ee0df096b55e2a30554e75b200f4062475cb8', NULL, 1, '2025-09-28 14:03:56', 1),
(2, 'teste', 'teste', 'teste@teste.com', 'scrypt:32768:8:1$xHdxOaeGgO8m8YC1$c8f5e2644ce14363bc0bb74f35f5339c194c32f27744cf3d22a6c9f61cb32e313d5848970bd426b588e315c9482f52c760c9a659675f4bd420f618212be3cb63', NULL, 1, '2025-09-28 19:03:55', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD PRIMARY KEY (`cod_Avaliacao`),
  ADD UNIQUE KEY `idx_usuario_jogo_unico` (`cod_usuario_fk`,`cod_jogo_fk`),
  ADD KEY `fk_Avaliacao_Usuario_idx` (`cod_usuario_fk`),
  ADD KEY `fk_Avaliacao_Jogo_idx` (`cod_jogo_fk`);

--
-- Índices de tabela `captura_tela`
--
ALTER TABLE `captura_tela`
  ADD PRIMARY KEY (`cod_Captura_Tela`),
  ADD KEY `fk_Captura_Tela_Jogo_idx` (`cod_jogo_fk`);

--
-- Índices de tabela `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`cod_Comentario`),
  ADD KEY `fk_Comentario_Postagem_idx` (`cod_postagem_fk`),
  ADD KEY `fk_Comentario_Usuario_idx` (`cod_usuario_fk`);

--
-- Índices de tabela `desenvolvedor`
--
ALTER TABLE `desenvolvedor`
  ADD PRIMARY KEY (`cod_Desenvolvedor`),
  ADD UNIQUE KEY `nome_UNIQUE` (`nome_Desenvolvedor`);

--
-- Índices de tabela `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`cod_Genero`),
  ADD UNIQUE KEY `nome_UNIQUE` (`nome_Genero`);

--
-- Índices de tabela `jogo`
--
ALTER TABLE `jogo`
  ADD PRIMARY KEY (`cod_Jogo`),
  ADD KEY `fk_Jogo_Desenvolvedor_idx` (`cod_desenvolvedor_fk`),
  ADD KEY `fk_Jogo_Publicadora_idx` (`cod_publicadora_fk`);

--
-- Índices de tabela `jogo_genero`
--
ALTER TABLE `jogo_genero`
  ADD PRIMARY KEY (`cod_jogo_fk`,`cod_genero_fk`),
  ADD KEY `fk_Jogo_Genero_Genero_idx` (`cod_genero_fk`);

--
-- Índices de tabela `jogo_plataforma`
--
ALTER TABLE `jogo_plataforma`
  ADD PRIMARY KEY (`cod_jogo_fk`,`cod_plataforma_fk`),
  ADD KEY `fk_Jogo_Plataforma_Plataforma_idx` (`cod_plataforma_fk`);

--
-- Índices de tabela `plataforma`
--
ALTER TABLE `plataforma`
  ADD PRIMARY KEY (`cod_Plataforma`),
  ADD UNIQUE KEY `nome_UNIQUE` (`nome_Plataforma`);

--
-- Índices de tabela `postagem`
--
ALTER TABLE `postagem`
  ADD PRIMARY KEY (`cod_Postagem`),
  ADD KEY `fk_Postagem_Jogo_idx` (`cod_jogo_fk`),
  ADD KEY `fk_Postagem_Usuario_idx` (`cod_usuario_fk`);

--
-- Índices de tabela `publicadora`
--
ALTER TABLE `publicadora`
  ADD PRIMARY KEY (`cod_Publicadora`),
  ADD UNIQUE KEY `nome_UNIQUE` (`nome_Publicadora`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`cod_usuario`),
  ADD UNIQUE KEY `email_usuario` (`email_usuario`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `avaliacao`
--
ALTER TABLE `avaliacao`
  MODIFY `cod_Avaliacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `captura_tela`
--
ALTER TABLE `captura_tela`
  MODIFY `cod_Captura_Tela` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `comentario`
--
ALTER TABLE `comentario`
  MODIFY `cod_Comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `desenvolvedor`
--
ALTER TABLE `desenvolvedor`
  MODIFY `cod_Desenvolvedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT de tabela `genero`
--
ALTER TABLE `genero`
  MODIFY `cod_Genero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `jogo`
--
ALTER TABLE `jogo`
  MODIFY `cod_Jogo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de tabela `plataforma`
--
ALTER TABLE `plataforma`
  MODIFY `cod_Plataforma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `postagem`
--
ALTER TABLE `postagem`
  MODIFY `cod_Postagem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `publicadora`
--
ALTER TABLE `publicadora`
  MODIFY `cod_Publicadora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `cod_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD CONSTRAINT `fk_Avaliacao_Jogo` FOREIGN KEY (`cod_jogo_fk`) REFERENCES `jogo` (`cod_Jogo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Avaliacao_Usuario` FOREIGN KEY (`cod_usuario_fk`) REFERENCES `usuario` (`cod_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `captura_tela`
--
ALTER TABLE `captura_tela`
  ADD CONSTRAINT `fk_Captura_Tela_Jogo` FOREIGN KEY (`cod_jogo_fk`) REFERENCES `jogo` (`cod_Jogo`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `fk_Comentario_Postagem` FOREIGN KEY (`cod_postagem_fk`) REFERENCES `postagem` (`cod_Postagem`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_Comentario_Usuario` FOREIGN KEY (`cod_usuario_fk`) REFERENCES `usuario` (`cod_usuario`) ON DELETE CASCADE;

--
-- Restrições para tabelas `jogo`
--
ALTER TABLE `jogo`
  ADD CONSTRAINT `fk_Jogo_Desenvolvedor` FOREIGN KEY (`cod_desenvolvedor_fk`) REFERENCES `desenvolvedor` (`cod_Desenvolvedor`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Jogo_Publicadora` FOREIGN KEY (`cod_publicadora_fk`) REFERENCES `publicadora` (`cod_Publicadora`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Restrições para tabelas `jogo_genero`
--
ALTER TABLE `jogo_genero`
  ADD CONSTRAINT `fk_Jogo_Genero_Genero` FOREIGN KEY (`cod_genero_fk`) REFERENCES `genero` (`cod_Genero`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Jogo_Genero_Jogo` FOREIGN KEY (`cod_jogo_fk`) REFERENCES `jogo` (`cod_Jogo`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `jogo_plataforma`
--
ALTER TABLE `jogo_plataforma`
  ADD CONSTRAINT `fk_Jogo_Plataforma_Jogo` FOREIGN KEY (`cod_jogo_fk`) REFERENCES `jogo` (`cod_Jogo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Jogo_Plataforma_Plataforma` FOREIGN KEY (`cod_plataforma_fk`) REFERENCES `plataforma` (`cod_Plataforma`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para tabelas `postagem`
--
ALTER TABLE `postagem`
  ADD CONSTRAINT `fk_Postagem_Jogo` FOREIGN KEY (`cod_jogo_fk`) REFERENCES `jogo` (`cod_Jogo`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_Postagem_Usuario` FOREIGN KEY (`cod_usuario_fk`) REFERENCES `usuario` (`cod_usuario`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
