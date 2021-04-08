# Pequeno exemplo Flask Bootstrap e MySQL

O arquivo [banco-dump.sql](banco-dump.sql) tem as instruções DDL e DML para criar o banco. A modelagem feita com o MySQL Workbench está disponível no arquivo [modelagem.mwb](modelagem.mwb).

![diagrama ER](modelagem.png)

## Para executar a aplicação

As configurações de acesso ao banco MySQL devem ser ajustadas no arquivo [app.py](app.py), precisamente na linha representada abaixo:

```python
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://aluno:1234@localhost:3306/appwebflask'
```

O ideal é fazer uso do Python Virtualenv, mas seria possível executar a aplicação sem ele. Basta instalar os pacotes que estão no arquivo [requirements.txt](requirements.txt).

```bash
python3 -m venv venv
source venv/bin/activate

# para instalar os pacotes. Só é necessário fazer isso uma única vez
pip install -r requirements.txt

# para executar a aplicação
python3 app.py
```

## Para acessar a aplicação

No navegador web entre com o endereço `http://localhost:5000`. O banco conta com dois usuários para teste:

| Usuário | Senha |
| ------- | -----|
| juca    | 1234 |
| maria   | 1234 |