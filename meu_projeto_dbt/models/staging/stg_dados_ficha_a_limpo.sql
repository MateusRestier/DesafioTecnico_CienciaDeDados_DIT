WITH raw_data AS (
    SELECT
        id_paciente,

        -- Normalizando sexo (M/F)
        CASE 
            WHEN LOWER(sexo) = 'male' THEN 'M'
            WHEN LOWER(sexo) = 'female' THEN 'F'
            ELSE NULL
        END AS sexo,

        -- Normalizando obito (0 ou 1)
        CASE 
            WHEN obito IN ('0', 'False', FALSE) THEN 0
            WHEN obito IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS obito,

        -- Normalizando raca_cor
        CASE 
            WHEN LOWER(raca_cor) = 'parda' THEN 'Parda'
            WHEN LOWER(raca_cor) = 'branca' THEN 'Branca'
            WHEN LOWER(raca_cor) = 'preta' THEN 'Preta'
            WHEN LOWER(raca_cor) = 'amarela' THEN 'Amarela'
            WHEN LOWER(raca_cor) = 'indígena' THEN 'Indígena'
            ELSE 'Não Informado'
        END AS raca_cor,

        -- Normalizando religião
        CASE 
            WHEN LOWER(religiao) IN ('sem religião', 'não') THEN 'Sem Religião'
            WHEN LOWER(religiao) = 'católica' THEN 'Católica'
            WHEN LOWER(religiao) = 'outra' THEN 'Outra'
            WHEN LOWER(religiao) = 'evangélica' THEN 'Evangélica'
            WHEN LOWER(religiao) = 'espírita' THEN 'Espírita'
            WHEN LOWER(religiao) = 'religião de matriz africana' THEN 'Matriz Africana'
            WHEN LOWER(religiao) = 'budismo' THEN 'Budismo'
            WHEN LOWER(religiao) = 'judaísmo' THEN 'Judaísmo'
            WHEN LOWER(religiao) = 'islamismo' THEN 'Islamismo'
            WHEN LOWER(religiao) = 'candomblé' THEN 'Candomblé'
            ELSE 'Desconhecido'
        END AS religiao,

        -- Normalizando luz elétrica (0 ou 1)
        CASE 
            WHEN luz_eletrica IN ('0', 'False', FALSE) THEN 0
            WHEN luz_eletrica IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS luz_eletrica,

        -- Normalizando renda familiar
        CASE 
            WHEN LOWER(renda_familiar) LIKE '1 salário%' THEN '1 Salário Mínimo'
            WHEN LOWER(renda_familiar) LIKE '2 salários%' THEN '2 Salários Mínimos'
            WHEN LOWER(renda_familiar) LIKE '3 salários%' THEN '3 Salários Mínimos'
            WHEN LOWER(renda_familiar) LIKE '1/2 salário%' THEN '1/2 Salário Mínimo'
            WHEN LOWER(renda_familiar) LIKE '1/4 salário%' THEN '1/4 Salário Mínimo'
            WHEN LOWER(renda_familiar) LIKE '4 salários%' THEN '4 Salários Mínimos'
            WHEN LOWER(renda_familiar) LIKE 'mais de 4%' THEN 'Mais de 4 Salários Mínimos'
            ELSE 'Não Informado'
        END AS renda_familiar,

        -- Normalizando colunas booleanas (0 ou 1)
        CASE 
            WHEN em_situacao_de_rua IN ('0', 'False', FALSE) THEN 0
            WHEN em_situacao_de_rua IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS em_situacao_de_rua,

        CASE 
            WHEN frequenta_escola IN ('0', 'False', FALSE) THEN 0
            WHEN frequenta_escola IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS frequenta_escola,

        CASE 
            WHEN possui_plano_saude IN ('0', 'False', FALSE) THEN 0
            WHEN possui_plano_saude IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS possui_plano_saude,

        CASE 
            WHEN vulnerabilidade_social IN ('0', 'False', FALSE) THEN 0
            WHEN vulnerabilidade_social IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS vulnerabilidade_social,

        CASE 
            WHEN familia_beneficiaria_auxilio_brasil IN ('0', 'False', FALSE) THEN 0
            WHEN familia_beneficiaria_auxilio_brasil IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS familia_beneficiaria_auxilio_brasil,

        CASE 
            WHEN crianca_matriculada_creche_pre_escola IN ('0', 'False', FALSE) THEN 0
            WHEN crianca_matriculada_creche_pre_escola IN ('1', 'True', TRUE) THEN 1
            ELSE 0
        END AS crianca_matriculada_creche_pre_escola,

        -- Normalizando identidade de gênero
        CASE 
            WHEN LOWER(identidade_genero) IN ('não', 'sim') THEN 'Não Informado'
            WHEN LOWER(identidade_genero) = 'cis' THEN 'Cisgênero'
            WHEN LOWER(identidade_genero) = 'mulher transexual' THEN 'Mulher Transexual'
            WHEN LOWER(identidade_genero) = 'homem transexual' THEN 'Homem Transexual'
            WHEN LOWER(identidade_genero) = 'travesti' THEN 'Travesti'
            WHEN LOWER(identidade_genero) = 'bissexual' THEN 'Bissexual'
            WHEN LOWER(identidade_genero) = 'homossexual (gay / lésbica)' THEN 'Homossexual'
            ELSE 'Outro'
        END AS identidade_genero,

        -- Normalizando orientacao_sexual
        CASE 
            WHEN LOWER(orientacao_sexual) = 'heterossexual' THEN 'Heterossexual'
            WHEN LOWER(orientacao_sexual) = 'homossexual (gay / lésbica)' THEN 'Homossexual'
            WHEN LOWER(orientacao_sexual) = 'bissexual' THEN 'Bissexual'
            ELSE 'Outro'
        END AS orientacao_sexual,

        -- Normalizando situacao_profissional
        CASE 
            WHEN LOWER(situacao_profissional) = 'emprego formal' THEN 'Emprego Formal'
            WHEN LOWER(situacao_profissional) = 'não se aplica' THEN 'Não se aplica'
            WHEN LOWER(situacao_profissional) = 'desempregado' THEN 'Desempregado'
            WHEN LOWER(situacao_profissional) = 'emprego informal' THEN 'Emprego Informal'
            WHEN LOWER(situacao_profissional) = 'pensionista / aposentado' THEN 'Pensionista / Aposentado'
            WHEN LOWER(situacao_profissional) = 'autônomo' THEN 'Autônomo'
            WHEN LOWER(situacao_profissional) = 'não trabalha' THEN 'Não trabalha'
            WHEN LOWER(situacao_profissional) = 'empregador' THEN 'Empregador'
            WHEN LOWER(situacao_profissional) = 'autônomo sem previdência social' THEN 'Autônomo sem previdência social'
            WHEN LOWER(situacao_profissional) = 'autônomo com previdência social' THEN 'Autônomo com previdência social'
            WHEN LOWER(situacao_profissional) = 'sms caps dircinha e linda batista ap 33' THEN 'SMS CAPS DIRCINHA E LINDA BATISTA AP 33'
            WHEN LOWER(situacao_profissional) = 'médico urologista' THEN 'Médico Urologista'
            ELSE 'Outro'
        END AS situacao_profissional,

        -- Tratamento de colunas com listas (removendo colchetes, aspas e caracteres Unicode)
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    meios_transporte, '[', ''), ']', ''), '"', ''), '/', ''), '\\', ''),
                    '\u00e3', 'ã'), '\u00e1', 'á'), '\u00e9', 'é'),
                    '\u00ed', 'í'), '\u00f3', 'ó'), '\u00fa', 'ú'),
                    '\u00e7', 'ç'), '\u00ea', 'ê'), '\u00f4', 'ô'),
                    '\u00f5', 'õ'), '\u00e2', 'â') AS meios_transporte,

        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    doencas_condicoes, '[', ''), ']', ''), '"', ''), '/', ''), '\\', ''),
                    '\u00e3', 'ã'), '\u00e1', 'á'), '\u00e9', 'é'),
                    '\u00ed', 'í'), '\u00f3', 'ó'), '\u00fa', 'ú'),
                    '\u00e7', 'ç'), '\u00ea', 'ê'), '\u00f4', 'ô'),
                    '\u00f5', 'õ'), '\u00e2', 'â') AS doencas_condicoes,

        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    meios_comunicacao, '[', ''), ']', ''), '"', ''), '/', ''), '\\', ''),
                    '\u00e3', 'ã'), '\u00e1', 'á'), '\u00e9', 'é'),
                    '\u00ed', 'í'), '\u00f3', 'ó'), '\u00fa', 'ú'),
                    '\u00e7', 'ç'), '\u00ea', 'ê'), '\u00f4', 'ô'),
                    '\u00f5', 'õ'), '\u00e2', 'â') AS meios_comunicacao,

        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    em_caso_doenca_procura, '[', ''), ']', ''), '"', ''), '/', ''), '\\', ''),
                    '\u00e3', 'ã'), '\u00e1', 'á'), '\u00e9', 'é'),
                    '\u00ed', 'í'), '\u00f3', 'ó'), '\u00fa', 'ú'),
                    '\u00e7', 'ç'), '\u00ea', 'ê'), '\u00f4', 'ô'),
                    '\u00f5', 'õ'), '\u00e2', 'â') AS em_caso_doenca_procura,

        -- Convertendo datas para o formato correto
        STR_TO_DATE(data_cadastro, '%Y-%m-%d') AS data_cadastro,
        STR_TO_DATE(data_nascimento, '%Y-%m-%d') AS data_nascimento,
        STR_TO_DATE(updated_at, '%Y-%m-%d') AS updated_at,
        STR_TO_DATE(data_atualizacao_cadastro, '%Y-%m-%d') AS data_atualizacao_cadastro,

        -- Mantendo todas as outras colunas
        bairro,
        ocupacao,
        escolaridade,
        nacionalidade,
        altura,
        peso,
        pressao_sistolica,
        pressao_diastolica,
        n_atendimentos_atencao_primaria,
        n_atendimentos_hospital,
        tipo

    FROM {{ source('dados', 'dados_ficha_a_desafio') }}
)

SELECT * FROM raw_data
