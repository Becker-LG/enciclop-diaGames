# Seção 1: Importações
# ---------------------
from flask import Flask, render_template, request, redirect, url_for, session, flash
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector

# Seção 2: Configuração Inicial
# ------------------------------
app = Flask(__name__)
app.secret_key = '17f5fe9813722ae4f396dc93f56b3125c7797b18e2af49a5c912de405956a009'

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'eg',
    'port': '3306'
}

# Seção 3: Rotas da Aplicação
# ---------------------------

# Rota de Cadastro
@app.route('/cadastro', methods=['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        nome = request.form['nome']
        username = request.form['username']
        email = request.form['email']
        senha = generate_password_hash(request.form['senha'])
        
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM usuario WHERE username_usuario = %s OR email_usuario = %s", (username, email))
        if cursor.fetchone():
            flash("Nome de usuário ou email já cadastrado.", "erro")
            return redirect(url_for('cadastro'))

        cursor.execute("""INSERT INTO usuario (nome_usuario, username_usuario, password_usuario, email_usuario, conta_ativa)
                          VALUES (%s, %s, %s, %s, %s)""", (nome, username, senha, email, True))
        
        conn.commit()
        cursor.close()
        conn.close()

        flash("Cadastro realizado com sucesso! Você já pode fazer login.", "sucesso")
        return redirect(url_for('login'))
    
    return render_template('cadastro.html')

# Rota de Login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username'].strip()
        senha = request.form['senha'].strip()

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM usuario WHERE username_usuario = %s", (username,))
        usuario = cursor.fetchone()
        cursor.close()
        conn.close()

        if usuario and check_password_hash(usuario['password_usuario'], senha):
            if not usuario['conta_ativa']:
                flash("Esta conta está desativada.", "erro")
                return redirect(url_for('login'))
            
            session['usuario_id'] = usuario['cod_usuario']
            session['usuario_nome'] = usuario['nome_usuario']
            return redirect(url_for('dashboard'))
        else:
            flash("Usuário ou senha inválidos.", "erro")
            return redirect(url_for('login'))

    return render_template('login.html')

# Rota do Painel Principal (Dashboard) - VERSÃO CORRIGIDA
@app.route('/dashboard')
def dashboard():
    # 1. Verifica se a chave 'usuario_id' existe na sessão.
    #    Esta é a forma mais segura de saber se o login foi feito com sucesso.
    if 'usuario_id' not in session:
        # Se não estiver logado, envia uma mensagem e redireciona para a tela de login.
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))
    
    # 2. Se o usuário estiver logado, simplesmente renderize o template do dashboard.
    #    O template 'dashboard.html' (que estende o 'base.html') vai acessar
    #    automaticamente a variável {{ session['usuario_nome'] }} e exibi-la.
    return render_template('dashboard.html')

# Rota de Logout
@app.route('/logout')
def logout():
    session.pop('usuario_id', None)
    session.pop('usuario_nome', None)
    flash("Você saiu da sua conta.", "sucesso")
    return redirect(url_for('login'))

# Rota Principal (Raiz do site)
@app.route('/')
def index():
    return redirect(url_for('login'))

# Rota para verificar se usuário ou email já existem
@app.route('/verificar_usuario_email', methods=['POST'])
def verificar_usuario_email():
    username = request.form['username']
    email = request.form['email']

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM usuario WHERE username_usuario = %s OR email_usuario = %s", (username, email))
    existe = cursor.fetchone()
    cursor.close()
    conn.close()

    return 'existe' if existe else 'disponivel'

# ------------------------------------------------------------------------------------------------------------------------------------------------------
# Rotas de Gerenciamento de Desenvolvedores
# ------------------------------------------------------------------------------------------------------------------------------------------------------

