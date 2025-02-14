import pandas as pd
import mysql.connector
import os

conn = mysql.connector.connect(
    host="localhost",
    user="mateusr",
    password="1234",
    database="dados"
)
cursor = conn.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS dados_ficha_a_desafio (
    id_paciente VARCHAR(50),
    sexo VARCHAR(20),
    obito VARCHAR(10),
    bairro VARCHAR(100),
    raca_cor VARCHAR(50),
    ocupacao VARCHAR(255),
    religiao VARCHAR(100),
    luz_eletrica VARCHAR(10),
    data_cadastro VARCHAR(50),
    escolaridade VARCHAR(100),
    nacionalidade VARCHAR(50),
    renda_familiar VARCHAR(50),
    data_nascimento VARCHAR(50),
    em_situacao_de_rua VARCHAR(10),
    frequenta_escola VARCHAR(10),
    meios_transporte TEXT,
    doencas_condicoes TEXT,
    identidade_genero VARCHAR(50),
    meios_comunicacao TEXT,
    orientacao_sexual VARCHAR(50),
    possui_plano_saude VARCHAR(10),
    em_caso_doenca_procura TEXT,
    situacao_profissional VARCHAR(255),
    vulnerabilidade_social TEXT,
    data_atualizacao_cadastro VARCHAR(50),
    familia_beneficiaria_auxilio_brasil VARCHAR(10),
    crianca_matriculada_creche_pre_escola VARCHAR(10),
    altura VARCHAR(20),
    peso VARCHAR(20),
    pressao_sistolica VARCHAR(20),
    pressao_diastolica VARCHAR(20),
    n_atendimentos_atencao_primaria VARCHAR(20),
    n_atendimentos_hospital VARCHAR(20),
    updated_at VARCHAR(50),
    tipo VARCHAR(50)
);
"""
cursor.execute(create_table_query)
conn.commit()

# Caminho do arquivo CSV
base_path = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_path, "Arquivos base", "dados_ficha_a_desafio.csv")

df = pd.read_csv(file_path, encoding="utf-8", dtype=str)  # Carregar tudo como string

# Substituir NaN por None (compatível com MySQL)
df = df.where(pd.notna(df), None)

# Query de inserção
insert_query = """
INSERT INTO dados_ficha_a_desafio (
    id_paciente, sexo, obito, bairro, raca_cor, ocupacao, religiao, luz_eletrica, 
    data_cadastro, escolaridade, nacionalidade, renda_familiar, data_nascimento, 
    em_situacao_de_rua, frequenta_escola, meios_transporte, doencas_condicoes, 
    identidade_genero, meios_comunicacao, orientacao_sexual, possui_plano_saude, 
    em_caso_doenca_procura, situacao_profissional, vulnerabilidade_social, 
    data_atualizacao_cadastro, familia_beneficiaria_auxilio_brasil, 
    crianca_matriculada_creche_pre_escola, altura, peso, pressao_sistolica, 
    pressao_diastolica, n_atendimentos_atencao_primaria, n_atendimentos_hospital, 
    updated_at, tipo
) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 
          %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

# Converter dataframe para lista de tuplas e inserir no banco
data_tuples = [tuple(row) for row in df.to_numpy()]

# Inserir os dados na tabela
cursor.executemany(insert_query, data_tuples)
conn.commit()

# Fechar conexão
cursor.close()
conn.close()

print("✅ Dados importados com sucesso!")
