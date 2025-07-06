# 1. Imagem Base
# Usamos uma imagem slim do Python que é otimizada em tamanho, mas ainda inclui
# as ferramentas necessárias para compilar dependências. A versão 3.11 é estável e recomendada.
FROM python:3.11-slim-bullseye

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner. Todos os comandos subsequentes
# serão executados a partir deste diretório.
WORKDIR /app

# 3. Copiar e Instalar Dependências
# Copiamos o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar o Código da Aplicação
COPY . .

# 5. Expor a Porta
# Informa ao Docker que o contêiner escutará na porta 8000 em tempo de execução.
EXPOSE 8000

# 6. Comando de Execução
# Define o comando para iniciar a aplicação com Uvicorn.
# --host 0.0.0.0 é essencial para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]