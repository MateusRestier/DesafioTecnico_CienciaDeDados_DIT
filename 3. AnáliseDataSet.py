import pandas as pd
from datetime import datetime
import os

base_path = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_path, "Arquivos base", "dados_ficha_a_desafio.csv")

df = pd.read_csv(file_path, encoding="utf-8")

print("📌 Primeiras linhas do dataset:")
print(df.head())

print("\n📌 Informações gerais do dataset:")
print(df.info())

print("\n📌 Estatísticas básicas do dataset:")
print(df.describe(include="all"))

print("\n📌 Contagem de valores nulos por coluna:")
print(df.isnull().sum())

print("\n📌 Contagem de valores únicos por coluna:")
print(df.nunique())

colunas_categoricas = ['raca_cor', 'sexo', 'religiao', 'ocupacao', 'bairro', 'orientacao_sexual', 'situacao_profissional'] 
for coluna in colunas_categoricas:
    print(f"\n📌 Valores únicos na coluna {coluna}:")
    print(df[coluna].value_counts(dropna=False))

df['data_nascimento'] = pd.to_datetime(df['data_nascimento'], errors='coerce')
df['idade'] = df['data_nascimento'].apply(lambda x: datetime.now().year - x.year if pd.notnull(x) else None)

print("\n📌 Primeiras linhas do dataset com a coluna de idade:")
print(df.head())
