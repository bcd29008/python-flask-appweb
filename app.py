from flask import Flask, flash, redirect, url_for, request, session, render_template, jsonify
from flask_bootstrap import Bootstrap
from flask_nav import Nav
from flask_nav.elements import Navbar, View, Subgroup
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.ext.automap import automap_base
from datetime import datetime, timedelta, date

# https://fontawesome.com/icons
from flask_fontawesome import FontAwesome

# Salvando senhas de maneira apropriada no banco de dados.
# https://werkzeug.palletsprojects.com/en/1.0.x/utils/#module-werkzeug.security
from werkzeug.security import generate_password_hash, check_password_hash
# Para gerar a senha a ser salva no DB, faça:
# Abra um shell com o interpretador python e faça o import da linha acima
# Execute a linha abaixo:
# senha = generate_password_hash('1234')

from forms.login import LoginForm
from forms.contato import ContatoForm

app = Flask(__name__)
app.secret_key = "SECRET_KEY"

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://aluno:1234@localhost:3306/appwebflask'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False

db = SQLAlchemy(app)

Base = automap_base()
Base.prepare(db.engine, reflect=True)
Usuario = Base.classes.Usuario
Contato = Base.classes.Contato
Telefone = Base.classes.Telefone

boostrap = Bootstrap(app)
fa = FontAwesome(app)

nav = Nav()
nav.init_app(app)

@nav.navigation()
def meunavbar():
    menu = Navbar('Minha aplicação')
    menu.items = [View('Inicial', 'inicio'), ]
    menu.items.append(Subgroup('Contatos', View('Cadastrar', 'cadastrar_contato'), View('Listar', 'listar_contato')))
    menu.items.append(Subgroup('Grupos', View('Cadastrar', 'inicio'), View('Listar', 'inicio')))
    menu.items.append(View('Sair', 'logout'))
    return menu


@app.route('/login', methods=['GET', 'POST'])
def autenticar():
    if session.get('logged_in'):
        return redirect(url_for('inicio'))
    form = LoginForm()
    if form.validate_on_submit():
        usuario = db.session.query(Usuario).filter(Usuario.username == form.username.data).first()
        if usuario:
            if check_password_hash(usuario.password, form.password.data):
                session['logged_in'] = True
                session['nome'] = usuario.nome
                session['idUsuario'] = usuario.idUsuario
                return redirect(url_for('inicio'))
        flash('Usuário ou senha inválidos')
        return redirect(url_for('autenticar'))
    return render_template('login.html', title='Autenticação de usuários', form=form)


@app.route('/')
def inicio():
    if not session.get('logged_in'):
        return redirect(url_for('autenticar'))
    else:
        return render_template('index.html', title='Inicial', usuario=session.get('nome'))


@app.route("/logout")
def logout():
    '''
    Para encerrar a sessão autenticada de um usuário
    :return: redireciona para a página inicial
    '''
    session.clear()
    return redirect(url_for('inicio'))


@app.errorhandler(404)
def page_not_found(e):
    '''
    Para tratar erros de páginas não encontradas - HTTP 404
    :param e:
    :return:
    '''
    return render_template('404.html'), 404


@app.route('/contatos')
def listar_contato():
    if session.get('logged_in'):
        form = ContatoForm()
        id_usuario = session.get('idUsuario')
        contatos = db.session.query(Contato).filter(Contato.idUsuario == id_usuario).all()

        return render_template('contato_listar.html', contatos=contatos, form=form)
    return redirect(url_for('autenticar'))


@app.route('/contatos/cadastrar', methods=['GET', 'POST'])
def cadastrar_contato():
    if session.get('logged_in'):
        form = ContatoForm()
        if form.validate_on_submit():
            nome = request.form['nome']
            dataNasc = request.form['dataNasc']
            return redirect(url_for('autenticar'))
    return render_template('contato_cadastrar.html', title='Cadastrar contato', form=form)


@app.route('/contato', methods=['POST'])
def dados_contato():
    if session.get('logged_in'):
        id_usuario = session.get('idUsuario')
        id_contato = int(request.form['id'])

        # https://docs.sqlalchemy.org/en/14/orm/tutorial.html#common-filter-operators
        contato = db.session.query(Contato).filter(Contato.idUsuario == id_usuario,
                                                   Contato.idContato == id_contato).first()

        contado_dict = dict()

        contado_dict['id'] = contato.idContato
        contado_dict['nome'] = contato.nome
        contado_dict['dataNasc'] = contato.dataNasc.strftime('%d/%m/%Y')

        return jsonify(contado_dict)

    return redirect(url_for('autenticar'))

@app.route('/atualizarcontato', methods=['POST'])
def atualizar_contato():
    if session.get('logged_in'):
        id_usuario = session.get('idUsuario')
        id_contato = request.form['idContato']
        nome = request.form['nome']
        dataNasc = request.form['dataNasc']

        contato = db.session.query(Contato).filter(Contato.idUsuario == id_usuario,
                                                   Contato.idContato == id_contato).first()

        contato.nome = nome
        abc = datetime.strptime(dataNasc, '%d/%m/%Y').date()
        contato.dataNasc = abc.strftime('%Y-%m-%d')

        db.session.commit()

        return redirect(url_for('autenticar'))

    return redirect(url_for('autenticar'))


if __name__ == '__main__':
    app.run(debug=True)
