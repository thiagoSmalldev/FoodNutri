# app/jobs/import_data_job.rb
class ImportDataJob < ApplicationJob
  queue_as :default

  def perform
    require 'open-uri'
    require 'zlib'
    require 'json'

    begin
      # URL para a lista de arquivos do Open Food Facts
      files_index_url = 'https://challenges.coode.sh/food/data/json/index.txt'

      # Recupera a lista de arquivos disponíveis
      files = open(files_index_url).readlines.map(&:strip)

      files.each do |file|
        # URL completa para o arquivo compactado
        file_url = "https://challenges.coode.sh/food/data/json/#{file}"

        # Abre o arquivo compactado
        gzipped_data = open(file_url, 'rb').read

        # Descomprime o arquivo compactado
        json_data = Zlib::GzipReader.new(StringIO.new(gzipped_data)).read

        # Analisa o JSON em objetos Ruby
        data = JSON.parse(json_data)

        # Limita a importação a 100 produtos de cada arquivo
        products_to_import = data['products'].first(100)

        products_to_import.each do |product_data|
          # Verifica se o produto já existe na base de dados
          product = Food.find_by(code: product_data['code'])

          if product.nil?
            # Se o produto não existir, cria um novo
            Food.create!(
              code: product_data['code'],
              imported_t: Time.now,
              status: 'draft',
              url: product_data['url'],
              creator: product_data['creator'],
              created_t: Time.at(product_data['created_t']),
              last_modified_t: Time.at(product_data['last_modified_t']),
              product_name: product_data['product_name'],
              quantity: product_data['quantity'],
              brands: product_data['brands'],
              categories: product_data['categories'],
              labels: product_data['labels'],
              cities: product_data['cities'],
              purchase_places: product_data['purchase_places'],
              stores: product_data['stores'],
              ingredients_text: product_data['ingredients_text'],
              traces: product_data['traces'],
              serving_size: product_data['serving_size'],
              serving_quantity: product_data['serving_quantity'],
              nutriscore_score: product_data['nutriscore_score'],
              nutriscore_grade: product_data['nutriscore_grade'],
              main_category: product_data['main_category'],
              image_url: product_data['image_url']
              # Adicione outros campos conforme necessário
            )
          else
            # Se o produto já existir, atualiza os campos
            product.update!(
              imported_t: Time.now,
              status: 'draft',
              url: product_data['url'],
              creator: product_data['creator'],
              created_t: Time.at(product_data['created_t']),
              last_modified_t: Time.at(product_data['last_modified_t']),
              product_name: product_data['product_name'],
              quantity: product_data['quantity'],
              brands: product_data['brands'],
              categories: product_data['categories'],
              labels: product_data['labels'],
              cities: product_data['cities'],
              purchase_places: product_data['purchase_places'],
              stores: product_data['stores'],
              ingredients_text: product_data['ingredients_text'],
              traces: product_data['traces'],
              serving_size: product_data['serving_size'],
              serving_quantity: product_data['serving_quantity'],
              nutriscore_score: product_data['nutriscore_score'],
              nutriscore_grade: product_data['nutriscore_grade'],
              main_category: product_data['main_category'],
              image_url: product_data['image_url']
              # Atualize outros campos conforme necessário
            )
          end
        end
      end

    rescue Errno::ENOENT => e
      # Lida com o erro de arquivo não encontrado
      Rails.logger.error("Erro ao acessar o arquivo index.txt: #{e.message}")
    rescue StandardError => e
      # Lida com outros erros
      Rails.logger.error("Erro durante a importação de dados: #{e.message}")
    end
  end
end
