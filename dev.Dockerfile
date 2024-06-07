# Cria uma imagem a partir da imagem oficial do Ruby 3.2.2
FROM registry.docker.com/library/ruby:3.2.2-slim

# Atualiza o instalador de pacotes do Linux e instala as dependências necessárias
RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y build-essential git libvips pkg-config curl libsqlite3-0

# Instala a versão 2.5.11 do Bundler
RUN gem install bundler -v 2.5.11

# Cria um diretório na imagem onde vão viver os arquidos da aplicação Rails
WORKDIR /delivery_admin

# Copia todos os arquivos (atuais) da aplicação para a imagem
COPY . /delivery_admin

# Instala as dependências da aplicação
RUN bundle install

# Expõe a porta 3200 para ser acessível externamente
EXPOSE 3200

# Comando para iniciar o servidor Rails
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0' -p 3200"]