@app.route('/desenvolvedores')
def desenvolvedores():
    # Proteção de rota
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Lógica de pesquisa
    query = request.args.get('q')
    if query:
        search_query = "%" + query + "%"
        cursor.execute("SELECT * FROM Desenvolvedor WHERE nome_Desenvolvedor LIKE %s ORDER BY nome_Desenvolvedor ASC", (search_query,))
    else:
        cursor.execute("SELECT * FROM Desenvolvedor ORDER BY nome_Desenvolvedor ASC")
    
    lista_desenvolvedores = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return render_template('desenvolvedores.html', desenvolvedores=lista_desenvolvedores, query=query)

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Cadastrar um Novo Desenvolvedor
@app.route('/desenvolvedores/cadastrar', methods=['GET', 'POST'])
def cadastrar_desenvolvedor():
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    if request.method == 'POST':
        nome = request.form['nome_desenvolvedor'].strip()
        pais = request.form['pais_desenvolvedor'].strip()

        if not nome:
            flash("O nome do desenvolvedor é obrigatório.", "erro")
            return redirect(url_for('cadastrar_desenvolvedor'))

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Verifica se a desenvolvedora já existe
        cursor.execute("SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = %s", (nome,))
        if cursor.fetchone():
            flash("Já existe um desenvolvedor com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_desenvolvedor'))

        # Insere a nova desenvolvedora
        cursor.execute("INSERT INTO Desenvolvedor (nome_Desenvolvedor, pais_Desenvolvedor) VALUES (%s, %s)", (nome, pais))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Desenvolvedor cadastrado com sucesso!", "sucesso")
        return redirect(url_for('desenvolvedores'))

    return render_template('cadastrar_desenvolvedor.html')

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Editar uma Desenvolvedora
@app.route('/desenvolvedores/editar/<int:cod>', methods=['GET', 'POST'])
def editar_desenvolvedor(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        nome = request.form['nome_desenvolvedor'].strip()
        pais = request.form['pais_desenvolvedor'].strip()

        if not nome:
            flash("O nome do desenvolvedor é obrigatório.", "erro")
            return redirect(url_for('editar_desenvolvedor', cod=cod))

        # Verifica se o novo nome já existe em outro registro
        cursor.execute("SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = %s AND cod_Desenvolvedor != %s", (nome, cod))
        if cursor.fetchone():
            flash("Já existe outro desenvolvedor com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('editar_desenvolvedor', cod=cod))
        
        # Atualiza o registro
        cursor.execute("UPDATE Desenvolvedor SET nome_Desenvolvedor = %s, pais_Desenvolvedor = %s WHERE cod_Desenvolvedor = %s", (nome, pais, cod))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Desenvolvedor atualizado com sucesso!", "sucesso")
        return redirect(url_for('desenvolvedores'))

    # GET: Busca a Desenvolvedora atual para preencher o formulário
    cursor.execute("SELECT * FROM Desenvolvedor WHERE cod_Desenvolvedor = %s", (cod,))
    des = cursor.fetchone()
    
    cursor.close()
    conn.close()

    if not des:
        flash("Desenvolvedor não encontrado.", "erro")
        return redirect(url_for('desenvolvedores'))

    return render_template('editar_desenvolvedor.html', des=des)

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Excluir uma Desenvolvedora
@app.route('/desenvolvedores/excluir/<int:cod>', methods=['POST'])
def excluir_desenvolvedor(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    # Exclui o Gênero
    # Nota: A regra ON DELETE SET NULL na tabela Jogo fará com que os jogos
    # desta publicadora tenham seu `cod_publicadora_fk` definido como NULL.
    cursor.execute("DELETE FROM Desenvolvedor WHERE cod_Desenvolvedor = %s", (cod,))
    conn.commit()
    
    cursor.close()
    conn.close()

    flash("Desenvolvedor excluído com sucesso!", "sucesso")
    return redirect(url_for('desenvolvedores'))


# ------------------------------------------------------------------------------------------------------------------------------------------------------
# Rotas de Gerenciamento de Plataforma
# ------------------------------------------------------------------------------------------------------------------------------------------------------

@app.route('/plataformas')
def plataformas():
    # Proteção de rota
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Lógica de pesquisa
    query = request.args.get('q')
    if query:
        search_query = "%" + query + "%"
        cursor.execute("SELECT * FROM Plataforma WHERE nome_Plataforma LIKE %s ORDER BY nome_Plataforma ASC", (search_query,))
    else:
        cursor.execute("SELECT * FROM Plataforma ORDER BY nome_Plataforma ASC")
    
    lista_plataformas = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return render_template('plataformas.html', plataformas=lista_plataformas, query=query)

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Cadastrar uma Nova Plataforma
@app.route('/plataformas/cadastrar', methods=['GET', 'POST'])
def cadastrar_plataforma():
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    if request.method == 'POST':
        nome = request.form['nome_plataforma'].strip()

        if not nome:
            flash("O nome da plataforma é obrigatório.", "erro")
            return redirect(url_for('cadastrar_plataforma'))

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Verifica se o gênero já existe
        cursor.execute("SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = %s", (nome,))
        if cursor.fetchone():
            flash("Já existe uma plataforma com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_plataforma'))

        # Insere a nova publicadora
        cursor.execute("INSERT INTO Plataforma (nome_Plataforma) VALUES (%s)", (nome,))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Plataforma cadastrada com sucesso!", "sucesso")
        return redirect(url_for('plataformas'))

    return render_template('cadastrar_plataforma.html')

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Editar uma Plataforma
@app.route('/plataformas/editar/<int:cod>', methods=['GET', 'POST'])
def editar_plataforma(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        nome = request.form['nome_plataforma'].strip()

        if not nome:
            flash("O nome da plataforma é obrigatório.", "erro")
            return redirect(url_for('editar_plataforma', cod=cod))

        # Verifica se o novo nome já existe em outro registro
        cursor.execute("SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = %s AND cod_Plataforma != %s", (nome, cod))
        if cursor.fetchone():
            flash("Já existe outra plataforma com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('editar_plataforma', cod=cod))
        
        # Atualiza o registro
        cursor.execute("UPDATE Plataforma SET nome_Plataforma = %s WHERE cod_Plataforma = %s", (nome, cod))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Plataforma atualizada com sucesso!", "sucesso")
        return redirect(url_for('plataformas'))

    # GET: Busca o genero atual para preencher o formulário
    cursor.execute("SELECT * FROM Plataforma WHERE cod_Plataforma = %s", (cod,))
    pla = cursor.fetchone()
    
    cursor.close()
    conn.close()

    if not pla:
        flash("Plataforma não encontrada.", "erro")
        return redirect(url_for('plataformas'))

    return render_template('editar_plataforma.html', pla=pla)

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Excluir uma Plataforma
@app.route('/plataformas/excluir/<int:cod>', methods=['POST'])
def excluir_plataforma(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    # Exclui o Gênero
    # Nota: A regra ON DELETE SET NULL na tabela Jogo fará com que os jogos
    # desta publicadora tenham seu `cod_publicadora_fk` definido como NULL.
    cursor.execute("DELETE FROM Plataforma WHERE cod_Plataforma = %s", (cod,))
    conn.commit()
    
    cursor.close()
    conn.close()

    flash("Plataforma excluída com sucesso!", "sucesso")
    return redirect(url_for('plataformas'))

# ------------------------------------------------------------------------------------------------------------------------------------------------------
# Rotas de Gerenciamento de Gênero
# ------------------------------------------------------------------------------------------------------------------------------------------------------

@app.route('/generos')
def generos():
    # Proteção de rota
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Lógica de pesquisa
    query = request.args.get('q')
    if query:
        search_query = "%" + query + "%"
        cursor.execute("SELECT * FROM Genero WHERE nome_Genero LIKE %s ORDER BY nome_Genero ASC", (search_query,))
    else:
        cursor.execute("SELECT * FROM Genero ORDER BY nome_Genero ASC")
    
    lista_generos = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return render_template('generos.html', generos=lista_generos, query=query)

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Cadastrar um Novo Gênero
@app.route('/generos/cadastrar', methods=['GET', 'POST'])
def cadastrar_genero():
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    if request.method == 'POST':
        nome = request.form['nome_genero'].strip()

        if not nome:
            flash("O nome do gênero é obrigatório.", "erro")
            return redirect(url_for('cadastrar_genero'))

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Verifica se o gênero já existe
        cursor.execute("SELECT cod_Genero FROM Genero WHERE nome_Genero = %s", (nome,))
        if cursor.fetchone():
            flash("Já existe um gênero com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_genero'))

        # Insere a nova publicadora
        cursor.execute("INSERT INTO Genero (nome_Genero) VALUES (%s)", (nome,))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Gênero cadastrado com sucesso!", "sucesso")
        return redirect(url_for('generos'))

    return render_template('cadastrar_genero.html')

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Editar um Gênero
@app.route('/generos/editar/<int:cod>', methods=['GET', 'POST'])
def editar_genero(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        nome = request.form['nome_genero'].strip()

        if not nome:
            flash("O nome do gênero é obrigatório.", "erro")
            return redirect(url_for('editar_genero', cod=cod))

        # Verifica se o novo nome já existe em outro registro
        cursor.execute("SELECT cod_Genero FROM Genero WHERE nome_Genero = %s AND cod_Genero != %s", (nome, cod))
        if cursor.fetchone():
            flash("Já existe outro gênero com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('editar_genero', cod=cod))
        
        # Atualiza o registro
        cursor.execute("UPDATE Genero SET nome_Genero = %s WHERE cod_Genero = %s", (nome, cod))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Genero atualizado com sucesso!", "sucesso")
        return redirect(url_for('generos'))

    # GET: Busca o genero atual para preencher o formulário
    cursor.execute("SELECT * FROM Genero WHERE cod_Genero = %s", (cod,))
    gen = cursor.fetchone()
    
    cursor.close()
    conn.close()

    if not gen:
        flash("Gênero não encontrado.", "erro")
        return redirect(url_for('generos'))

    return render_template('editar_genero.html', gen=gen)

#------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Excluir um Gênero
@app.route('/generos/excluir/<int:cod>', methods=['POST'])
def excluir_genero(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    # Exclui o Gênero
    # Nota: A regra ON DELETE SET NULL na tabela Jogo fará com que os jogos
    # desta publicadora tenham seu `cod_publicadora_fk` definido como NULL.
    cursor.execute("DELETE FROM Genero WHERE cod_Genero = %s", (cod,))
    conn.commit()
    
    cursor.close()
    conn.close()

    flash("Gênero excluído com sucesso!", "sucesso")
    return redirect(url_for('generos'))

# ------------------------------------------------------------------------------------------------------------------------------------------------------
# Rotas de Gerenciamento de Publicadoras
# ------------------------------------------------------------------------------------------------------------------------------------------------------

# Rota para Listar e Pesquisar Publicadoras
@app.route('/publicadoras')
def publicadoras():
    # Proteção de rota
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Lógica de pesquisa
    query = request.args.get('q')
    if query:
        search_query = "%" + query + "%"
        cursor.execute("SELECT * FROM Publicadora WHERE nome_Publicadora LIKE %s ORDER BY nome_Publicadora ASC", (search_query,))
    else:
        cursor.execute("SELECT * FROM Publicadora ORDER BY nome_Publicadora ASC")
    
    lista_publicadoras = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return render_template('publicadoras.html', publicadoras=lista_publicadoras, query=query)

# Rota para Cadastrar uma Nova Publicadora
@app.route('/publicadoras/cadastrar', methods=['GET', 'POST'])
def cadastrar_publicadora():
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    if request.method == 'POST':
        nome = request.form['nome_publicadora'].strip()
        pais = request.form['pais_publicadora'].strip()

        if not nome:
            flash("O nome da publicadora é obrigatório.", "erro")
            return redirect(url_for('cadastrar_publicadora'))

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Verifica se a publicadora já existe
        cursor.execute("SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = %s", (nome,))
        if cursor.fetchone():
            flash("Já existe uma publicadora com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_publicadora'))

        # Insere a nova publicadora
        cursor.execute("INSERT INTO Publicadora (nome_Publicadora, pais_Publicadora) VALUES (%s, %s)", (nome, pais))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Publicadora cadastrada com sucesso!", "sucesso")
        return redirect(url_for('publicadoras'))

    return render_template('cadastrar_publicadora.html')

# Rota para Editar uma Publicadora
@app.route('/publicadoras/editar/<int:cod>', methods=['GET', 'POST'])
def editar_publicadora(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        nome = request.form['nome_publicadora'].strip()
        pais = request.form['pais_publicadora'].strip()

        if not nome:
            flash("O nome da publicadora é obrigatório.", "erro")
            return redirect(url_for('editar_publicadora', cod=cod))

        # Verifica se o novo nome já existe em outro registro
        cursor.execute("SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = %s AND cod_Publicadora != %s", (nome, cod))
        if cursor.fetchone():
            flash("Já existe outra publicadora com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('editar_publicadora', cod=cod))
        
        # Atualiza o registro
        cursor.execute("UPDATE Publicadora SET nome_Publicadora = %s, pais_Publicadora = %s WHERE cod_Publicadora = %s", (nome, pais, cod))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Publicadora atualizada com sucesso!", "sucesso")
        return redirect(url_for('publicadoras'))

    # GET: Busca a publicadora atual para preencher o formulário
    cursor.execute("SELECT * FROM Publicadora WHERE cod_Publicadora = %s", (cod,))
    pub = cursor.fetchone()
    
    cursor.close()
    conn.close()

    if not pub:
        flash("Publicadora não encontrada.", "erro")
        return redirect(url_for('publicadoras'))

    return render_template('editar_publicadora.html', pub=pub)

# Rota para Excluir uma Publicadora
@app.route('/publicadoras/excluir/<int:cod>', methods=['POST'])
def excluir_publicadora(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    # Exclui a publicadora
    # Nota: A regra ON DELETE SET NULL na tabela Jogo fará com que os jogos
    # desta publicadora tenham seu `cod_publicadora_fk` definido como NULL.
    cursor.execute("DELETE FROM Publicadora WHERE cod_Publicadora = %s", (cod,))
    conn.commit()
    
    cursor.close()
    conn.close()

    flash("Publicadora excluída com sucesso!", "sucesso")
    return redirect(url_for('publicadoras'))





# ---------------------------------------------------------------------------------------------------------------------------------
# Rotas de Gerenciamento de Jogos
# ---------------------------------------------------------------------------------------------------------------------------------

# Rota para Listar Jogos em formato de Card
@app.route('/jogos')
def jogos():
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Query complexa para buscar jogos e agrupar plataformas e gêneros
    # Usamos LEFT JOIN para garantir que jogos sem dev/pub ainda apareçam
    # Usamos GROUP_CONCAT para juntar múltiplos gêneros/plataformas em uma única string
    base_query = """
        SELECT 
            j.cod_Jogo,
            j.titulo_Jogo,
            j.url_imagem_capa_Jogo,
            YEAR(j.data_lancamento_Jogo) AS ano_lancamento,
            d.nome_Desenvolvedor,
            GROUP_CONCAT(DISTINCT p.nome_Plataforma ORDER BY p.nome_Plataforma SEPARATOR ', ') AS plataformas,
            GROUP_CONCAT(DISTINCT g.nome_Genero ORDER BY g.nome_Genero SEPARATOR ', ') AS generos
        FROM 
            Jogo j
        LEFT JOIN 
            Desenvolvedor d ON j.cod_desenvolvedor_fk = d.cod_Desenvolvedor
        LEFT JOIN 
            Jogo_Plataforma jp ON j.cod_Jogo = jp.cod_jogo_fk
        LEFT JOIN 
            Plataforma p ON jp.cod_plataforma_fk = p.cod_Plataforma
        LEFT JOIN 
            Jogo_Genero jg ON j.cod_Jogo = jg.cod_jogo_fk
        LEFT JOIN 
            Genero g ON jg.cod_genero_fk = g.cod_Genero
    """

    # Lógica de pesquisa
    query = request.args.get('q')
    if query:
        search_query = "%" + query + "%"
        # Adiciona a cláusula WHERE e GROUP BY para a pesquisa
        cursor.execute(base_query + " WHERE j.titulo_Jogo LIKE %s GROUP BY j.cod_Jogo ORDER BY j.titulo_Jogo ASC", (search_query,))
    else:
        # Adiciona apenas o GROUP BY para a listagem completa
        cursor.execute(base_query + " GROUP BY j.cod_Jogo ORDER BY j.titulo_Jogo ASC")

    lista_jogos = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return render_template('jogos.html', jogos=lista_jogos, query=query)

'''
# Rota para Cadastrar um Novo Jogo
@app.route('/jogos/cadastrar', methods=['GET', 'POST'])
def cadastrar_jogo():
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    if request.method == 'POST':
        nome = request.form['titulo_jogo'].strip()
        desc = request.form['descricao_jogo'].strip()
        data = request.form['data_lancamento_jogo'].strip()
        url = request.form['url_imagem_capa_jogo'].strip()
        nome_des = request.form['nome_desenvolvedor'].strip()
        nome_pub = request.form['nome_publicadora'].strip()
        nome_gen = request.form['nome_genero'].strip()
        nome_pla = request.form['nome_plataforma'].strip()

        if not nome:
            flash("O nome do jogo é obrigatório.", "erro")
            return redirect(url_for('cadastrar_jogo'))

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Verifica se o jogo já existe
        cursor.execute("SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = %s", (nome,))
        if cursor.fetchone():
            flash("Já existe um jogo com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))
        
        # Verifica se desenvolvedora, publicadora, gênero e plataforma existem
        # DESENVOLVEDOR
        cursor.execute("SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = %s", (nome_des,))
        cod_des = cursor.fetchone()[0]
        if cod_des is None:
            flash("Não existe desenvolvedora com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))
        
        # PUBLICADORA
        cursor.execute("SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = %s", (nome_pub,))
        cod_pub = cursor.fetchone()[0]
        if cod_pub is None:
            flash("Não existe publicadora com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))
        
        # GÊNERO
        cursor.execute("SELECT cod_Genero FROM Genero WHERE nome_Genero = %s", (nome_gen,))
        cod_gen = cursor.fetchone()[0]
        if cod_gen is None:
            flash("Não existe gênero com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))

        # PLATAFORMA
        cursor.execute("SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = %s", (nome_pla,))
        cod_pla = cursor.fetchone()[0]
        if cod_pla is None:
            flash("Não existe plataforma com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))

        # Insere o novo jogo
        cursor.execute("INSERT INTO Jogo (titulo_Jogo, descricao_Jogo, data_lancamento_Jogo, url_imagem_capa_Jogo, cod_desenvolvedor_fk, cod_publicadora_fk) VALUES (%s, %s, %s, %s, %s, %s)", (nome, desc, data, url, cod_des, cod_pub))
        conn.commit()
        
        cursor.execute("SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = %s", (nome,))
        cod = int(cursor.fetchone()[0])

        cursor.execute("INSERT INTO jogo_genero (cod_jogo_fk, cod_genero_fk) VALUES (%s, %s)", (cod, cod_gen))
        conn.commit()

        cursor.execute("INSERT INTO jogo_plataforma (cod_jogo_fk, cod_plataforma_fk) VALUES (%s, %s)", (cod, cod_pla))
        conn.commit()
        
        cursor.close()
        conn.close()

        flash("Jogo cadastrado com sucesso!", "sucesso")
        return redirect(url_for('jogos'))

    return render_template('cadastrar_jogo.html')
'''

# Rota para Cadastrar um Novo Jogo
@app.route('/jogos/cadastrar', methods=['GET', 'POST'])
def cadastrar_jogo():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    if request.method == 'POST':
        titulo = request.form['titulo_jogo'].strip()
        descricao = request.form['descricao_jogo'].strip()
        data_lancamento = request.form['data_lancamento_jogo']
        url_imagem = request.form['url_imagem_capa_jogo'].strip()
        cod_dev = request.form['cod_desenvolvedor']
        cod_pub = request.form['cod_publicadora']
        plataformas_selecionadas = request.form.getlist('plataformas')
        generos_selecionados = request.form.getlist('generos')
        cursor.execute("INSERT INTO Jogo (titulo_Jogo, descricao_Jogo, data_lancamento_Jogo, url_imagem_capa_Jogo, cod_desenvolvedor_fk, cod_publicadora_fk) VALUES (%s, %s, %s, %s, %s, %s)", (titulo, descricao, data_lancamento, url_imagem, cod_dev, cod_pub))
        cod_novo_jogo = cursor.lastrowid
        for cod_plat in plataformas_selecionadas:
            cursor.execute("INSERT INTO Jogo_Plataforma (cod_jogo_fk, cod_plataforma_fk) VALUES (%s, %s)", (cod_novo_jogo, cod_plat))
        for cod_gen in generos_selecionados:
            cursor.execute("INSERT INTO Jogo_Genero (cod_jogo_fk, cod_genero_fk) VALUES (%s, %s)", (cod_novo_jogo, cod_gen))
        conn.commit()
        cursor.close()
        conn.close()
        flash("Jogo cadastrado com sucesso!", "sucesso")
        return redirect(url_for('jogos'))
    cursor.execute("SELECT * FROM Desenvolvedor ORDER BY nome_Desenvolvedor")
    desenvolvedores = cursor.fetchall()
    cursor.execute("SELECT * FROM Publicadora ORDER BY nome_Publicadora")
    publicadoras = cursor.fetchall()
    cursor.execute("SELECT * FROM Plataforma ORDER BY nome_Plataforma")
    plataformas = cursor.fetchall()
    cursor.execute("SELECT * FROM Genero ORDER BY nome_Genero")
    generos = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('cadastrar_jogo.html', desenvolvedores=desenvolvedores, publicadoras=publicadoras, plataformas=plataformas, generos=generos)

'''    
# Rota para Editar um Jogo
@app.route('/jogos/editar/<int:cod>', methods=['GET', 'POST'])
def editar_jogo(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        nome = request.form['titulo_jogo'].strip()
        desc = request.form['descricao_jogo'].strip()
        data = request.form['data_lancamento_jogo'].strip()
        url = request.form['url_imagem_capa_jogo'].strip()
        nome_des = request.form['nome_desenvolvedor'].strip()
        nome_pub = request.form['nome_publicadora'].strip()
        nome_gen = request.form['nome_genero'].strip()
        nome_pla = request.form['nome_plataforma'].strip()

        if not nome:
            flash("O nome do jogo é obrigatório.", "erro")
            return redirect(url_for('editar_jogo', cod=cod))

        # Verifica se o novo nome já existe em outro registro
        cursor.execute("SELECT cod_Jogo FROM Jogo WHERE titulo_Jogo = %s AND cod_Jogo != %s", (nome, cod))
        if cursor.fetchone():
            flash("Já existe outro jogo com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('editar_jogo', cod=cod))
        
        # Verifica se desenvolvedora e publicadora existem
        # DESENVOLVEDOR
        cursor.execute("SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = %s", (nome_des,))
        cod_des = cursor.fetchone()[0]
        if cod_des is None:
            flash("Não existe desenvolvedora com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))
        
        # PUBLICADORA
        cursor.execute("SELECT cod_Publicadora FROM Publicadora WHERE nome_Publicadora = %s", (nome_pub,))
        cod_pub = cursor.fetchone()[0]
        if cod_pub is None:
            flash("Não existe publicadora com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))
        
        # GÊNERO
        cursor.execute("SELECT cod_Genero FROM Genero WHERE nome_Genero = %s", (nome_gen,))
        cod_gen = cursor.fetchone()[0]
        if cod_gen is None:
            flash("Não existe gênero com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))

        # PLATAFORMA
        cursor.execute("SELECT cod_Plataforma FROM Plataforma WHERE nome_Plataforma = %s", (nome_pla,))
        cod_pla = cursor.fetchone()[0]
        if cod_pla is None:
            flash("Não existe plataforma com este nome.", "erro")
            cursor.close()
            conn.close()
            return redirect(url_for('cadastrar_jogo'))
        
        # Atualiza o registro
        cursor.execute("UPDATE Jogo SET titulo_Jogo = %s, descricao_Jogo = %s, data_lancamento_Jogo = %s, url_imagem_capa_Jogo = %s, cod_desenvolvedor_fk = %s, cod_publicadora_fk = %s WHERE cod_Jogo = %s", (nome, desc, data, url, cod_des, cod_pub, cod))
        conn.commit()
        
        cursor.execute("UPDATE jogo_genero SET cod_jogo_fk = %s, cod_genero_fk = %s WHERE cod_Jogo = %s", (cod, cod_gen, cod))
        conn.commit()

        cursor.execute("UPDATE jogo_plataforma SET cod_jogo_fk = %s, cod_plataforma_fk = %s WHERE cod_Jogo = %s", (cod, cod_pla, cod))
        conn.commit()

        cursor.close()
        conn.close()

        flash("Jogo atualizada com sucesso!", "sucesso")
        return redirect(url_for('jogos'))

    # GET: Busca o jogo atual para preencher o formulário
    cursor.execute("SELECT * FROM Jogo WHERE cod_Jogo = %s", (cod,))
    jog = cursor.fetchone()
    
    cursor.close()
    conn.close()

    if not jog:
        flash("Jogo não encontrado.", "erro")
        return redirect(url_for('jogos'))

    return render_template('editar_jogo.html', jog=jog)
'''

@app.route('/jogos/editar/<int:cod>', methods=['GET', 'POST'])
def editar_jogo(cod):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    if request.method == 'POST':
        titulo = request.form['titulo_jogo'].strip()
        descricao = request.form['descricao_jogo'].strip()
        data_lancamento = request.form['data_lancamento_jogo']
        url_imagem = request.form['url_imagem_capa_jogo'].strip()
        cod_dev = request.form['cod_desenvolvedor']
        cod_pub = request.form['cod_publicadora']
        plataformas_selecionadas = request.form.getlist('plataformas')
        generos_selecionados = request.form.getlist('generos')
        cursor.execute("UPDATE Jogo SET titulo_Jogo = %s, descricao_Jogo = %s, data_lancamento_Jogo = %s, url_imagem_capa_Jogo = %s, cod_desenvolvedor_fk = %s, cod_publicadora_fk = %s WHERE cod_Jogo = %s", (titulo, descricao, data_lancamento, url_imagem, cod_dev, cod_pub, cod))
        cursor.execute("DELETE FROM Jogo_Plataforma WHERE cod_jogo_fk = %s", (cod,))
        for cod_plat in plataformas_selecionadas:
            cursor.execute("INSERT INTO Jogo_Plataforma (cod_jogo_fk, cod_plataforma_fk) VALUES (%s, %s)", (cod, cod_plat))
        cursor.execute("DELETE FROM Jogo_Genero WHERE cod_jogo_fk = %s", (cod,))
        for cod_gen in generos_selecionados:
            cursor.execute("INSERT INTO Jogo_Genero (cod_jogo_fk, cod_genero_fk) VALUES (%s, %s)", (cod, cod_gen))
        conn.commit()
        cursor.close()
        conn.close()
        flash("Jogo atualizado com sucesso!", "sucesso")
        return redirect(url_for('jogos'))
    cursor.execute("SELECT *, DATE_FORMAT(data_lancamento_Jogo, '%%Y-%%m-%%d') as data_formatada FROM Jogo WHERE cod_Jogo = %s", (cod,))
    jogo = cursor.fetchone()
    if not jogo:
        flash("Jogo não encontrado.", "erro")
        cursor.close()
        conn.close()
        return redirect(url_for('jogos'))
    cursor.execute("SELECT * FROM Desenvolvedor ORDER BY nome_Desenvolvedor")
    desenvolvedores = cursor.fetchall()
    cursor.execute("SELECT * FROM Publicadora ORDER BY nome_Publicadora")
    publicadoras = cursor.fetchall()
    cursor.execute("SELECT * FROM Plataforma ORDER BY nome_Plataforma")
    plataformas = cursor.fetchall()
    cursor.execute("SELECT * FROM Genero ORDER BY nome_Genero")
    generos = cursor.fetchall()
    cursor.execute("SELECT cod_plataforma_fk FROM Jogo_Plataforma WHERE cod_jogo_fk = %s", (cod,))
    plataformas_atuais = [item['cod_plataforma_fk'] for item in cursor.fetchall()]
    cursor.execute("SELECT cod_genero_fk FROM Jogo_Genero WHERE cod_jogo_fk = %s", (cod,))
    generos_atuais = [item['cod_genero_fk'] for item in cursor.fetchall()]
    cursor.close()
    conn.close()
    return render_template('editar_jogo.html', jogo=jogo, desenvolvedores=desenvolvedores, publicadoras=publicadoras, plataformas=plataformas, generos=generos, plataformas_atuais=plataformas_atuais, generos_atuais=generos_atuais)

# Rota para Excluir um Jogo
@app.route('/jogos/excluir/<int:cod>', methods=['POST'])
def excluir_jogo(cod):
    if 'usuario_id' not in session:
        flash("Você precisa fazer login para acessar esta página.", "erro")
        return redirect(url_for('login'))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    # Exclui o Jogo
    # Nota: A regra ON DELETE SET NULL na tabela Jogo fará com que os jogos
    # desta publicadora tenham seu `cod_publicadora_fk` definido como NULL.
    cursor.execute("DELETE FROM Jogo WHERE cod_Jogo = %s", (cod,))
    conn.commit()
    
    cursor.close()
    conn.close()

    flash("Jogo excluída com sucesso!", "sucesso")
    return redirect(url_for('jogos'))


# Executa o app
if __name__ == '__main__':
    app.run(debug=True)
