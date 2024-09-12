# Use a imagem oficial do Ruby
FROM ruby:3.3.1

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Definir o diretório de trabalho
WORKDIR /app

# Copiar Gemfile e Gemfile.lock para o container
COPY Gemfile* ./

# Instalar as gems
RUN bundle install

# Copiar o restante do código da aplicação
COPY . .

# Comando padrão para iniciar o servidor Puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
