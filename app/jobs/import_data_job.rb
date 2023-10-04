# app/jobs/import_data_job.rb
class ImportDataJob < ApplicationJob
  queue_as :default

  def perform
    require 'open-uri'
    require 'json'

    # URL para a lista de arquivos do Open Food Facts
    files_index_url = 'https://challenges.coode.sh/food/data/json/index.txt'

    # Recupera a lista de arquivos disponíveis
    files = open(files_index_url).readlines.map(&:strip)

    # Itera sobre cada arquivo
    files.each do |file|
      # URL completa para o arquivo de dados
      file_url = "https://challenges.coode.sh/food/data/json/#{file}"

      # Abre o arquivo JSON
      json_data = open(file_url).read

      # Analisa o JSON em objetos Ruby
      data = JSON.parse(json_data)

      # Limita a importação a 100 produtos por arquivo
      data['products'].first(100).each do |product_data|
        # Verifica se o produto já existe na base de dados
        product = Food.find_by(code: product_data['code'])

        if product.nil?
          # Se o produto não existir, cria um novo
          Food.create!(
            code: product_data['code'],
            imported_t: Time.now, # Define o campo imported_t com a data e hora atual
            status: 'draft',     # Define o status como 'draft'
            # Outros campos que você desejar importar
          )
        else
          # Se o produto já existir, atualiza os campos
          product.update!(
            imported_t: Time.now, # Atualiza o campo imported_t com a data e hora atual
            status: 'draft',     # Atualiza o status como 'draft'
            # Atualize outros campos, se necessário
          )
        end
      end
    end
  end
end
